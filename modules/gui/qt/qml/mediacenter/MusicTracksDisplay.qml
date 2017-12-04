/******************************************************
 * The component to display when category is "tracks"
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

                cover: Image { source: model.track_cover || "qrc:///noart.png" }
                name: model.track_title || "Unknown track"

                onItemClicked: console.log('Clicked on details : '+model.track_title);
                onPlayClicked: {
                    console.log('Clicked on play : '+model.track_title);
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
                    text: (model.track_title || "Unknown track")+" - "+model.track_duration
                    font.bold: true
                    elide: Text.ElideRight
                    color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
                }

                onItemClicked: console.log("Clicked on : "+model.track_title)
            }

            ScrollBar.vertical: ScrollBar { }
        }
    }
}


