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

            cellWidth: vlc_style.cover_normal
            cellHeight: vlc_style.cover_normal+20

            delegate : MusicTracksGridDelegate {
                width: vlc_style.cover_normal
                height: vlc_style.cover_normal+20
            }

            ScrollBar.vertical: ScrollBar { }
        }
    }
    Component {
        id: listViewComponent_id
        ListView {
            model: medialib.getObjects()

            delegate : MusicTracksListDelegate { }

            ScrollBar.vertical: ScrollBar { }

            spacing: 2
        }
    }
}


