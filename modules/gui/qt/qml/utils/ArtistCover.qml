import QtQuick 2.0

Grid {

    property var albums: undefined
    property int nb_albums: 0

    id: gridCover_id
    columns: 2
    spacing: 2

    Repeater {
        model: Math.min(nb_albums, 4)

        Image {
            id: img
            source: albums[modelData].getCover() || "qrc:///noart.png"
            height: nb_albums == 1 ? gridCover_id.height : (gridCover_id.height/gridCover_id.columns) - 1
            width: nb_albums == 1 ? gridCover_id.width : (gridCover_id.width/gridCover_id.columns) - 1
            fillMode: Image.PreserveAspectCrop
        }

    }
}
