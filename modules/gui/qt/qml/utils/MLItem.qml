import QtQuick 2.0

Rectangle {
    id: root

    signal itemClicked

    color : medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode

    MouseArea {
        id: mouseArea

        anchors.fill: root

        hoverEnabled: true
        onEntered: { root.color = medialib.isNightMode() ? vlc_style.hoverBgColor_nightmode : vlc_style.hoverBgColor_daymode }
        onExited: { root.color = medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode }
        propagateComposedEvents: true

        onClicked: {
            root.itemClicked();
            mouse.accepted = false;
        }
    }
}
