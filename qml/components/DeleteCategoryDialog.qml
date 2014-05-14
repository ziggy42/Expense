import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../JS/dbmanager.js" as DBmanager

Dialog {
    property string category

    function isTheChoosenOne(page) {
        if((page + "").indexOf("FirstPage") > -1)
            return true;
        return false;
    }

    acceptDestinationAction: PageStackAction.Pop
    acceptDestination: pageStack.find(isTheChoosenOne);

    Label {
        id: deleteCategoryLabel
        text: "Delete Category"
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
        text: "!"

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
        text: "All your data related with this category will be lost!!"
    }


    onDone: {
        if (result === DialogResult.Accepted) {
            DBmanager.deleteCategory(category);
        }
    }
}
