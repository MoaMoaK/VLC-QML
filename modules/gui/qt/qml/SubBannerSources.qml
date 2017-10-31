/****************************************************************************
 * The banner to display the sub sources (albums/genre/tracks/artists ...)
 ****************************************************************************/

import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

Rectangle {
    id: root_id

    property color banner_color: "#e6e6e6"
    property color hover_color: "#d6d6d6"

    function chooseSubSources() {
        var c = getCategory();
        if (c >= 0 && c <= 3) {
            return model_music_id;
        } else if (c===4) {
            return model_video_id;
        } else {
            return model_network_id;
        }
    }

    function sort( criteria ){
        // To be implemented by the parent
        return ;
    }

    function update() {
        repeater_id.model = chooseSubSources();
    }

    function selectSource( name ) {
        // To be implemented by the parent
        return ;
    }

    function getCategory() {
        // To be implemented by the parent
        return ;
    }
    anchors.left: parent.left
    anchors.right: parent.right

    color: banner_color

    RowLayout {
        anchors.fill: parent

        Repeater {
            id: repeater_id
            model: chooseSubSources()

            Layout.fillHeight: true
            Layout.fillWidth: true

            Rectangle {
                // A single button for a sub-source
                height: parent.height
                width: subsource_name_id.implicitWidth + 20

                color: banner_color

                Text {
                    id: subsource_name_id
                    anchors {
                        left: parent.left
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                        rightMargin: dimensions.margin_small
                        leftMargin: dimensions.margin_small
                    }
                    text: model.displayText
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: selectSource( model.name )
                    hoverEnabled: true
                    onEntered: { parent.color = hover_color; }
                    onExited: { parent.color = banner_color; }
                }
            }

        }

        ListModel {
            // The list of sub-sources for Music
            id: model_music_id
            ListElement {
                displayText: "Albums"
                name: "music-albums"
            }
            ListElement {
                displayText: "Artistes"
                name: "music-artists"
            }
            ListElement {
                displayText: "Genre"
                name: "music-genre"
            }
            ListElement {
                displayText: "Tracks"
                name: "music-tracks"
            }
        }
        ListModel {
            // The list of sub-sources for Video
            id: model_video_id
            ListElement {
                displayText: "TV shows"
                name: "video"
            }
            ListElement {
                displayText: "Seasons"
                name: "video"
            }
            ListElement {
                displayText: "Videos"
                name: "video"
            }
        }
        ListModel {
            // The list of sub-sources for Network
            id: model_network_id
        }

        ComboBox {
            // The selector to choose a specific sorting operation
            id: combo
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            Layout.preferredWidth: width
            width: 150

            model: sortModel
            onActivated: sort( sortModel.get(index).text )
        }

        ListModel {
            // The model for the different possible sorts
            id: sortModel
            ListElement { text: "Alphabetic asc" }
            ListElement { text: "Alphabetic desc" }
            ListElement { text: "Duration asc" }
            ListElement { text: "Duration desc" }
            ListElement { text: "Date asc" }
            ListElement { text: "Date desc" }
            ListElement { text: "Artist asc" }
            ListElement { text: "Artist desc" }
        }
    }


}
