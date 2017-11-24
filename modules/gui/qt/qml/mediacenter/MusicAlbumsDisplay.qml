/******************************************************
 * The component to display when category is "albums"
 ******************************************************/

import QtQuick 2.0
import QtQuick.Controls 2.0

import "qrc:///utils/" as Utils

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

            delegate : MusicAlbumsGridDelegate {
                width: vlc_style.cover_normal
                height: vlc_style.cover_normal+20
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
            model: medialib.getObjects()

            delegate : MusicAlbumsListDelegate { }

            ScrollBar.vertical: ScrollBar { }

            spacing: 2
        }
    }
}


