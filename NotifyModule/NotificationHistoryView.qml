import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Popup {
    id: root

    readonly property var historyModel: historyNotificationsModel

    ToolBar {
        id: toolbar
        width: parent.width
        height: parent.height * 0.1
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        ToolButton {
            id: clearAllButton
            text: qsTr("Clear All")
            height: parent.height
            font.pointSize: 10
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }

            onClicked: historyModel.clearAllHistory()
        }

        Label {
            id: toolbarTitle
            text: qsTr("Notification history")
            font.pointSize: 12
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
        }

        ToolButton {
            id: closePopupButton
            text: "X"
            font.pointSize: 12
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }

            onClicked: root.close()
        }
    }

    ListView {
        id: notificationLV
        width: parent.width
        height: parent.height * 0.9
        clip: true
        model: historyModel
        anchors {
            top: toolbar.bottom
            horizontalCenter: parent.horizontalCenter
        }

        ScrollBar.vertical: ScrollBar {
            hoverEnabled: true
            active: hovered || pressed
            anchors {
                top: notificationLV.top
                right: notificationLV.right
                bottom: notificationLV.bottom
            }
        }

        delegate: SwipeDelegate {
            id: swipeDelegate
            text: model.notificationValue
            width: notificationLV.width
            height: notificationLV.height * 0.15

            ListView.onRemove: SequentialAnimation {

                PropertyAction {
                    target: swipeDelegate
                    property: "ListView.delayRemove"
                    value: true
                }


                NumberAnimation {
                    target: swipeDelegate
                    property: "height"
                    to: 0
                    duration: 20
                    easing.type: Easing.InOutQuad
                }


                PropertyAction {
                    target: swipeDelegate;
                    property: "ListView.delayRemove"
                    value: false
                }
            }

            Image {
                id: notificationIcon
                width: notificationIcon.sourceSize.width * 0.25
                height: notificationIcon.sourceSize.height * 0.25
                source: model.icon
                fillMode: Image.PreserveAspectFit
                anchors {
                    left: parent.left
                    leftMargin: parent.width * 0.1
                    verticalCenter: parent.verticalCenter
                }
            }

            Column {
                id: column
                width: parent.width * 0.25
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }

                Label {
                    id: notificationTitle
                    text: qsTr(model.title)
                    font.pointSize: 12
                    clip: true
                }

                Label {
                    id: notificationText
                    text: qsTr(model.text)
                    font.pointSize: 12
                    wrapMode: Text.WordWrap
                    clip: true
                    linkColor: Material.accent
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
                    color: deleteLabel.SwipeDelegate.pressed? "red" : "gray"
                }
            }
        }
    }

    Connections {
        target: historyModel
        function onDataInserted() {
            console.log(Object.keys(historyModel))
        }
    }
}
