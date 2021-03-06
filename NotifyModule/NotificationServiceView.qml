/*
 * Copyright (C) 2018-2021 QuasarApp.
 * Distributed under the lgplv3 software license, see the accompanying
 * Everyone is permitted to copy and distribute verbatim copies
 * of this license document, but changing it is not allowed.
*/

import QtQuick 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

Item {
    readonly property var model: notificationService;
    readonly property var msg: model.notify
    readonly property var qst: model.question

    readonly property var history: model.history

    Metrix {
        id: metrix
    }

    NotificationForm {
        id: notyfyView
        titleText : msg.title();
        text: (msg)? msg.text(): "";
        img: (msg && msg.img().length)? msg.img(): getDefaultImage((msg)? msg.type(): 0);
        type: (msg)? msg.type(): 0;

        x: parent.width - width - margin;
        y: margin;

        width: 4 * metrix.pt;
        height: width * 0.5
    }

    YesNoQuestion {
        id: questionMsgBox
        titleText : qst.title();
        text: (qst)? qst.text(): "";
        img: (qst && qst.img().length)? qst.img(): defImg;
        type: 0;

        x: parent.width / 2  - width / 2;
        y: parent.height / 2 - height / 2;

        width: 6 * metrix.pt;
        height: width * 0.45

        onAccepted: {
            if (model) {
                model.questionComplete(true, qst.type())
            }
        }

        onRejected: {
            if (model) {
                model.questionComplete(false, qst.type())
            }
        }
    }

    onMsgChanged: {

        if (msg.isValid()) {
            notyfyView._show();
        }
    }

    onQstChanged: {
        if (qst.isValid()) {
            questionMsgBox._show();
        }
    }
}
