import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../JS/dbmanager.js" as DBmanager
import "../JS/preferences.js" as Preferences

Page {
    id: monthsPage

    property var months

    ListModel {id: monthsModel}

    function makeMeACoolMonth(temp) {
        var month = temp.substring(0,2);
        var monthStr = ""

        switch(parseInt(month)) {
            case 1:
                monthStr = "January"
                break;
            case 2:
                monthStr = "February"
                break;
            case 3:
                monthStr = "March"
                break;
            case 4:
                monthStr = "April"
                break;
            case 5:
                monthStr = "May"
                break;
            case 6:
                monthStr = "June"
                break;
            case 7:
                monthStr = "July"
                break;
            case 8:
                monthStr = "August"
                break;
            case 9:
                monthStr = "September"
                break;
            case 10:
                monthStr = "October"
                break;
            case 11:
                monthStr = "November"
                break;
            case 12:
                monthStr = "December"
                break;
        }
        return monthStr + " " + temp.substring(2);
    }

    Component.onCompleted: {
        months = DBmanager.getAllMonths()
        for(var i = 0; i < months.length; i++)
            monthsModel.append({"month" : months[i]})
    }

    SilicaListView {
        id: listView
        model: monthsModel
        anchors.fill: parent

        header: PageHeader {
            title: "History"
        }

        delegate: BackgroundItem {
            id: delegate
            height: 160

            ProgressBar {
                id: percentIndicator
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
                minimumValue: 0
                maximumValue: DBmanager.getFuckingTotal()
                value: DBmanager.getTotalByMonthAndYear(month)
                valueText: value + " " + Preferences.getCurrency()
                label: makeMeACoolMonth(month)
            }

            onClicked: {
                pageStack.push(Qt.resolvedUrl("MonthSummaryPage.qml"),{"period":makeMeACoolMonth(month),"uglyperiod":month})
            }
        }
        VerticalScrollDecorator {}
    }
}
