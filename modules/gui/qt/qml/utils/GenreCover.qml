import QtQuick 2.0
import QtQuick.Layouts 1.3
Item {

    property var albums: undefined
    property int nb_albums: albums.rowCount()

    function calc_height(i) {
        if (nb_albums === 1) {
            return gridCover_id.height;
        } else if (nb_albums === 2) {
            return gridCover_id.height;
        } else if (nb_albums === 3) {
            if (i === 0) {
                return gridCover_id.height;
            } else {
                return gridCover_id.height/2 - gridCover_id.rowSpacing/2;
            }
        } else {
            return gridCover_id.height/2 - gridCover_id.rowSpacing/2;
        }
    }
    function calc_width(i) {
        if (nb_albums === 1) {
            return gridCover_id.width;
        } else if (nb_albums === 2) {
            return gridCover_id.width/2 - gridCover_id.columnSpacing/2;
        } else if (nb_albums === 3) {
            return gridCover_id.width/2 - gridCover_id.columnSpacing/2;
        } else {
            return gridCover_id.width/2 - gridCover_id.columnSpacing/2;
        }
    }
    function calc_rowSpanning(i) {
        if (nb_albums === 1) {
            return 2;
        } else if (nb_albums === 2) {
            return 2;
        } else if (nb_albums === 3) {
            if (i === 0) {
                return 2;
            } else {
                return 1;
            }
        } else {
            return 1;
        }
    }

    GridLayout {
        id: gridCover_id
        anchors.fill: parent
        columns: 2
        columnSpacing: 2
        rowSpacing: 2

        Repeater {
            model: albums

            Image {
                id: img
                source: model.album_cover || "qrc:///noart.png"
                Layout.rowSpan: calc_rowSpanning(index)
                Layout.preferredHeight: calc_height(index)
                Layout.preferredWidth: calc_width(index)
                fillMode: Image.PreserveAspectCrop
                visible: index < 4
            }
        }
    }

    Rectangle {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: medialib.isNightMode() ? "#80000000" : "#80FFFFFF"
        height: moreText.implicitHeight/2
        width: moreText.implicitWidth
        visible: nb_albums > 4
        Text {
            id: moreText
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            text: "..."
            font.pixelSize: 30
            color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
        }
    }
}
