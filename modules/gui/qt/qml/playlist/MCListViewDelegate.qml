import QtQuick 2.0

Rectangle {

    property string cover
    property string title
    property string album
    property string artist
    property string uri
    property string duration

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

        Image {
            id: image
            width: 32
            height: 32
            y: parent.height/2 - height/2
            source: decideCover(cover)
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

