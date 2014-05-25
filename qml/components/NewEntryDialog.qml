import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../JS/dbmanager.js" as DBmanager

Dialog {
    property string category
    property real amount
    property string desc
    property string date

    property alias categories: silicaListView.model

    Component.onCompleted: {
        categories = DBmanager.getAllCategories()
        if(category !== "") categoryLabel.text = category
        amountField.focus = true
    }

    Label {
        id: newEntryLabel
        text: qsTr("New Entry")
        anchors {
            top: parent.top
            topMargin: Theme.paddingLarge
            horizontalCenter: parent.horizontalCenter
        }
        color: Theme.secondaryHighlightColor
        font.pixelSize: Theme.fontSizeExtraLarge
    }

    TextField {
        id: amountField
        width: parent.width
        anchors {
            top: newEntryLabel.bottom
            topMargin: Theme.paddingLarge
        }
        placeholderText: qsTr("Amount", "placeholder for amount")
        inputMethodHints: Qt.ImhFormattedNumbersOnly
    }

    TextField {
        id: descField
        width: parent.width
        anchors {
            top: amountField.bottom
            topMargin: Theme.paddingLarge
        }
        placeholderText: qsTr("Desc", "placeholder for description")
    }

    Row {
        id: showCategoriesRow
        anchors {
            top: descField.bottom
            topMargin: Theme.paddingLarge
            horizontalCenter: parent.horizontalCenter
        }
        spacing: Theme.paddingLarge

        Button {
            text: qsTr("Choose Category")
            anchors.verticalCenter: parent.verticalCenter
            onClicked: categoriesDrawer.open = !categoriesDrawer.open
        }

        Label {
            id: categoryLabel
            text: categories[silicaListView.currentIndex]
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeLarge
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Drawer {
        id: categoriesDrawer
        open: false
        width: parent.width
        height: 500*2
        anchors {
            top: showCategoriesRow.bottom
            topMargin: Theme.paddingLarge
        }

        background: SilicaListView {
            id: silicaListView
            anchors.fill: parent

            delegate: BackgroundItem {
                id: delegate

                Label {
                    x: Theme.paddingLarge
                    text: categories[index]
                    anchors.verticalCenter: parent.verticalCenter
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                onClicked: {
                    categoryLabel.text = categories[index]
                    categoriesDrawer.open = false
                }
            }
        }
    }

    onDone: {
        if (result === DialogResult.Accepted) {
            var currentDate = Qt.formatDateTime(new Date(), "ddMMyyyy");
            DBmanager.insertCharge(categoryLabel.text,amountField.text,descField.text,currentDate)
        }
    }
}
