import QtQuick 2.0

Item {

    property var artist

    function back() { }

    Column {
        id: main_col_id
        anchors.fill: parent

        spacing: 10

        Row {
            id : artist_profile_id
            width: parent.width
            height: Math.max(artist_image_id.height, info_artist_col_id.height)
            spacing: 10

            Image {
                id: artist_image_id
                height: 200
                width: 200
                fillMode: Image.PreserveAspectCrop
                source: artist.getCover() || "qrc:///noart.png"
            }

            Column {
                id: info_artist_col_id
                width: artist_profile_id.width - artist_profile_id.spacing - artist_image_id.width
                height: parent.height
                spacing: 5

                Text {
                    text: "<b>"+(artist.getName() || "Unknown artist")+"</b>"
                    font.pixelSize: 16
                    width: info_artist_col_id.width
                    elide: Text.ElideRight
                }

                Text {
                    text : artist.getShortBio() || "<i>No bio found</i>"
                    width: info_artist_col_id.width
                    wrapMode: Text.WordWrap
                }
            }
        }

        Grid {
            columns: 2

            Repeater {
                model: artist.getAlbums()

                Row {
                    Image {
                        width: 100
                        height: 100
                        source: modelData.getCover() || "qrc:///noart.png"
                        fillMode: Image.PreserveAspectFit
                    }

                    Column {
                        Text { text: "<b>"+(modelData.getTitle() || "Unknown album")+"</b>" }

                        Repeater {
                            model: modelData.getTracks()

                            Text { text: modelData.getTrackNumber()+". "+(modelData.getTitle() || "Unknown track")+" - "+modelData.getDuration() }
                        }
                    }
                }
            }
        }
    }
}
