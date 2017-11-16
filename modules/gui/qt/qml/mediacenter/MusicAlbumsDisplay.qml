import QtQuick 2.0
import QtQuick.Controls 2.0

import "qrc:///utils/" as Utils

Loader {

    function changedView() {
        viewLoader.sourceComponent = medialib.isGridView() ? gridViewComponent_id : listViewComponent_id;
        console.log("View changed");
    }

    function reloadData() {
        viewLoader.item.model = medialib.getObjects();
        console.log( "Data reloaded" );
    }

    id: viewLoader
    sourceComponent: medialib.isGridView() ? gridViewComponent_id : listViewComponent_id

    Component {
        id: gridViewComponent_id
        Utils.ExpandGridView {
            model: medialib.getObjects()

            cellWidth: dimensions.cover_normal
            cellHeight: dimensions.cover_normal+20
            expandHeight: 150

            rowSpacing: 1
            colSpacing: 1
            expandSpacing: 1
            expandCompact: true

            expandDuration: 200

            delegate : MusicAlbumsGridDelegate {
                width: dimensions.cover_normal
                height: dimensions.cover_normal+20
            }
            expandDelegate: MusicAlbumsGridExpandDelegate {
                width: parent.parent.width
                height: parent.parent.height
            }

            ScrollBar.vertical: ScrollBar { }
        }
    }
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


