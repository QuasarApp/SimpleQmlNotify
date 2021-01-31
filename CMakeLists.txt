#
# Copyright (C) 2018-2021 QuasarApp.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.
#

cmake_minimum_required(VERSION 3.5)
include(CMake/crossplatform/crossplatform.cmake)

project(QmlNotyfyService LANGUAGES CXX)

include(CMake/ProjectOut.cmake)
include(CMake/ccache.cmake)
include(CMake/Version.cmake)


set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(QMLNOTYFYSERICE_LIBRARY ON)

set(QML_IMPORT_PATH "${CMAKE_CURRENT_SOURCE_DIR}" CACHE STRING "Qt Creator extra qml import paths")

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick REQUIRED)

file(GLOB SOURCE_CPP "*.cpp" "*.qrc")

add_library(${PROJECT_NAME} SHARED ${SOURCE_CPP})
target_link_libraries(${PROJECT_NAME} PUBLIC Qt::Core Qt::Quick)
target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

setVersion(1 0 1)
