import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../JS/preferences.js" as Preferences

Dialog {

    Label {
        id: newCurrencyLabel
        text: qsTr("New Currency")
        anchors {
            top: parent.top
            topMargin: Theme.paddingLarge
            horizontalCenter: parent.horizontalCenter
        }
        color: Theme.secondaryHighlightColor
        font.pixelSize: Theme.fontSizeExtraLarge
    }

    TextField {
        id: currencyField
        width: parent.width
        anchors {
            top: newCurrencyLabel.bottom
            topMargin: Theme.paddingLarge
        }
        placeholderText: qsTr("Currency", "placeholder for currency")
    }

    onDone: {
        if (result === DialogResult.Accepted) {
            Preferences.addCurrency(currencyField.text)
        }
        appWindow.quickAddOpen = false
    }
}
