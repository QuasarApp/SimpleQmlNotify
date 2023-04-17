import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.3

Dialog {
    id: root

    readonly property var historyModel: notificationService.history

    header: ToolBar {
        id: toolbar

        ToolButton {
            id: clearAllButton
            text: qsTr("clear")
            font.pointSize: 10
            height: parent.height
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }

            onClicked: historyModel.clearAllHistory()
        }

        Label {
            id: toolbarTitle
            text: qsTr("Notification history")
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
        }
    }

    contentItem: ListView {
        id: notificationLV
        clip: true
        spacing: 10
        model: historyModel

        ScrollBar.vertical: ScrollBar {}

        delegate: SwipeDelegate {
            id: swipeDelegate
            text: model.notificationValue
            width: notificationLV.width

            ListView.onRemove: SequentialAnimation {

                PropertyAction {
                    target: swipeDelegate
                    property: "ListView.delayRemove"
                    value: true
                }

                NumberAnimation {
                    target: swipeDelegate
                    property: "x"
                    to: -swipeDelegate.width
                    duration: 200
                    easing.type: Easing.InOutQuad
                }

                PropertyAction {
                    target: swipeDelegate;
                    property: "ListView.delayRemove"
                    value: false
                }
            }

            contentItem: RowLayout {

                Image {
                    id: image
                    Layout.preferredWidth:  toolbar.height;
                    Layout.preferredHeight: toolbar.height;
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

                    fillMode: Image.PreserveAspectCrop
                    clip: true
                    source: model.icon
                }

                ColumnLayout {
                    Label {
                        id: notificationTitle
                        text: model.title
                        elide: Label.ElideRight
                    }

                    Label {
                        id: notificationText
                        text: model.text
                        elide:  Label.ElideRight
                        linkColor: Material.accent
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                    }
                }
            }

            swipe.right: Label {
                id: deleteLabel
                text: qsTr("Delete")
                color: "white"
                verticalAlignment: Label.AlignVCenter
                padding: 12
                height: parent.height
                anchors.right: parent.right

                SwipeDelegate.onClicked: notificationLV.model.removeNotificationItemAtIndex(index)

                background: Rectangle {
                    color:  "red"
                }
            }
        }
    }
}
