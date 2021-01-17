/*
 * Copyright (C) 2018-2020 QuasarApp.
 * Distributed under the lgplv3 software license, see the accompanying
 * Everyone is permitted to copy and distribute verbatim copies
 * of this license document, but changing it is not allowed.
*/

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.15

Dialog {
    id : basePopup
    width: 200
    height: 100
    x: 0
    y: 0

    transformOrigin: Item.Center

    property bool autoClose: true
    property bool clickClose: true

    property int closeInterval: 15000;
    property int margin : 0
    property color backgroundColor: Material.background

    property alias autoClosePasused: progressAnimation.paused

    background: Item {
        id: bacground

        Rectangle{
            anchors.fill: parent
            id: backCorner
            color: backgroundColor
            radius: metrix.mm
        }

        DropShadow {
            anchors.fill: parent
            source: backCorner
            color: "#80000000"
            verticalOffset: 10
            samples: 30
        }
    }

    function _show() {
        open();

        if (autoClose) {
            progressAnimation.from = 0;
            progressAnimation.start();
        }
    }

    function autoclosePause() {
        progressAnimation.pause();
    }

    function autocloseResume() {
        progressAnimation.resume();
    }

    onClosed: {
        if (autoClose)
            opacity = 0;
    }

    closePolicy: (!clickClose || autoClose)? Popup.NoAutoClose: Popup.CloseOnReleaseOutside

    onRejected: close()

    footer: ProgressBar {
        id: progress;
        from: 0
        to: 100
        visible: autoClose
        value: 0;


        NumberAnimation on value {

            id: progressAnimation
            duration: closeInterval
            easing.type: Easing.Linear
            running: false
            to: 100
            from: progress.value

            onFinished: {
                close();
            }
        }
    }
}
