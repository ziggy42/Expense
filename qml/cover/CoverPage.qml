import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../JS/dbmanager.js" as DBmanager
import "../JS/preferences.js" as Preferences

CoverBackground {

    onStatusChanged: label.text = parseInt(DBmanager.getTotalChargeThisMonth(0)) + " " + Preferences.getCurrency()

    Label {
        id: headerLabel
        anchors {
            bottom: label.top
            bottomMargin: 10
            horizontalCenter: parent.horizontalCenter
        }
        text: "This month:"
        color: Theme.highlightColor
        font.pixelSize: Theme.fontSizeLarge
    }

    Label {
        id: label
        anchors.centerIn: parent
        color: Theme.highlightColor
        font.pixelSize: Theme.fontSizeLarge
        text: parseInt(DBmanager.getTotalChargeThisMonth(0)) + " " + Preferences.getCurrency()
    }
}

