import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../JS/dbmanager.js" as DBmanager
import "../JS/preferences.js" as Preferences

Page {
    id: page

    property alias totalCount: moneyLabel.text
    property alias totalCountLastMonth: lastMonthLabel.text
    property alias total: totalLabel.text
    property alias mostUsedCategory: mostUsedCategoryLabel.text

    Component.onCompleted: {
        if(DBmanager.getNumberOftables() !== 2)
            DBmanager.initializeDatabase()
    }

    onStatusChanged: {
        if(page.status === PageStatus.Activating) {
            totalCount = parseInt(DBmanager.getTotalChargeThisMonth(0)) + " " + Preferences.getCurrency()
            totalCountLastMonth = "Last Month: " + parseInt(DBmanager.getTotalChargeThisMonth(-1)) + " " + Preferences.getCurrency()
            total = "Total: " + parseInt(DBmanager.getFuckingTotal()) + " " + Preferences.getCurrency()
            mostUsedCategory = "Most used category: " + DBmanager.getMostUsedCategory()
        }
    }

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: "History"
                onClicked: pageStack.push(Qt.resolvedUrl("MonthsPage.qml"))
            }

            MenuItem {
                text: "Categories"
                onClicked: pageStack.push(Qt.resolvedUrl("SecondPage.qml"))
            }
            MenuItem {
                text: "Quick Add"
                onClicked: {
                    var dialog = pageStack.push(Qt.resolvedUrl("../components/NewEntryDialog.qml"))
                    dialog.accepted.connect(function() {
                        totalCount = parseInt(DBmanager.getTotalChargeThisMonth(0)) + " " + Preferences.getCurrency()
                        total = "Total: " + parseInt(DBmanager.getFuckingTotal()) + " " + Preferences.getCurrency()
                        mostUsedCategory = "Most used category: " + DBmanager.getMostUsedCategory()
                    })
                }
            }
        }

        PushUpMenu {
            MenuItem {
                text: "Settings"
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
        }

        contentHeight: column.height

        Column {
            id: column
            width: page.width
            spacing: Theme.paddingSmall

            PageHeader {
                title: "Expense"
            }

            Label {
                id: moneyLabel
                anchors { horizontalCenter: parent.horizontalCenter }
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge*3
            }

            Label {
                anchors { horizontalCenter: parent.horizontalCenter }
                text: "spent this month"
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeLarge
            }
        }

        Label {
            id: lastMonthLabel
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: column.bottom
                topMargin: Theme.paddingLarge*15
            }
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeMedium
        }

        Label {
            id: totalLabel
            text: "Total: 5899 €"
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: lastMonthLabel.bottom
                topMargin: Theme.paddingLarge
            }
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeMedium
        }

        Label {
            id: mostUsedCategoryLabel
            text: "Most used category: Heroin"
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: totalLabel.bottom
                topMargin: Theme.paddingLarge
            }
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeMedium
        }
    }
}

