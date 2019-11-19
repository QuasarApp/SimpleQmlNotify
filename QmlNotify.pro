#
# Copyright (C) 2018 - 2019 QuasarApp.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.
#


CONFIG += c++14
TARGET = QmlNotyfyService
TEMPLATE = lib
QT += quick

DEFINES += QMLNOTYFYSERICE_LIBRARY

# The following define makes your compiler emit warnings if you use
# any feature of Qt which has been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

CONFIG(release, debug|release): {
    DESTDIR = $$PWD/build/release

} else {
    DESTDIR = $$PWD/build/debug
}

RESOURCES += \
    QML.qrc

HEADERS += \
    notificationdata.h \
    notificationservice.h \
    notifyservice_global.h \
    qmlnotifyservice.h

SOURCES += \
    notificationdata.cpp \
    notificationservice.cpp \
    qmlnotifyservice.cpp
