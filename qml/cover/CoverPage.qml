import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../JS/dbmanager.js" as DBmanager
import "../JS/preferences.js" as Preferences

CoverBackground {

    onStatusChanged: label.text = parseInt(DBmanager.getTotalChargeThisMonth(0)) + " " + Preferences.getCurrency()

    Column {
           anchors.centerIn: parent
           width: parent.width
           spacing: Theme.paddingMedium

           Image {
               anchors.horizontalCenter: parent.horizontalCenter
               source: "/usr/share/icons/hicolor/86x86/apps/harbour-expense.png"
           }

           Label {
               anchors.horizontalCenter: parent.horizontalCenter
               text: "This month:"
               color: Theme.highlightColor
               font.pixelSize: Theme.fontSizeMedium
           }

           Label {
               id: label
               anchors.horizontalCenter: parent.horizontalCenter
               color: Theme.highlightColor
               font.pixelSize: Theme.fontSizeLarge
               text: parseInt(DBmanager.getTotalChargeThisMonth(0)) + " " + Preferences.getCurrency()
           }
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-cover-new"
            onTriggered: {
                var dialog = pageStack.push(Qt.resolvedUrl("../components/NewEntryDialog.qml"))
                appWindow.activate();
            }
        }
    }
}

