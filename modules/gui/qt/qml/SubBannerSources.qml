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
        var c = medialib.getCategory();
        if (c >= 0 && c <= 3) {
            return model_music_id;
        } else if (c===4) {
            return model_video_id;
        } else {
            return model_network_id;
        }
    }

    function sort( criteria ){
        medialib.sort(criteria);
        return ;
    }

    function chooseColor(index) {
        var c = medialib.getCategory();
        if (c === 0 && index === 0) return "#FF0000";
        if (c === 1 && index === 1) return "#FF0000";
        if (c === 2 && index === 2) return "#FF0000";
        if (c === 3 && index === 3) return "#FF0000";
        if (c === 4 && index === 0) return "#FF0000";
        if (c === 5 && index === 0) return "#FF0000";
        return "#000000";
    }

    function update() {
        stack_id.sourceComponent = undefined;
        stack_id.sourceComponent = chooseSubSources();
    }

    function selectSource( name ) {
        // To be implemented by the parent
        return ;
    }
    anchors.left: parent.left
    anchors.right: parent.right

    color: banner_color

    RowLayout {
        anchors.fill: parent

        Loader {
            id: stack_id
            Layout.fillHeight: true
            Layout.fillWidth: true
            sourceComponent: chooseSubSources()
        }

        Component {
            // The list of sub-sources for Music
            id: model_music_id

            RowLayout {

                Repeater {
                    id: repeater_id
                    model: ListModel {
                        ListElement { displayText: "Albums" ; name: "music-albums" }
                        ListElement { displayText: "Artistes" ; name: "music-artists" }
                        ListElement { displayText: "Genre" ; name: "music-genre" }
                        ListElement { displayText: "Tracks" ; name: "music-tracks" }
                    }
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Rectangle {
                        // A single button for a sub-source
                        height: parent.height
                        width: subsource_name_id.implicitWidth+dimensions.margin_small*2
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
                            color: chooseColor(index)

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
            }
        }

        Component {
            // The list of sub-sources for Video
            id: model_video_id

            RowLayout {

                Repeater {
                    id: repeater_id
                    model: ListModel {
                        ListElement { displayText: "TV shows" ; name: "video" }
                        ListElement { displayText: "Seasons" ; name: "video" }
                        ListElement { displayText: "Videos" ; name: "video" }
                    }
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Rectangle {
                        // A single button for a sub-source
                        height: parent.height
                        width: subsource_name_id.implicitWidth+dimensions.margin_small*2
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
                            color: chooseColor(index)

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
            }
        }

        Component {
            // The list of sub-sources for Network
            id: model_network_id

            RowLayout {

                Repeater {
                    id: repeater_id
                    model: ListModel { }
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Rectangle {
                        // A single button for a sub-source
                        height: parent.height
                        width: subsource_name_id.implicitWidth+dimensions.margin_small*2
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
                            color: chooseColor(index)

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
            }
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
