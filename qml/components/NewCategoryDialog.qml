import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property string name

    Label {
        id: selectLabel
        text: "Choose a Name"
        anchors {
            top: parent.top
            topMargin: Theme.paddingLarge
            horizontalCenter: parent.horizontalCenter
        }
        color: Theme.secondaryHighlightColor
        font.pixelSize: Theme.fontSizeExtraLarge
    }

    TextField {
        id: nameField
        width: parent.width
        anchors {
            top: selectLabel.bottom
            topMargin: Theme.paddingLarge
        }

        placeholderText: "Name"
    }

    onDone: {
        if (result === DialogResult.Accepted) {
            name = nameField.text
        }
    }
}
