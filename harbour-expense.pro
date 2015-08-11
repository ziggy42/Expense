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
    qml/cover/*.qml \
    qml/JS/*.js \
    qml/components/*.qml \
    qml/pages/*.qml \
    rpm/* \
    translations/harbour-expense*.ts \
    harbour-expense.desktop \

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-expense.de.ts \
    translations/harbour-expense.it.ts \
    translations/harbour-expense.sv.ts
