/*********************************************************
 * The delegate used to display an item in the playlist
 *********************************************************/
import QtQuick 2.0

Row {
    property bool cur: false
    property string title
    property string duration

    height: bg.height

    spacing: 0

    /* Button to remove this item from playlist */
    Image {
        id: removeButton

        height: parent.height
        width: parent.height

        source: "qrc:///toolbar/clear"
        fillMode: Image.PreserveAspectFit

        MouseArea {
            id: delete_mouseArea

            anchors.fill: parent

            onClicked: { remove(); }
            hoverEnabled: true
        }
    }

    Rectangle {
        id: bg

        width : parent.width - removeButton.width
        height:  textInfo.implicitHeight

        color: delete_mouseArea.containsMouse ? (
            "#CC0000"
        ) : (
            medialib.isNightMode() ? (
                hover_mouseArea.containsMouse ? vlc_style.hoverBgColor_nightmode : vlc_style.bgColor_nightmode
            ) : (
                hover_mouseArea.containsMouse ? vlc_style.hoverBgColor_daymode : vlc_style.bgColor_daymode
            )
        )

        /* Title/name of the item */
        Text {
            id: textInfo

            x: 10

            text: duration ? '[' + duration + '] ' + (title ? title : "") : (title ? title : "")
            color: delete_mouseArea.containsMouse ? (
                "#FFFFFF"
            ) : (
                medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
            )
        }

        MouseArea {
            id: hover_mouseArea

            anchors.fill: parent

            hoverEnabled: true
            onClicked: { singleClick(); }
            onDoubleClicked: { doubleClick(); }
        }

    }
}
