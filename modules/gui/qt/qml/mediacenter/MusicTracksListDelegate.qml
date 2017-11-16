import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    id: root

    height: collapse_title_id.implicitHeight + 4
    width: parent.width

    MouseArea {
        id: mouseArea_root_id
        anchors.fill: root

        hoverEnabled: true
        onEntered: { root.color = "#f0f0f0" }
        onExited: { root.color = "#ffffff" }
        onClicked: { console.log("clicked : "+model.track_title) }
    }

    Text {
        id: collapse_title_id
        text : "<b>"+(model.track_title || "Unknown track")+"</b> - "+model.track_duration
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width-parent.spacing
        elide: Text.ElideRight
    }
}


