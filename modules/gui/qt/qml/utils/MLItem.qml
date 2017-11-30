import QtQuick 2.0

Rectangle {
    id: root

    property bool hovered: false
    property bool force_disable: false

    function active() {
        return !force_disable && (hovered || mouseArea.containsMouse)
    }

    signal itemClicked


    color : medialib.isNightMode() ? (
                active() ? vlc_style.hoverBgColor_nightmode : vlc_style.bgColor_nightmode
            ) : (
                active() ? vlc_style.hoverBgColor_daymode : vlc_style.bgColor_daymode
            )

    MouseArea {
        id: mouseArea

        anchors.fill: root

        hoverEnabled: true
        propagateComposedEvents: true
        onClicked: {
            root.itemClicked();
            mouse.accepted = false;
        }
    }
}
