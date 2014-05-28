import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../JS/dbmanager.js" as DBmanager

Dialog {

    Label {
        id: deleteCategoryLabel
        text: qsTr("Reset Database")
        anchors {
            top: parent.top
            topMargin: Theme.paddingLarge
            horizontalCenter: parent.horizontalCenter
        }
        color: Theme.secondaryHighlightColor
        font.pixelSize: Theme.fontSizeExtraLarge
    }

    Label {
        id: warningLabel
        anchors {
            top: deleteCategoryLabel.bottom
            topMargin: Theme.paddingLarge
            horizontalCenter: parent.horizontalCenter
        }
        font.pixelSize: Theme.fontSizeExtraLarge*5
        color: Theme.highlightColor
        wrapMode: Text.WordWrap
        horizontalAlignment: TextInput.AlignHCenter
        width: parent.width*0.8
        text: qsTr("!", "The exclamation mark in the DeleteCategory View")
    }

    Label {
        id: secondWarningLabel
        anchors {
            top: warningLabel.bottom
            topMargin: Theme.paddingLarge
            horizontalCenter: parent.horizontalCenter
        }
        color: Theme.highlightColor
        wrapMode: Text.WordWrap
        horizontalAlignment: TextInput.AlignHCenter
        width: parent.width*0.8
        text: qsTr("All your data will be irreversibly lost!!")
    }


    onDone: {
        if (result === DialogResult.Accepted) {
            DBmanager.reset()
            DBmanager.initializeDatabase()
        }
    }
}
