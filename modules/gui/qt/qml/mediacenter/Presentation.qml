import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {
    id: root
    property var obj: undefined

    RowLayout {
        id: row_id
        anchors.fill: parent
        anchors.margins: dimensions.margin_normal
        spacing: dimensions.margin_normal

        Image {
            id : image_id
            Layout.fillHeight: true
            height: dimensions.heightAlbumCover_large
            Layout.maximumWidth: height
            Layout.minimumWidth: height
            Layout.preferredWidth: height

            source: obj.getPresImage() || "qrc:///noart.png"
            fillMode: Image.PreserveAspectFit
        }

        ColumnLayout {
            id: col_id
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: dimensions.margin_normal

            Text {
                id: title_id
                Layout.fillWidth: true
                Layout.maximumHeight: implicitHeight
                Layout.minimumHeight: implicitHeight
                Layout.preferredHeight: implicitHeight
                text: "<b>"+( obj.getPresName() || "Unknwon artist" )+"</b>"
                elide: Text.ElideRight
            }

            Text {
                id: info_id
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: obj.getPresInfo()
                wrapMode: Text.WordWrap
                elide: Text.ElideRight
            }
        }
    }
}
