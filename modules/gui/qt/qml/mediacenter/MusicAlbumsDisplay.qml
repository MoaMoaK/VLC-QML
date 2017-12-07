/******************************************************
 * The component to display when category is "albums"
 ******************************************************/

import QtQuick 2.0
import QtQuick.Controls 2.0

import "qrc:///utils/" as Utils

Loader {
    id: viewLoader

    // notify when the view has changed
    function changedView() {
        viewLoader.sourceComponent = medialib.isGridView() ? gridViewComponent_id : listViewComponent_id;
        console.log("View changed");
    }
    // Force the data to be reloaded
    function reloadData() {
        viewLoader.item.model = medialib.getObjects();
        console.log( "Data reloaded" );
    }

    sourceComponent: medialib.isGridView() ? gridViewComponent_id : listViewComponent_id

    /* Grid View */
    Component {
        id: gridViewComponent_id

        Utils.ExpandGridView {
            model: medialib.getObjects()

            cellWidth: vlc_style.cover_normal
            cellHeight: vlc_style.cover_normal+20
            expandHeight: 256

            rowSpacing: 1
            colSpacing: 1
            expandSpacing: 1
            expandCompact: true

            expandDuration: 200

            delegate : Utils.GridItem {
                width: vlc_style.cover_normal
                height: vlc_style.cover_normal+20

                cover : Image { source: model.album_cover || "qrc:///noart.png" }
                name : model.album_title || "Unknown title"
                date : model.album_release_year !== "0" ? model.album_release_year : ""
                infos : model.album_duration + " - " + model.album_nb_tracks + " tracks"

                onItemClicked : console.log('Clicked on details : '+model.album_title)
                onPlayClicked : {
                    console.log('Clicked on play : '+model.album_title);
                    medialib.addToPlaylist(currentIndex);
                }
            }
            expandDelegate: MusicAlbumsGridExpandDelegate {
                width: parent.parent.width
                height: 256
            }

            ScrollBar.vertical: ScrollBar { }
        }
    }

    /* List View */
    Component {
        id: listViewComponent_id

        ListView {
            spacing: 2

            model: medialib.getObjects()
            delegate : Utils.ListExpandItem {
                height: vlc_style.icon_normal
                width: parent.width

                cover: Image {
                    id: cover_obj

                    width: vlc_style.icon_normal
                    height: vlc_style.icon_normal

                    source: model.album_cover || "qrc:///noart.png"

                    states: State {
                        name: "expanded"
                        PropertyChanges {target: cover_obj; width: vlc_style.icon_xlarge; height: vlc_style.icon_xlarge}
                    }
                    Behavior on height { PropertyAnimation { duration: 100 } }
                    Behavior on width { PropertyAnimation { duration: 100 } }
                }
                line1: Text{
                    text: (model.album_title || "Unknown title")+" ["+model.album_duration+"]"
                    font.bold: true
                    elide: Text.ElideRight
                    color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
                }
                line2: Text{
                    text: model.album_main_artist || "Unknown artist"
                    elide: Text.ElideRight
                    color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
                    font.pixelSize: 8
                }
                expand: Utils.TracksDisplay {
                    height: album_nb_tracks * (2 + 12)
                    width: parent.width

                    tracks: album_tracks
                }

                onPlayClicked: {
                    console.log('Clicked on play : '+model.album_title);
                    medialib.addToPlaylist(index);
                }
            }

            ScrollBar.vertical: ScrollBar { }
        }
    }
}
