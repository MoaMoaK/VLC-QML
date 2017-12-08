/*********************************************************
 * The delegate used to display an item in the playlist
 *********************************************************/
import QtQuick 2.0

Row {

    // Is this item the one currently playing
    function is_current() {
        if (model === undefined) return False
        return model.current
    }
    // Check if the title can be retrieved from the model
    function get_title() {
        if (model === undefined) return ""
        return model.title
    }
    // Check if the duration can be retrieved from the model
    function get_duration() {
        if (model === undefined) return ""
        return model.duration
    }

    // Calculate the correct color for the background
    function calc_bgColor() {
        if (delete_mouseArea.containsMouse) return "#CC0000";
        else if (medialib.isNightMode()) {
            if (hover_mouseArea.containsMouse) return vlc_style.hoverBgColor_nightmode;
            else return vlc_style.bgColor_nightmode;
        }
        else {
            if (hover_mouseArea.containsMouse) return vlc_style.hoverBgColor_daymode;
            else return vlc_style.bgColor_daymode;
        }
    }
    // Calculate the text to display
    function calc_text() {
        if (get_duration()) {
            if (get_title()) return '[' + get_duration() + '] ' + get_title();
            else return '[' + get_duration() + '] ';
        }
        else {
            if (get_title()) return get_title();
            else return "";
        }
    }
    // Calculate the correct color for the text to display
    function calc_textColor() {
        if (delete_mouseArea.containsMouse) return "#FFFFFF"
        else if (medialib.isNightMode()) return vlc_style.textColor_nightmode
        else return vlc_style.textColor_daymode;
    }

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

            hoverEnabled: true
            onClicked: playlist.remove_item(currentIndex)
        }
    }

    Rectangle {
        id: bg

        width : parent.width - removeButton.width
        height:  textInfo.implicitHeight

        color: calc_bgColor();

        /* Title/name of the item */
        Text {
            id: textInfo

            x: 10

            text: calc_text()
            color: calc_textColor()
        }

        MouseArea {
            id: hover_mouseArea

            anchors.fill: parent

            hoverEnabled: true
            onDoubleClicked: playlist.play_item(currentIndex)
        }

    }
}
