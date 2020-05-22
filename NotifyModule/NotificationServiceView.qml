/*
 * Copyright (C) 2018-2020 QuasarApp.
 * Distributed under the lgplv3 software license, see the accompanying
 * Everyone is permitted to copy and distribute verbatim copies
 * of this license document, but changing it is not allowed.
*/

import QtQuick 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.12

Item {
    readonly property var model: notificationService;
    readonly property var msg: model.notify
    readonly property var history: model.history

    Metrix {
        id: metrix
    }

    NotificationForm {
        id: notyfyView
        titleText : msg.title;
        text: (msg)? msg.text: "";
        img: (msg)? msg.img: "";
        type: (msg)? msg.type: 0;

        x: parent.width - width - margin;
        y: margin;

        width: 6 * metrix.controlPtMaterial;
        height: width * 0.5
    }

    onMsgChanged: {

        if (msg.isValid()) {
            notyfyView._show();
        }
    }
}
