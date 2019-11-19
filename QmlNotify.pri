#
# Copyright (C) 2018 - 2019 QuasarApp.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.
#

!isEmpty(QMLNOTYFYSERICE_LIB):error("QmlNotify.pri already included")
QMLNOTYFYSERICE_LIB = 1

#DEPENDS
CONFIG(release, debug|release): {
    QMLNOTYFYSERICE_LIB_OUTPUT_DIR="$$PWD/build/release"
} else {
    QMLNOTYFYSERICE_LIB_OUTPUT_DIR="$$PWD/build/debug"
}

LIBS += -L$$QMLNOTYFYSERICE_LIB_OUTPUT_DIR -lQmlNotyfyService

INCLUDEPATH += "$$PWD/"



QML2_IMPORT_PATH += \
    "$$PWD/" \
    "$$PWD/"

QML_IMPORT_PATH += \
    "$$PWD/" \
    "$$PWD/"
