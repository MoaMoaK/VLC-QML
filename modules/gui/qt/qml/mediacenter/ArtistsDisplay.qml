import QtQuick 2.0
import QtQuick.Controls 2.0

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
        GridView {
            model: medialib.getObjects()

            cellWidth: dimensions.cover_normal
            cellHeight: dimensions.cover_normal+20

            delegate : MCGridArtistsDelegate {
                width: dimensions.cover_normal
                height: dimensions.cover_normal+20
            }

            ScrollBar.vertical: ScrollBar { }
        }
    }
    Component {
        id: listViewComponent_id
        ListView {
            model: medialib.getObjects()

            delegate : MCListArtistsDelegate { }

            ScrollBar.vertical: ScrollBar { }

            spacing: 2
        }
    }
}


