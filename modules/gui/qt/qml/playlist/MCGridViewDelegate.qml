import QtQuick 2.0

Item {

    property string cover
    property string title
    property string album
    property string artist
    property string uri
    property string duration
    property bool is_leaf

    function decideTitle (title, uri, duration) {
        var ret = ""
        if ( title )
            ret += title.slice(0, 10)
        else if ( uri )
            ret += uri.slice(0, 10)
        if ( duration )
            ret += " ["+duration+"]"
        return ret
    }

    function decideInfo (album, artist) {
        var ret = ""
        if ( album ) {
            ret += album.slice(0, 14)
            if ( artist )
                ret += " - "
        }
        if ( artist )
            ret += artist.slice(0, 14)
        return ret
    }

    function decideCover (cover) {
        return cover ? cover : "qrc:///noart.png"
    }

    Rectangle {
        id: root

        anchors.centerIn: parent

        height: column.implicitHeight +10
        width: column.implicitWidth +20
        Column {
            x: 10
            y: 5
            id: column
            spacing: 5

            Loader {
                id: image
                sourceComponent: is_leaf ? leaf : dir
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Component {
                id:leaf

                Image {
                    id: main_leaf_img
                    width: 100
                    height: 100
                    source: decideCover(cover)
                }
            }

            Component {
                id: dir

                Item {
                    width: main_dir_img.width
                    height: main_dir_img.height

                    Image {
                        id: main_dir_img
                        width: 100
                        height: 100
                        source: decideCover(cover)
                    }

                    Image {
                        id: sub_dir_img
                        anchors {
                            bottom: main_dir_img.bottom
                            right: main_dir_img.right
                            margins: 0
                        }
                        width: 48
                        height: 48
                        source: "qrc:///type/folder-grey"
                    }

                }

            }

            Text {
                text : decideTitle(title, uri, duration)
                anchors.horizontalCenter: parent.horizontalCenter
                font: model.font
            }

            Text {
                text: decideInfo (album, artist)
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 8
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: root

            hoverEnabled: true
            onEntered: { root.color = "#f0f0f0" }
            onExited: { root.color = "#ffffff" }

            Timer{
                id: timerMouse
                interval: 200
                onTriggered: singleClick() // Single click
            }
            onClicked: {
                if(timerMouse.running)
                {
                    doubleClick() // Double click
                    timerMouse.stop()
                }
                else
                    timerMouse.restart()
            }


        }

    }

}
