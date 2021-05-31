#
# Copyright (C) 2018-2021 QuasarApp.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.
#

cmake_minimum_required(VERSION 3.5)

project(QmlNotyfyService LANGUAGES CXX)

include(CMake/QuasarApp.cmake)
include(CMake/Version.cmake)


set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_definitions(-DQMLNOTYFYSERICE_LIBRARY)

set(QML_IMPORT_PATH ${QML_IMPORT_PATH} "${CMAKE_CURRENT_SOURCE_DIR}" CACHE STRING "" FORCE)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick QuickControls2 REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick QuickControls2 REQUIRED)

file(GLOB SOURCE_CPP "*.cpp" "*.qrc")

add_library(${PROJECT_NAME} ${SOURCE_CPP})
target_link_libraries(${PROJECT_NAME} PUBLIC Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::QuickControls2)
target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

set(LANGS ${CMAKE_CURRENT_SOURCE_DIR}/qmlNotify_languages/en.ts
          ${CMAKE_CURRENT_SOURCE_DIR}/qmlNotify_languages/ru.ts
          ${CMAKE_CURRENT_SOURCE_DIR}/qmlNotify_languages/ja.ts
          ${CMAKE_CURRENT_SOURCE_DIR}/qmlNotify_languages/tr.ts
          ${CMAKE_CURRENT_SOURCE_DIR}/qmlNotify_languages/uk.ts)


prepareQM( ${PROJECT_NAME} ${CMAKE_CURRENT_SOURCE_DIR} "${LANGS}")

setVersion(1 0 1)

initAll()

addDoc("QmlNotyfyService" ${CMAKE_CURRENT_SOURCE_DIR}/doxygen.conf)
