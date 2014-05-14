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
            spacing: Theme.paddingSmall

            PageHeader {
                title: "Contacts"
            }

            Row {
                anchors {horizontalCenter: parent.horizontalCenter}
                Label { font.bold: true; text: "Author: " }
                Label { text: "Andrea Pivetta"}
            }

            Row{
                anchors {horizontalCenter: parent.horizontalCenter}
                Label { font.bold: true; text: "Home Page: "}
                Label { text: "<a href=\"http://andreapivetta.altervista.org/\">blog</a>"; onLinkActivated: Qt.openUrlExternally(link)}
            }

            Row {
                anchors {horizontalCenter: parent.horizontalCenter}
                Label { font.bold: true; text: "Mail: "}
                Label { text: "vanpivix@gmail.com"}
            }

            Row {
                anchors {horizontalCenter: parent.horizontalCenter}
                Label { font.bold: true; text: "Twitter: "}
                Label { text: "<a href=\"https://twitter.com/Pivix00\">@Pivix00</a>"; onLinkActivated: Qt.openUrlExternally(link)}
            }
        }
    }
}
