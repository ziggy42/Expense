import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../JS/preferences.js" as Preferences
import "../JS/dbmanager.js" as DBmanager

Page {
    id: settingsPage

    property var options: ['€','£','$']

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
                    MenuItem { text: options[0] }
                    MenuItem { text: options[1] }
                    MenuItem { text: options[2] }
                }

                onCurrentIndexChanged: Preferences.set("Currency",currentIndex)
            }

            Button {
                id: resetButton
                width: parent.width * 0.75
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                text: qsTr("Reset Database")
                onClicked: pageStack.push(Qt.resolvedUrl("../components/ResetDatabaseDialog.qml"))
            }

            Button {
                id: contactLabel
                width: parent.width * 0.75
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                text: qsTr("Contact the Developer")

                onClicked: pageStack.push(Qt.resolvedUrl("ContactsPage.qml"))
            }
        }
    }
}
