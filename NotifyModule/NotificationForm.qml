/*
 * Copyright (C) 2018-2020 QuasarApp.
 * Distributed under the lgplv3 software license, see the accompanying
 * Everyone is permitted to copy and distribute verbatim copies
 * of this license document, but changing it is not allowed.
*/

import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.3

BasePopUp {
    id : popup

    property string text: qsTr("Message")
    property string img: ""
    property string titleText: qsTr("Message")
    property int type: 0

    readonly property string defImgI: "qrc:/icons/info"
    readonly property string defImgW: "qrc:/icons/warning"
    readonly property string defImgE: "qrc:/icons/error"

    function getDefaultImage(type) {
        switch(type) {

        case 1: return defImgW
        case 2: return defImgE

        }

        return defImgI

    }

    autoClose: true;
    closeInterval: 5000

    margins: 0
    margin: 0
    spacing: 0


    backgroundColor: Material.background

    contentItem:
        Item {

        RowLayout {
            id: rowLayout
            spacing: 5
            clip: true

            Rectangle {
                color: "#00000000"
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                Layout.preferredWidth: rowLayout.height;
                Layout.preferredHeight: rowLayout.height;

                Image {
                    id: image
                    fillMode: Image.PreserveAspectCrop
                    clip: true
                    anchors.fill: parent;
                    source: img
                }
            }


            Label {
                id: message
                text: popup.text
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.fillHeight: true;
                Layout.fillWidth: true;
                clip: true
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            anchors.fill: parent
        }

        MouseArea {
            hoverEnabled: true
            onEntered: {
                autoclosePause();
            }

            onExited: {
                autocloseResume();
            }

            onClicked: {

                if (!autoClose) {
                    close();
                }

                if (autoClosePasused) {
                    autocloseResume()
                } else {
                    autoclosePause();
                }
            }

            anchors.fill: parent
        }
    }

    title: titleText
}
