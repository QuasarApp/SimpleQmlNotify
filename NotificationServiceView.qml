import QtQuick 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.12

Item {
    readonly property var model: notificationService;
    readonly property var msg: model.notify
    readonly property var history: model.history


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
        notyfyView._show();
    }
}
