import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.0
import QtQuick.Controls 2.3

Item {
    readonly property int pointCount: 100;
    readonly property real mm: Screen.pixelDensity
    readonly property real sm: 10 * mm
    readonly property real dsm: Math.sqrt(Math.pow(Screen.desktopAvailableWidth, 2) + Math.pow(Screen.desktopAvailableHeight, 2)) / sm
    readonly property real pt: getfactor(dsm) * sm
    readonly property real controlPtMaterial: Material.buttonHeight
    readonly property real gamePt: (width < height) ? width / pointCount : height / pointCount;

    function getfactor(dsm) {
        if (dsm < 30) {
            return 0.5
        } else if ( dsm < 70) {
            return 1
        } else if (dsm < 140) {
            return 2;
        } else
            return 4;
    }

    anchors.fill: parent;
}
