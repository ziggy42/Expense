# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-expense

CONFIG += sailfishapp

SOURCES += src/harbour-expense.cpp

OTHER_FILES += qml/harbour-expense.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/harbour-expense.changes.in \
    rpm/harbour-expense.spec \
    rpm/harbour-expense.yaml \
    translations/harbour-expense*.ts \
    harbour-expense.desktop \
    qml/JS/dbmanager.js \
    qml/JS/preferences.js \
    qml/components/DeleteCategoryDialog.qml \
    qml/components/DeleteEntryDialog.qml \
    qml/components/NewCategoryDialog.qml \
    qml/components/NewEntryDialog.qml \
    qml/pages/CategoryPage.qml \
    qml/pages/ContactsPage.qml \
    qml/pages/MonthsPage.qml \
    qml/pages/MonthSummaryPage.qml \
    qml/pages/SettingsPage.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-expense.de.ts

