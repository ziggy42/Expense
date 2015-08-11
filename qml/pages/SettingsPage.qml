import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../JS/preferences.js" as Preferences
import "../JS/dbmanager.js" as DBmanager

Page {
    id: settingsPage

    property var options: Preferences.getAllCurrencies()

    SilicaFlickable {
        anchors.fill: parent

        /* PullDownMenu {
            MenuItem {
                text: qsTr("Restore Default")
                onClicked: {
                    Preferences.set("Currency",0)
                    currencyComboBox.currentIndex = 0
                }
            }
        } */

        contentHeight: column.height

        Column {
            id: column
            width: settingsPage.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("Settings")
            }

            ComboBox {
                id: currencyComboBox
                width: parent.width * 0.75
                anchors {horizontalCenter: parent.horizontalCenter}
                label: qsTr("Currency: ")
                currentIndex: Preferences.get("Currency",0)

                menu: ContextMenu {
                    Repeater {
                        model: options
                        MenuItem { text: options[index]}
                    }
                }

                onCurrentIndexChanged: Preferences.set("Currency",currentIndex)
            }

            Button {
                id: addCustomCurrency
                width: parent.width * 0.7
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Add New Currency")

                onClicked: {
                    var dialog = pageStack.push(Qt.resolvedUrl("../components/AddCurrencyDialog.qml"))
                    dialog.accepted.connect(function() {
                        options = Preferences.getAllCurrencies()
                    })
                }
            }

            Button {
                id: resetButton
                width: parent.width * 0.7
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Reset Database")

                onClicked: pageStack.push(Qt.resolvedUrl("../components/ResetDatabaseDialog.qml"))
            }

            Button {
                id: contactLabel
                width: parent.width * 0.7
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("About")

                onClicked: pageStack.push(Qt.resolvedUrl("ContactsPage.qml"))
            }
        }
    }
}
