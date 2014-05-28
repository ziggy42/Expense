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
        var now = new Date()
        for(var i = 0; i < expenses.length; i++) {
            var d = new Date(parseInt(expenses[i].date.substring(4,8)),
                             parseInt(expenses[i].date.substring(2,4)-1),
                             parseInt(expenses[i].date.substring(0,2)))

            var formatedDate = Qt.formatDate(d, Qt.DefaultLocaleShortDate)
            if (d.getDate() === now.getDate() && d.getMonth() === now.getMonth() && d.getFullYear() === now.getFullYear())
                formatedDate = qsTr('Today')

            monthExpensesModel.append({ "amount":   expenses[i].amount,
                                        "desc":     expenses[i].desc,
                                        "category": expenses[i].category,
                                        "date":     formatedDate
                                      })
        }
    }

    SilicaListView {
        id: listView
        model: monthExpensesModel
        anchors.fill: parent

        header: PageHeader {
            title: period
        }

        section {
            property: 'date'

            delegate: SectionHeader {
                text: section
                height: Theme.itemSizeExtraSmall
            }
        }

        delegate: BackgroundItem {
            id: delegate
            height: 100

            Label {
                x: Theme.paddingLarge*2
                id: dateAmountRow
                text: qsTr("%1 %2 in %3", "1 is amount, 2 is currency and 3 is the category")
                            .arg(amount)
                            .arg(Preferences.getCurrency())
                            .arg(category)
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
