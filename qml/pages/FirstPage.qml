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
        if(DBmanager.getNumberOftables() === 0)
            DBmanager.initializeDatabase()
    }

    onStatusChanged: {
        if(page.status === PageStatus.Activating) {
            totalCount = parseInt(DBmanager.getTotalChargeThisMonth(0)) + " " + Preferences.getCurrency()
            totalCountLastMonth = qsTr("Last Month: %1 %2", "1 is amount and 2 is currency")
                                    .arg(parseInt(DBmanager.getTotalChargeThisMonth(-1)))
                                    .arg(Preferences.getCurrency())
            total = qsTr("Total: %1 %2", "1 is amount and 2 is currency")
                                    .arg(parseInt(DBmanager.getFuckingTotal()))
                                    .arg(Preferences.getCurrency())
            mostUsedCategory = qsTr("Most used category: %1").arg(DBmanager.getMostUsedCategory())
        }
    }

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("History")
                onClicked: pageStack.push(Qt.resolvedUrl("MonthsPage.qml"))
            }

            MenuItem {
                text: qsTr("Categories")
                onClicked: pageStack.push(Qt.resolvedUrl("SecondPage.qml"))
            }
            MenuItem {
                text: qsTr("Quick Add")
                onClicked: {
                    var dialog = pageStack.push(Qt.resolvedUrl("../components/NewEntryDialog.qml"))
                    dialog.accepted.connect(function() {
                        totalCount = parseInt(DBmanager.getTotalChargeThisMonth(0)) + " " + Preferences.getCurrency()
                        total = qsTr("Total: %1 %2", "1 is amount and 2 is currency")
                                    .arg(parseInt(DBmanager.getFuckingTotal()))
                                    .arg(Preferences.getCurrency())
                        mostUsedCategory = qsTr("Most used category: %1").arg(DBmanager.getMostUsedCategory())
                    })
                }
            }
        }

        PushUpMenu {
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
        }

        contentHeight: column.height

        Column {
            id: column
            width: page.width
            spacing: Theme.paddingSmall

            PageHeader {
                title: qsTr("Expense", "This is the App Title")
            }

            Label {
                id: moneyLabel
                anchors { horizontalCenter: parent.horizontalCenter }
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge*3
            }

            Label {
                anchors { horizontalCenter: parent.horizontalCenter }
                text: qsTr("spent this month", "subtitle of the amount spent in the MainView")
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

