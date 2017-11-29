/*****************************************************
 * A component that defines an area where the
 * mouse activates a popup tooltip with a specific
 * text (like a hint)
 *****************************************************/

import QtQuick 2.0

MouseArea {
    property alias tip: tip
    property alias text: tip.text
    property alias hideDelay: hideTimer.interval
    property alias showDelay: showTimer.interval
    property bool enabled: true
    property alias attachedParent: tip.zParent
    id: mouseArea
    acceptedButtons: Qt.NoButton
    anchors.fill: parent
    hoverEnabled: true
    propagateComposedEvents: true
    Timer {
        id:showTimer
        interval: 1000
        running: mouseArea.containsMouse && !tip.visible && mouseArea.enabled
        onTriggered: {
            tip.x = mouseX;
            tip.y = mouseY - tip.height;
            tip.show();
        }
    }
    Timer {
        id:hideTimer
        interval: 100
        running: !mouseArea.containsMouse && tip.visible
        onTriggered: { tip.hide(); }
    }
    ToolTip {
        id:tip
        zParent: parent.parent
    }
}

