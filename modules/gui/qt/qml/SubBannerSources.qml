/****************************************************************************
 * The banner to display the sub sources (albums/genre/tracks/artists ...)
 ****************************************************************************/

import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

Rectangle {
    id: root_id

    // Choose wich listModel of sub-source to choose
    // according to the current category
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
    // Activated when the sort has been changed
    function sort( criteria ){
        medialib.sort(criteria);
        return ;
    }
    // Force to recalculate the colors
    function changedNightMode() {
        color = medialib.isNightMode() ? vlc_style.bannerColor_nightmode : vlc_style.bannerColor_daymode
        update();
    }
    // Choose the color of the text depending on the fact the
    // sub-source is the current one (red) or not (black/white)
    function chooseColor(index) {
        var c = medialib.getCategory();
        if (c === 0 && index === 0) return "#FF0000";
        if (c === 1 && index === 1) return "#FF0000";
        if (c === 2 && index === 2) return "#FF0000";
        if (c === 3 && index === 3) return "#FF0000";
        if (c === 4 && index === 0) return "#FF0000";
        if (c === 5 && index === 0) return "#FF0000";
        return medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
    }
    // Force the sub-source to be recalculated (used when category has been changed)
    function update() {
        stack_id.sourceComponent = undefined;
        stack_id.sourceComponent = chooseSubSources();
    }
    // Trigerred when a source is clicked
    // To be implemented by the parent
    function selectSource( name ) {
        return ;
    }

    anchors.left: parent.left
    anchors.right: parent.right
    color: medialib.isNightMode() ? vlc_style.bannerColor_nightmode : vlc_style.bannerColor_daymode

    RowLayout {
        anchors.fill: parent

        Loader {
            id: stack_id

            Layout.fillHeight: true
            Layout.fillWidth: true
            sourceComponent: chooseSubSources()
        }

        /* List of sub-sources for Music */
        Component {
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

                    /* A single button for a sub-source */
                    Rectangle {
                        height: parent.height
                        width: subsource_name_id.implicitWidth+vlc_style.margin_small*2
                        color: medialib.isNightMode() ? vlc_style.bannerColor_nightmode : vlc_style.bannerColor_daymode

                        Text {
                            id: subsource_name_id

                            anchors {
                                left: parent.left
                                right: parent.right
                                verticalCenter: parent.verticalCenter
                                rightMargin: vlc_style.margin_small
                                leftMargin: vlc_style.margin_small
                            }
                            text: model.displayText
                            color: chooseColor(index)

                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: selectSource( model.name )
                            hoverEnabled: true
                            onEntered: { parent.color = medialib.isNightMode() ? vlc_style.hoverBannerColor_nightmode : vlc_style.hoverBannerColor_daymode; }
                            onExited: { parent.color = medialib.isNightMode() ? vlc_style.bannerColor_nightmode : vlc_style.bannerColor_daymode; }
                        }
                    }
                }
            }
        }

        /* List of sub-sources for Video */
        Component {
            id: model_video_id

            RowLayout {

                Repeater {
                    id: repeater_id

                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    model: ListModel {
                        ListElement { displayText: "TV shows" ; name: "video" }
                        ListElement { displayText: "Seasons" ; name: "video" }
                        ListElement { displayText: "Videos" ; name: "video" }
                    }

                    /* A single button for a sub-source */
                    Rectangle {
                        height: parent.height
                        width: subsource_name_id.implicitWidth+vlc_style.margin_small*2

                        color: medialib.isNightMode() ? vlc_style.bannerColor_nightmode : vlc_style.bannerColor_daymode

                        Text {
                            id: subsource_name_id

                            anchors {
                                left: parent.left
                                right: parent.right
                                verticalCenter: parent.verticalCenter
                                rightMargin: vlc_style.margin_small
                                leftMargin: vlc_style.margin_small
                            }

                            text: model.displayText
                            color: chooseColor(index)
                        }

                        MouseArea {
                            anchors.fill: parent

                            onClicked: selectSource( model.name )
                            hoverEnabled: true
                            onEntered: { parent.color = medialib.isNightMode() ? vlc_style.hoverBannerColor_nightmode : vlc_style.hoverBannerColor_daymode; }
                            onExited: { parent.color = medialib.isNightMode() ? vlc_style.bannerColor_nightmode : vlc_style.bannerColor_daymode; }
                        }
                    }
                }
            }
        }

        /* List of sub-sources for Network */
        Component {
            id: model_network_id

            RowLayout {

                Repeater {
                    id: repeater_id

                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    model: ListModel { }

                    /* A single button for a sub-source */
                    Rectangle {
                        height: parent.height
                        width: subsource_name_id.implicitWidth+vlc_style.margin_small*2

                        color: medialib.isNightMode() ? vlc_style.bannerColor_nightmode : vlc_style.bannerColor_daymode

                        Text {
                            id: subsource_name_id

                            anchors {
                                left: parent.left
                                right: parent.right
                                verticalCenter: parent.verticalCenter
                                rightMargin: vlc_style.margin_small
                                leftMargin: vlc_style.margin_small
                            }

                            text: model.displayText
                            color: chooseColor(index)
                        }

                        MouseArea {
                            anchors.fill: parent

                            onClicked: selectSource( model.name )
                            hoverEnabled: true
                            onEntered: { parent.color = medialib.isNightMode() ? vlc_style.hoverBannerColor_nightmode : vlc_style.hoverBannerColor_daymode; }
                            onExited: { parent.color = medialib.isNightMode() ? vlc_style.bannerColor_nightmode : vlc_style.bannerColor_daymode; }
                        }
                    }
                }
            }
        }

        /* Selector to choose a specific sorting operation */
        ComboBox {
            id: combo

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            Layout.preferredWidth: width
            width: 150

            model: sortModel
            onActivated: sort( sortModel.get(index).text )
        }

        /* Model for the different possible sorts */
        ListModel {
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
