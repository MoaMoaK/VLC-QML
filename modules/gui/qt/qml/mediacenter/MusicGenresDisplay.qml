/******************************************************
 * The component to display when category is "genres"
 ******************************************************/

import QtQuick 2.0
import QtQuick.Controls 2.0

Loader {

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

    id: viewLoader
    sourceComponent: medialib.isGridView() ? gridViewComponent_id : listViewComponent_id

    /* Grid View */
    Component {
        id: gridViewComponent_id
        GridView {
            model: medialib.getObjects()

            cellWidth: vlc_style.cover_normal
            cellHeight: vlc_style.cover_normal+20

            delegate : MusicGenresGridDelegate {
                width: vlc_style.cover_normal
                height: vlc_style.cover_normal+20
            }

            ScrollBar.vertical: ScrollBar { }
        }
    }

    /* List View */
    Component {
        id: listViewComponent_id
        ListView {
            model: medialib.getObjects()

            delegate : MusicGenresListDelegate { }

            ScrollBar.vertical: ScrollBar { }

            spacing: 2
        }
    }
}


