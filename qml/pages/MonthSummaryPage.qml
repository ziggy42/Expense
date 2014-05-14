import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../JS/dbmanager.js" as DBmanager
import "../JS/preferences.js" as Preferences

Page {
    id: monthSummaryPage

    property var period
    property var uglyperiod

    ListModel {id: monthExpensesModel}

    Component.onCompleted: {
        var expenses = DBmanager.getSpentThisMonth(uglyperiod)
        for(var i = 0; i < expenses.length; i++) {
            monthExpensesModel.append({"amount":expenses[i].amount, "desc":expenses[i].desc, "category":expenses[i].category})
            console.log(expenses[1].amount + expenses[i].desc + " " + expenses[i].category)
        }
    }

    SilicaListView {
        id: listView

        model: monthExpensesModel
        anchors.fill: parent

        header: PageHeader {
            title: period
        }

        delegate: BackgroundItem {
            id: delegate
            height: 100

            Label {
                x: Theme.paddingLarge*2
                id: dateAmountRow
                text: amount + " " + Preferences.getCurrency() + " in " + category
                color: Theme.highlightColor
            }

            Label {
                id: descLabel
                text: desc
                visible: (desc !== undefined)
                color: Theme.primaryColor
                x: Theme.paddingLarge*2
                anchors {
                    top: dateAmountRow.bottom
                    topMargin: Theme.paddingSmall
                }
            }
        }
        VerticalScrollDecorator {}
    }
}
