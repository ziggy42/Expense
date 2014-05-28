import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../JS/preferences.js" as Preferences

Page {
    id: contactsPage

    SilicaFlickable {
        anchors.fill: parent

        contentHeight: column.height

        Column {
            id: column
            width: contactsPage.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("About")
            }

            Label {
                text: qsTr("Expense")
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeExtraLarge*1.5
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                source: "/usr/share/icons/hicolor/86x86/apps/harbour-expense.png"
                width: parent.width *0.2
                height: width
            }

            Label {
                text: "1.6"
                font.pixelSize: Theme.fontSizeTiny
                color: Theme.secondaryHighlightColor
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Label {
                text: qsTr("A simple app to manage your money")
                color: Theme.secondaryHighlightColor
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "<a href=\"https://github.com/ziggy42/Expense/\">Github</a>";
                onLinkActivated: Qt.openUrlExternally(link)
            }
        }
    }
}
