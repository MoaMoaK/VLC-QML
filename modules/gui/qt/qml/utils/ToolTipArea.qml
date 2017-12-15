/***************************************************************
 * An Area where a tooltip pops up if the mouse is hovering
 ***************************************************************/

import QtQuick 2.0
import QtQuick.Controls 2.0
MouseArea {
    property alias text: tip.text
    property alias delay: tip.delay
    property bool activated: true

    anchors.fill: parent

    hoverEnabled: true
    propagateComposedEvents: true

    ToolTip {
        id: tip
        text: "plop"
        delay: 500
        visible: activated && parent.containsMouse
    }
}
