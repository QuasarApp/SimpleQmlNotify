/*
 * Copyright (C) 2018-2024 QuasarApp.
 * Distributed under the GPLv3 software license, see the accompanying
 * Everyone is permitted to copy and distribute verbatim copies
 * of this license document, but changing it is not allowed.
*/

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

NotificationForm {
    id: questionDialog

    readonly property string defImg: "qrc:/icons/question"

    autoClose: false
    clickClose: false
    modal: true

    footer: DialogButtonBox {
        standardButtons: Dialog.Yes | Dialog.No;
    }
}
