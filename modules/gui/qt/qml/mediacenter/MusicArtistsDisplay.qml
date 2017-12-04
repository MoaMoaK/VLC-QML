/******************************************************
 * The component to display when category is "artists"
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

        GridView {
            cellWidth: vlc_style.cover_normal
            cellHeight: vlc_style.cover_normal+20

            model: medialib.getObjects()
            delegate : Utils.GridItem {
                width: vlc_style.cover_normal
                height: vlc_style.cover_normal+20

                cover: Utils.ArtistCover {
                    albums: model.artist_albums
                    nb_albums: model.artist_nb_albums
                }
                name: model.artist_name || "Unknown Artist"

                onItemClicked: {
                    console.log('Clicked on details : '+model.artist_name);
                    medialib.select( index );
                }
                onPlayClicked: {
                    console.log('Clicked on play : '+model.artist_name);
                    medialib.addToPlaylist(index);
                }
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
            delegate : Utils.ListItem {
                height: vlc_style.icon_normal
                width: parent.width

                cover: Image {
                    height: vlc_style.icon_normal
                    width: vlc_style.icon_normal

                    source: model.artist_cover || "qrc:///noart.png"
                }
                line1: Text{
                    text: model.artist_name || "Unknown artist"
                    font.bold: true
                    elide: Text.ElideRight
                    color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
                }

                onItemClicked: {
                    console.log("Clicked on : "+model.artist_name);
                    medialib.select( index );
                }
            }

            ScrollBar.vertical: ScrollBar { }
        }
    }
}


