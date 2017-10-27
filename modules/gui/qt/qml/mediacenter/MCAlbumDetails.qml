import QtQuick 2.0

Item {

    property var album;

    function back() { }

    Column {
        id: column
        anchors.fill: parent

        Rectangle {
            id: navbar
            height: dimensions.heightBar_normal
            z : 2
            color: "#eeeeee"
            anchors.left: parent.left
            anchors.right: parent.right

            Row {
                anchors.fill: parent

                Image {
                    height: dimensions.icon_normal; width:dimensions.icon_normal
                    fillMode: Image.PreserveAspectFit
                    source: "qrc:///toolbar/dvd_prev"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: { back(); }
                    }
                }

                Text {
                    text: "<b>"+album.getTitle()+"</b>"
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    font.pixelSize: dimensions.fontSize_normal
                }
            }
        }

        Rectangle {
            height: parent.height - sourcesBanner.height - navbar.height
            anchors.left: parent.left
            anchors.right: parent.right

            Row {
                spacing: dimensions.margin_small
                anchors.fill: parent

                Column {
                    id: presentation_col_id
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    spacing: dimensions.margin_small
                    width: dimensions.heightAlbumCover_large

                    Image {
                        anchors.right: parent.right
                        anchors.left: parent.left
                        height: dimensions.heightAlbumCover_large
                        width: dimensions.heightAlbumCover_large
                        fillMode: Image.PreserveAspectFit
                        source: album.getCover()
                    }

                    Text {
                        width: dimensions.heightAlbumCover_large
                        text: "<b>Artistes</b> : "+album.getArtist()+album.getArtists().reduce(
                                  function (accumulator, currentValue) {
                                      return accumulator + ", <i>"+currentValue+"</i>";
                                  }
                              )
                        wrapMode: Text.WordWrap
                    }

//                    Repeater {
//                        model: album.getArtists()
//                        Text {
//                            width: 200
//                            text: modelData
//                            elide: Text.ElideRight
//                        }
//                    }

                    Text {
                        width: dimensions.heightAlbumCover_large
                        text: if (album.getReleaseYear() && album.getReleaseYear() != 0) {
                                  "<b>Date de sortie</b> : "+album.getReleaseYear()
                              } else {
                                  ""
                              }

                        elide: Text.ElideRight
                    }
                }

                Column {
                    width: parent.width - presentation_col_id.width - parent.spacing
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    spacing: dimensions.margin_small

                    Text {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        text: album.getShortSummary()
                        wrapMode: Text.WordWrap
                    }

                    Text {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        text: "<b>Titres disponibles :</b>"
                    }

                    ListView {
                        height: album.getTracks().length * (spacing + 2 + dimensions.fontSize_normal)
                        anchors.left: parent.left
                        anchors.right: parent.right
                        interactive: false
                        model: album.getTracks()

                        delegate: Rectangle {
                            height: dimensions.fontSize_normal + 2
                            width: track_name_id.width

                            Text {
                                id: track_name_id
                                text: modelData.getTrackNumber()+". "+modelData.getTitle()+" - "+modelData.getDuration()
                                font.pixelSize: dimensions.fontSize_normal
                            }

                            MouseArea {
                                anchors.fill: parent

                                hoverEnabled: true

                                onEntered: { parent.color = "#f0f0f0" }
                                onExited: { parent.color = "#ffffff" }
                                onClicked: { console.log( "clicked : "+modelData.getTitle() ) }
                            }
                        }
                    }
                }


            }
        }


    }


}
