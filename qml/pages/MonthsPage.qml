import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../JS/dbmanager.js" as DBmanager
import "../JS/preferences.js" as Preferences

Page {
    id: monthsPage

    property var months

    ListModel {id: monthsModel}

    function makeMeACoolMonth(date) {
        // note: constructor takes months values (0-11)!!
        var d = new Date(parseInt(date.substring(2,6)),
                         parseInt(date.substring(0,2)-1))

        return Qt.formatDate(d, "MMMM yyyy")
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
            title: qsTr("History")
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
                valueText: qsTr("%1 %2", "1 is amount and 2 is currency").arg(value).arg(Preferences.getCurrency())
                label: makeMeACoolMonth(month)
            }

            onClicked: {
                pageStack.push(Qt.resolvedUrl("MonthSummaryPage.qml"),{"period":makeMeACoolMonth(month),"uglyperiod":month})
            }
        }
        VerticalScrollDecorator {}
    }
}
