import QtQuick 2.0

Item {

    property string cover
    property string title
    property string album
    property string artist
    property string uri
    property string duration

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

    x: 5
    height: 50
    Column {
        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            id: image
            width: 100
            height: 100
            source: decideCover(cover)
            MouseArea {
                anchors.fill: image
                Timer{
                    id:timerMouse
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

        spacing: 5
    }
}
