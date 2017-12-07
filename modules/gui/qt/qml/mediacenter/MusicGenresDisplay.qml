/******************************************************
 * The component to display when category is "genres"
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

                cover: Utils.GenreCover { albums: model.genre_albums }
                name: model.genre_name || "Unknown genre"

                onItemClicked: {
                    console.log('Clicked on details : '+model.genre_name);
                    medialib.select( index );
                }
                onPlayClicked: {
                    console.log('Clicked on play : '+model.genre_name);
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
                height: vlc_style.heightBar_small
                width: parent.width

                line1: Text{
                    text: (model.genre_name || "Unknown genre")+" - "+model.genre_nb_tracks+" tracks"
                    font.bold: true
                    elide: Text.ElideRight
                    color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
                }

                onItemClicked: {
                    console.log("Clicked on : "+model.genre_name);
                    medialib.select( index );
                }
                onPlayClicked: {
                    console.log('Clicked on play : '+model.genre_name);
                    medialib.addToPlaylist(index);
                }
            }

            ScrollBar.vertical: ScrollBar { }
        }
    }
}


