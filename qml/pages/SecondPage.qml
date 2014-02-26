import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../JS/dbmanager.js" as DBmanager


Page {
    id: categoriesPage

    property alias categories: listView.model
    property string newCategory

    Component.onCompleted: {
        categories = DBmanager.getAllCategories()
    }

    SilicaListView {
        id: listView

        PullDownMenu {
            MenuItem {
                text: "Add Category"
                onClicked: {
                    var dialog = pageStack.push(Qt.resolvedUrl("../components/NewCategoryDialog.qml"), {"name": newCategory})
                    dialog.accepted.connect(function() {
                        console.log(DBmanager.insertCategory(dialog.name))
                        categories = DBmanager.getAllCategories()
                    })
                }
            }
        }

        model: categories
        anchors.fill: parent

        header: PageHeader {
            title: "Categories"
        }

        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.paddingLarge
                text: categories[index]
                anchors.verticalCenter: parent.verticalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: {
                pageStack.push(Qt.resolvedUrl("CategoryPage.qml"),{"categoryName":categories[index]})
            }
        }
        VerticalScrollDecorator {}
    }
}





