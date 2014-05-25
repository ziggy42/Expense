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
        // note: constructor takes months values (0-11)!!
        var d = new Date(parseInt(date.substring(4,8)),
                         parseInt(date.substring(2,4)-1),
                         parseInt(date.substring(0,2)))

        return Qt.formatDate(d, Qt.DefaultLocaleShortDate)
    }

    Label {
        id: newEntryLabel
        text: qsTr("Delete Item")
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
            text: qsTr("amount: %1 %2", "1 is amount and 2 is currency").arg(amount).arg(Preferences.getCurrency())
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
