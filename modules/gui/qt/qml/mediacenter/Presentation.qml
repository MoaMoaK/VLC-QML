import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {
    id: root
    property var obj: undefined
    color : medialib.isNightMode() ? "#000000" : "#ffffff"

    RowLayout {
        id: row_id
        anchors.fill: parent
        anchors.margins: vlc_style.margin_normal
        spacing: vlc_style.margin_normal

        Image {
            height: vlc_style.icon_normal
            Layout.maximumHeight: height
            Layout.minimumHeight: height
            Layout.preferredHeight: height

            source: "qrc:///toolbar/dvd_prev"
            fillMode: Image.PreserveAspectFit

            MouseArea {
                anchors.fill: parent
                onClicked: medialib.backPresentation()
            }
        }

        Image {
            id : image_id
            Layout.fillHeight: true
            height: vlc_style.heightAlbumCover_large
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
            spacing: vlc_style.margin_normal

            Text {
                id: title_id
                Layout.fillWidth: true
                Layout.maximumHeight: implicitHeight
                Layout.minimumHeight: implicitHeight
                Layout.preferredHeight: implicitHeight
                text: "<b>"+( obj.getPresName() || "Unknwon artist" )+"</b>"
                elide: Text.ElideRight
                color: medialib.isNightMode() ? "#FFFFFF" : "#000000"
            }

            Text {
                id: info_id
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: obj.getPresInfo()
                wrapMode: Text.WordWrap
                elide: Text.ElideRight
                color: medialib.isNightMode() ? "#FFFFFF" : "#000000"
            }
        }
    }
}
