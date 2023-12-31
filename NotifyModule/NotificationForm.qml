/*
 * Copyright (C) 2018-2024 QuasarApp.
 * Distributed under the GPLv3 software license, see the accompanying
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
    closeInterval: 10000

    margins: 0
    margin: 0
    spacing: 0

    backgroundColor: Qt.rgba(Material.background.r * 0.9, Material.background.g * 0.9, Material.background.b * 0.9, Material.background.a)

    header: Pane {


        RowLayout {
            width: popup.width

            Item {
                Layout.preferredWidth: 10
            }

            Label {
                text: title
                wrapMode: Text.WordWrap
                font.bold: true
                font.pointSize: 13
                Layout.fillWidth: true
            }

            ToolButton {
                text: String.fromCharCode(0x2630)
                font.pointSize: 10
                onClicked:  {
                    history.open()
                    popup.close()
                }
            }

            ToolButton {
                text: "X"
                onClicked:  {
                    close();
                }
            }

            Item {
                Layout.preferredWidth: 10
            }

        }
    }

    contentItem:
        Control {
        id: control;
        implicitHeight: rowLayout.implicitHeight
        implicitWidth: 0x0

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

        RowLayout {
            id: rowLayout
            spacing: 5
            clip: true

            width: control.width

            Image {
                id: image
                Layout.preferredWidth:  50;
                Layout.preferredHeight: 50;
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

                fillMode: Image.PreserveAspectCrop
                clip: true
                source: img
            }


            Label {
                id: message
                text: popup.text
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.fillWidth: true;
                clip: true
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                linkColor: Material.accent

                onLinkActivated: (link) => {
                                     Qt.openUrlExternally(link)
                                 }
                onLinkHovered: (link) => {
                                   if (link.length) {
                                        message.ToolTip.show(link)
                                   } else {
                                       message.ToolTip.hide()
                                   }
                               }


            }
        }
    }


    title: titleText
}
