/*
 * Copyright (C) 2018-2023 QuasarApp.
 * Distributed under the lgplv3 software license, see the accompanying
 * Everyone is permitted to copy and distribute verbatim copies
 * of this license document, but changing it is not allowed.
*/

import QtQuick 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

Item {
    id : root;
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

        width: Math.min(6 * metrix.pt, root.width);

    }

    YesNoQuestion {
        id: questionMsgBox
        titleText : qst.title();
        text: (qst)? qst.text(): "";
        img: (qst && qst.img().length)? qst.img(): defImg;
        type: 0;

        x: parent.width / 2  - width / 2;
        y: parent.height / 2 - height / 2;

        width: Math.min(6 * metrix.pt, root.width);

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

    NotificationHistoryView {
        id: history
        width: Math.min(Math.max(Math.min(parent.width * 0.6, 1024 ), 320), parent.width)
        height: Math.min(Math.max(Math.min(parent.height * 0.6, 720), 240), parent.height)

        anchors.centerIn: parent
    }

    Connections {
        target: model
        function onSigShowHistory() {
            history.open()
        }
    }
}
