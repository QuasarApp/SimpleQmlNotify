import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Popup {
    id: root

    readonly property var historyModel: notificationService.history

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
        spacing: 5
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

            contentItem: Row {
                width: parent.width
                spacing: width * 0.35

                Image {
                    id: notificationIcon
                    width: notificationIcon.sourceSize.width * 0.15
                    height: notificationIcon.sourceSize.height * 0.15
                    source: model.icon
                    fillMode: Image.PreserveAspectFit
                    anchors {
                        verticalCenter: parent.verticalCenter
                    }
                }

                Column {
                    id: column
                    width: parent.width - notificationIcon.width * 0.2
                    anchors {
                        verticalCenter: parent.verticalCenter
                    }

                    Label {
                        id: notificationTitle
                        width: parent.width
                        text: qsTr(model.title)
                        font.pointSize: 12
                        elide: Label.ElideRight
                    }

                    Label {
                        id: notificationText
                        width: parent.width
                        text: qsTr(model.text)
                        font.pointSize: 12
                        elide:  Label.ElideRight
                        linkColor: Material.accent
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
