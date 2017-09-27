import QtQuick 2.0

Rectangle {

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
            ret += title
        else if ( uri )
            ret += uri
        if ( duration )
            ret += " ["+duration+"]"
        return ret
    }

    function decideInfo (album, artist) {
        var ret = ""
        if ( album ) {
            ret += album
            if ( artist )
                ret += " - "
        }
        if ( artist )
            ret += artist
        return ret
    }

    function decideCover (cover) {
        return cover ? cover : "qrc:///noart.png"
    }

    id: root

    height: row.height
    width: parent.width
    Row {
        anchors.fill: parent
        height: image.height
        id: row
        spacing: 5

        Loader {
            id: image
            y: parent.height/2 - height/2
            sourceComponent: is_leaf ? leaf : dir
        }

        Component {
            id:leaf

            Image {
                id: main_leaf_img
                width: 32
                height: 32
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
                    width: 32
                    height: 32
                    source: decideCover(cover)
                }

                Image {
                    id: sub_dir_img
                    anchors {
                        bottom: main_dir_img.bottom
                        right: main_dir_img.right
                        margins: 0
                    }
                    width: 12
                    height: 12
                    source: "qrc:///type/folder-grey"
                }

            }

        }

        Text {
            text : decideTitle(title, uri, duration)
            y: parent.height/2 - height/2
            font: model.font
        }

        Text {
            text: decideInfo (album, artist)
            y: parent.height/2 - height/2
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

