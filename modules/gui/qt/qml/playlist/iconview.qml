import QtQuick 2.0
import QtQuick.Layouts 1.3

Item {
    width: 1000
    height: 1000

    function decideTitle (title, uri, duration) {
        var ret = ""
        if ( title )
            ret += title.slice(0, 10)
        else
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
        if (cover)
            return cover
        else
            return "qrc:///noart.png"
    }




    Column {
        id: column
        anchors.fill: parent

        PLBannerSources {
            id: sourcesBanner
        }

        GridView {
            id: gridView
            z : 1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: sourcesBanner.bottom
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.left: parent.left
            cellWidth: 150
            cellHeight: 150
            model: m
            delegate: Item {
                x: 5
                height: 50
                Column {
                    Image {
                        anchors.horizontalCenter: parent.horizontalCenter
                        id: image
                        width: 100
                        height: 100
                        source: decideCover(model.cover)
                        MouseArea {
                            anchors.fill: image
                            Timer{
                                id:timer
                                interval: 200
                                onTriggered: model.display_info=1 // Single click
                            }
                            onClicked: {
                                if(timer.running)
                                {
                                    model.activate_item=1 // Double click
                                    timer.stop()
                                }
                                else
                                    timer.restart()
                            }
                        }
                    }

                    Text {
                        text : decideTitle(model.title, model.uri, model.duration)
                        anchors.horizontalCenter: parent.horizontalCenter
                        font: model.font
                    }

                    Text {
                        text: decideInfo (model.album, model.artist)
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 8
                    }

                    spacing: 5
                }
            }
        }
    }


}
