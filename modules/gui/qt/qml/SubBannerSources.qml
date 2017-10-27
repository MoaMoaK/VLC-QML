import QtQuick 2.0

Rectangle {
    id: root_id

    property int banner_height: 32
    property color banner_color: "#e6e6e6"
    property color hover_color: "#d6d6d6"

    function chooseSubSources() {
        var c = getCategory();
        if (c==="music-albums" || c==="music-artists" || c==="music-genres" || c==="music-tracks") {
            return model_music_id;
        } else if (c==="video") {
            return model_video_id;
        } else {
            return model_network_id;
        }
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

    height: banner_height

    color: banner_color

    Row {
        anchors.centerIn: parent
        Repeater {
            id: repeater_id
            model: chooseSubSources()
            Rectangle {
                height: banner_height
                width: subsource_name_id.implicitWidth + 20

                color: banner_color

                Text {
                    id: subsource_name_id
                    text: model.displayText
                    anchors {
                        top: parent.top
                        left: parent.left
                        margins: 10
                    }
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
            id: model_network_id
        }
    }

}
