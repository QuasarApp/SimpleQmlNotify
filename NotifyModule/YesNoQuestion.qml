import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

NotificationForm {
    id: questionDialog

    autoClose: false
    clickClose: false

    footer: DialogButtonBox {
        standardButtons: Dialog.Yes | Dialog.No;
    }
}
