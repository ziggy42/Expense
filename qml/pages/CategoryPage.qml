import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../JS/dbmanager.js" as DBmanager
import "../JS/preferences.js" as Preferences


Page {
    id: page

    property string categoryName
    property int percentage
    property var expenses
    property int totalThisMonth

    function refresh() {
        model.clear()
        expenses = DBmanager.getSpentThisMonthInCategory(categoryName)
        for(var i = 0; i < expenses.length; i++) {
            model.append({"amount" : expenses[i].amount, "desc" : expenses[i].desc, "date" : expenses[i].date})
        }
    }

    function makeMeABeautifulDate(date) {
        var day = date.substring(0,2)
        var month = date.substring(2,4)
        var year = date.substring(6)
        return day + "-" + month + "-" + year
    }

    Component.onCompleted: {
        percentage = DBmanager.getPercentageForCategory(categoryName)
        totalThisMonth = DBmanager.getTotalSpentThisMonthInCategory(categoryName)
        animationTimer.running = true

        expenses = DBmanager.getSpentThisMonthInCategory(categoryName)
        for(var i = 0; i < expenses.length; i++) {
            model.append({"amount" : expenses[i].amount, "desc" : expenses[i].desc, "date" : expenses[i].date})
        }
    }

    ListModel {id: model}

    Timer {
        id: animationTimer
        interval: 40
        repeat: true
        running: false
        onTriggered: {
            if(percentIndicator.value < percentage) percentIndicator.value++;
            else stop()
        }
    }

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: "Delete Category"
                onClicked: {
                    var dialog = pageStack.push(Qt.resolvedUrl("../components/DeleteCategoryDialog.qml"),{"category":categoryName})
                }
            }

            MenuItem {
                text: "Add"
                onClicked: {
                    var dialog = pageStack.push(Qt.resolvedUrl("../components/NewEntryDialog.qml"),{"category":categoryName})
                    dialog.accepted.connect(function() {
                        percentIndicator.value = 0
                        percentage = DBmanager.getPercentageForCategory(categoryName)
                        animationTimer.running = true

                        totalThisMonth = DBmanager.getTotalSpentThisMonthInCategory(categoryName)

                        model.clear()
                        expenses = DBmanager.getSpentThisMonthInCategory(categoryName)
                        for(var i = 0; i < expenses.length; i++) {
                            model.append({"amount" : expenses[i].amount, "desc" : expenses[i].desc, "date" : expenses[i].date})
                        }
                    })
                }
            }
        }

        contentHeight: column.height

        Column {
            id: column

            width: page.width
            spacing: Theme.paddingSmall
            PageHeader {
                title: categoryName
            }

            Label {
                id: moneyLabel
                text: totalThisMonth + " " + Preferences.getCurrency()
                anchors {horizontalCenter: parent.horizontalCenter}
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge*3
            }

            Label {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                text: "in " + categoryName + " this month"
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeLarge
            }

        }

        ProgressBar {
            id: percentIndicator
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: column.bottom
                topMargin: Theme.paddingLarge
            }

            width: parent.width

            minimumValue: 0
            maximumValue: 100
            value: 0
            valueText: value + "%"
            label: "of the total"
        }

        Label {
            id: insertionsLabel
            x: Theme.paddingLarge
            anchors {
                top: percentIndicator.bottom
                topMargin: Theme.paddingLarge*1.2
            }
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeLarge
            text: "This month:"
        }

        SilicaListView {
            id: expensesListView
            model: model
            anchors {
                top: insertionsLabel.bottom
                topMargin: Theme.paddingLarge
            }

            clip:true
            width: parent.width
            height: page.height - column.height - percentIndicator.height - insertionsLabel.height - Theme.paddingLarge*2*1.2 - Theme.paddingSmall

            delegate: BackgroundItem {
                id: delegate
                height: 100

                Row {
                    id: dateAmountRow
                    x: Theme.paddingLarge*2
                    spacing: Theme.paddingLarge

                    Label {
                        id: dateLabel
                        text: makeMeABeautifulDate(date)
                        color: Theme.primaryColor
                    }

                    Label {
                        id: amountLabel
                        text: "amount: " + amount + " " + Preferences.getCurrency()
                        color: Theme.primaryColor
                    }
                }

                Label {
                    id: descLabel
                    text: desc
                    visible: (desc !== undefined)
                    color: Theme.highlightColor
                    x: Theme.paddingLarge*2
                    anchors {
                        top: dateAmountRow.bottom
                        topMargin: Theme.paddingSmall
                    }
                }

                onPressAndHold: {
                    console.log("Delete current Item")
                    var dialog = pageStack.push(Qt.resolvedUrl("../components/DeleteEntryDialog.qml"),{"category":categoryName,"amount": amount, "desc": desc, "date": date})
                    dialog.accepted.connect(function() {
                        percentIndicator.value = 0
                        percentage = DBmanager.getPercentageForCategory(categoryName)
                        animationTimer.running = true

                        totalThisMonth = DBmanager.getTotalSpentThisMonthInCategory(categoryName)

                        refresh()
                    })
                }
            }
            VerticalScrollDecorator {}
        }
    }
}
