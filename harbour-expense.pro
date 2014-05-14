# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-expense

CONFIG += sailfishapp

SOURCES += src/harbour-expense.cpp

OTHER_FILES += qml/harbour-expense.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/harbour-expense.spec \
    rpm/harbour-expense.yaml \
    harbour-expense.desktop \
    JS/dbmanager.js \
    qml/components/NewCategoryDialog.qml \
    qml/components/NewEntryDialog.qml \
    qml/pages/CategoryPage.qml \
    qml/components/DeleteEntryDialog.qml \
    qml/pages/MonthsPage.qml \
    qml/components/DeleteCategoryDialog.qml \
    qml/JS/preferences.js \
    qml/pages/SettingsPage.qml

