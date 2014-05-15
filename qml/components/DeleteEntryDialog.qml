import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../JS/dbmanager.js" as DBmanager
import "../JS/preferences.js" as Preferences

Dialog {
    property string category
    property var amount
    property string desc
    property string date

    function makeMeABeautifulDate(date) {
        var day = date.substring(0,2)
        var month = date.substring(2,4)
        var year = date.substring(6)
        return day + "-" + month + "-" + year
    }

    Label {
        id: newEntryLabel
        text: "Delete Item"
        anchors {
            top: parent.top
            topMargin: Theme.paddingLarge
            horizontalCenter: parent.horizontalCenter
        }
        color: Theme.secondaryHighlightColor
        font.pixelSize: Theme.fontSizeExtraLarge
    }

    Row {
        id: dateAmountRow
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: newEntryLabel.bottom
            topMargin: Theme.paddingLarge*2
        }
        spacing: Theme.paddingLarge

        Label {
            id: dateLabel
            text: makeMeABeautifulDate(date)
            color: Theme.highlightColor
        }

        Label {
            id: amountLabel
            text: "amount: " + amount + " " + Preferences.getCurrency()
            color: Theme.highlightColor
        }
    }

    Label {
        id: descLabel
        text: desc
        visible: (desc !== undefined)
        color: Theme.highlightColor

        anchors {
            top: dateAmountRow.bottom
            topMargin: Theme.paddingSmall
            horizontalCenter: parent.horizontalCenter
        }
    }

    onDone: {
        if (result === DialogResult.Accepted)
            DBmanager.deleteItem(category,amount,desc,date)
    }
}
