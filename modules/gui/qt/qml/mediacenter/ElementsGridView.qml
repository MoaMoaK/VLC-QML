import QtQuick 2.0
import QtQuick.Controls 2.0

import "qrc:///qml/"
//import "../utils"

GridView {

    function showDetails() {
        // To be implemented by the parent
        return ;
    }

    function changedCategory() {
        model = [];
        chooseCat();
        reloadData();
        console.log( "Changed category : "+medialib.getCategory() );
    }

    function chooseCat() {
        if (medialib.getCategory() == 0)
            delegate = gridAlbumsDelegateComponent_id;
        else
            delegate = gridArtistsDelegateComponent_id;
    }

    function reloadData() {
        model = medialib.getObjects();
        console.log( "Data reloaded" );
    }

    model: medialib.getObjects()

    cellWidth: 170
    cellHeight: 190

    delegate : chooseCat();

    ScrollBar.vertical: ScrollBar { }

    Component {
        id: gridAlbumsDelegateComponent_id

        MCGridAlbumsDelegate {
            width: 170
            height: 190
        }
    }
    Component {
        id: gridArtistsDelegateComponent_id

        MCGridArtistsDelegate {
            width: 170
            height: 190
        }
    }
}
