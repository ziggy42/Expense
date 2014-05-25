/*
  Si deve aggiungere per forza un ID che faccia da primary key a expense.
  Attualmente se ho due entrate nello stesso giorno nella stessa categoria per gli stessi soldi e con la stessa descrizione
  e ne cancello uno il sistema li cancella entrambi (o gli n)
  */

function getDatabase() {
     return LocalStorage.openDatabaseSync("Categories", "1.0", "StorageDatabase", 1000000);
}

function getNumberOftables() {
    var db = getDatabase();
    var query = "SELECT COUNT(*) AS number_of_tables FROM sqlite_master WHERE type='table'";
    var res

    db.transaction(
        function(tx) {
            var rs = tx.executeSql(query);
            var dbItem = rs.rows.item(0);
            res = dbItem.number_of_tables
        }
    );
    return res;
}

function initializeDatabase() {
    var db = getDatabase();

    db.transaction(
        function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS categories(category TEXT NOT NULL PRIMARY KEY)');
            tx.executeSql('CREATE TABLE IF NOT EXISTS expense(category TEXT NOT NULL REFERENCES categories,amount REAL NOT NULL,desc TEXT,date TEXT NOT NULL)');

            tx.executeSql("INSERT INTO categories VALUES('Food')");
            tx.executeSql("INSERT INTO categories VALUES('Travels')");
        }
    );
}

function getAllCategories() {
    var db = getDatabase();
    var res = []

    db.transaction(
        function(tx) {
            var rs = tx.executeSql('SELECT category FROM categories');
            for(var i = 0; i < rs.rows.length; i++) {
                var dbItem = rs.rows.item(i);
                res.push(dbItem.category);
            }
        }
    );
    return res;
}

function getAllMonths() {
    var db = getDatabase();
    var res = []

    db.transaction(
        function(tx) {
            var rs = tx.executeSql('SELECT DISTINCT date FROM expense');
            for(var i = 0; i < rs.rows.length; i++) {
                var dbItem = rs.rows.item(i);
                var month = dbItem.date.substring(2,4)
                var year = dbItem.date.substring(4)
                var item = month + year

                if(res.indexOf(item) === -1) {
                    res.push(item);
                }
            }
        }
    );
    return res;
}

function insertCategory(category) {
    var db = getDatabase()
    var res = ""

    db.transaction(
        function(tx) {
            var rs = tx.executeSql('INSERT INTO categories VALUES (?);', [category]);
            if (rs.rowsAffected > 0) {
                res = "Insert on CATEGORIES complited";
            } else {
                res = "Error";
            }
        }
    );
    return res;
}

function insertCharge(category,amount,desc,date) {
    var db = getDatabase()
    var res = ""

    if(category === "" || amount === "") {
        return "Something is null"
    }

    var value = parseFloat(amount.replace(',', '.'))

    db.transaction(
        function(tx) {
            var rs = tx.executeSql('INSERT INTO expense VALUES (?,?,?,?);', [category,value,desc,date]);
            if (rs.rowsAffected > 0) {
                res = "OK";
            } else {
                res = "Error";
            }
        }
    );
    return res;
}

function getTotalChargeInCategory(category) {
    var db = getDatabase();
    var result

    try {
        db.transaction(function(tx) {
            var rs = tx.executeSql('SELECT SUM(amount) AS Total FROM expense WHERE category=?;', [category]);
            var dbItem = rs.rows.item(0);
            result = dbItem.Total
       })
    } catch(e) {
        return 0;
    }
    return result
}

function getTotalChargeThisMonth(fact) {
    var db = getDatabase();
    var currentDate = new Date();
    var result
    var squery = (currentDate.getMonth() + 1 + fact) + "" +  currentDate.getFullYear();

    try {
        db.transaction(function(tx) {
            var rs = tx.executeSql(
                        "SELECT TOTAL(amount) AS Total FROM expense WHERE date LIKE '%" + squery + "%'");
            var dbItem = rs.rows.item(0);
            result = dbItem.Total
        })
    } catch(e) {
        console.log(e)
        return 0;
    }

    return result;
}

function getTotalByMonthAndYear(date) {
    var db = getDatabase();
    var result

    try {
        db.transaction(function(tx) {
            var rs = tx.executeSql(
                        "SELECT TOTAL(amount) AS Total FROM expense WHERE date LIKE '%" + date + "%'");
            var dbItem = rs.rows.item(0);
            result = dbItem.Total
        })
    } catch(e) {
        console.log(e)
        return 0;
    }

    //console.log("Input: " + date)
    //console.log("Output: " + result)

    return result;
}

function getMostUsedCategory() {
    var db = getDatabase();
    var result;

    var sqlQuery = "SELECT category FROM expense GROUP BY category HAVING COUNT(*) >= (SELECT COUNT(*) FROM expense E GROUP BY E.category ORDER BY COUNT(*) desc)";

    try {
        db.transaction(function(tx) {
            var rs = tx.executeSql(sqlQuery);
            var dbItem = rs.rows.item(0);
            result = dbItem.category
        })
    } catch(e) {
        console.log(e)
        return "";
    }
    return result;
}

function getTotalSpentThisMonthInCategory(category) {
    var db = getDatabase();
    var currentDate = new Date();
    var result
    var squery = (currentDate.getMonth() + 1) + "" +  currentDate.getFullYear();

    try {
        db.transaction(function(tx) {
            var rs = tx.executeSql(
                        "SELECT TOTAL(amount) AS Total FROM expense WHERE CATEGORY = ? AND date LIKE '%" + squery + "%'",[category]);
            var dbItem = rs.rows.item(0);
            result = dbItem.Total
        })
    } catch(e) {
        console.log(e)
        return 0;
    }

    return result;
}

function getSpentThisMonthInCategory(category) {
    var db = getDatabase();
    var result = new Array()
    var currentDate = new Date();
    var date = (currentDate.getMonth() + 1) + "" +  currentDate.getFullYear();

    try {
        db.transaction(function(tx) {
            var rs = tx.executeSql("SELECT amount,desc,date FROM expense WHERE category=? AND date LIKE '%" + date + "%'",[category]);
            for(var i = 0; i < rs.rows.length; i++) {
                var dbItem = rs.rows.item(i);
                result[i] = {
                    'amount': dbItem.amount,
                    'desc': dbItem.desc,
                    'date': dbItem.date
                }
            }
        })
    } catch(e) {
        console.log(e)
        return []
    }
    return result;
}


// uglyperiod è tipo 102014 (ottobre 2014)
function getSpentThisMonth(uglyperiod) {
    var db = getDatabase();
    var result = new Array()

    try {
        db.transaction(function(tx) {
            var rs = tx.executeSql("SELECT category,amount,desc,date FROM expense WHERE date LIKE '%" + uglyperiod + "%' ORDER BY date DESC");
            for(var i = 0; i < rs.rows.length; i++) {
                var dbItem = rs.rows.item(i);
                result[i] = {
                    'amount': dbItem.amount,
                    'desc': dbItem.desc,
                    'category': dbItem.category,
                    'date': dbItem.date
                }
            }
        })
    } catch(e) {
        console.log(e);
        return [];
    }
    return result;
}

function getFuckingTotal() {
    var db = getDatabase();
    var result;

    try {
        db.transaction(function(tx) {
            var rs = tx.executeSql(
                        "SELECT TOTAL(amount) AS Total FROM expense");
            var dbItem = rs.rows.item(0);
            result = dbItem.Total
        })
    } catch(e) {
        console.log(e)
        return 0;
    }

    return result;
}

function getPercentageForCategory(category) {
    var db = getDatabase();
    var total, current, rs, dbItem
    var currentDate = new Date();
    var date = (currentDate.getMonth() + 1) + "" +  currentDate.getFullYear();

    try {
        db.transaction( function(tx) {
            rs = tx.executeSql("SELECT SUM(amount) AS Total FROM expense WHERE date LIKE '%" + date + "%'")
            dbItem = rs.rows.item(0);
            total = dbItem.Total
        })

        db.transaction( function(tx) {
            rs = tx.executeSql("SELECT SUM(amount) AS Total FROM expense WHERE category=? AND date LIKE '%" + date + "%'", [category])
            dbItem = rs.rows.item(0)
            current = dbItem.Total
        })
    } catch(e) {
        console.log(e)
        return 0;
    }

    return parseInt((100*current)/total)
}

function getPercentageForCategoryTotal() {
    var db = getDatabase();
    var total
    var current
    var rs
    var dbItem

    try {
        db.transaction( function(tx) {
            rs = tx.executeSql("SELECT SUM(amount) AS Total FROM expense WHERE ")
            dbItem = rs.rows.item(0);
            total = dbItem.Total
        })

        db.transaction( function(tx) {
            rs = tx.executeSql("SELECT SUM(amount) AS Total FROM expense WHERE category=?", [category])
            dbItem = rs.rows.item(0)
            current = dbItem.Total
        })
    } catch(e) {
        console.log(e)
        return 0;
    }

    return parseInt((100*current)/total)
}

function deleteItem(category,amount,desc,date) {
    var db = getDatabase();
    var res, rs;

    db.transaction(function(tx) {
        if(desc === "") {
            rs = tx.executeSql('DELETE FROM expense WHERE category=? AND amount=? AND date=?;', [category,amount,date]);
        }
        else {
            rs = tx.executeSql('DELETE FROM expense WHERE category=? AND amount=? AND date=? AND desc=?;', [category,amount,date,desc]);
        }
        if (rs.rowsAffected > 0) res = "OK";
        else res = "Error";
    });

    return res;
}

function deleteCategory(category) {
    var db = getDatabase();
    var res, rs1, rs2;

    db.transaction(function(tx) {
        rs1 = tx.executeSql('DELETE FROM expense WHERE category=?;', [category]);
        rs2 = tx.executeSql("DELETE FROM categories WHERE category='" + category + "';");
        if (rs1.rowsAffected > 0 && rs2.rowsAffected > 0) res = "OK";
        else res = "Error";
    });

    return res;
}

function resetExpense() {
    var db = getDatabase();
    db.transaction(
        function(tx) {
            tx.executeSql('DROP TABLE expense');
      });
}

function reset() {
    var db = getDatabase();
    db.transaction(
        function(tx) {
            tx.executeSql('DROP TABLE expense');
            tx.executeSql('DROP TABLE categories')
      });
}
