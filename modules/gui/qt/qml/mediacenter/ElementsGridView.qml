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
        else if (medialib.getCategory() == 1)
            delegate = gridArtistsDelegateComponent_id;
        else if (medialib.getCategory() == 2)
            delegate = gridGenresDelegateComponent_id;
        else
            delegate = gridTracksDelegateComponent_id;
    }

    function reloadData() {
        model = medialib.getObjects();
        console.log( "Data reloaded" );
    }

    model: medialib.getObjects()

    cellWidth: dimensions.cover_normal
    cellHeight: dimensions.cover_normal+20

    delegate : chooseCat();

    ScrollBar.vertical: ScrollBar { }

    Component {
        id: gridAlbumsDelegateComponent_id

        MCGridAlbumsDelegate {
            width: dimensions.cover_normal
            height: dimensions.cover_normal+20
        }
    }
    Component {
        id: gridArtistsDelegateComponent_id

        MCGridArtistsDelegate {
            width: dimensions.cover_normal
            height: dimensions.cover_normal+20
        }
    }
    Component {
        id: gridGenresDelegateComponent_id

        MCGridGenresDelegate {
            width: dimensions.cover_normal
            height: dimensions.cover_normal+20
        }
    }
    Component {
        id: gridTracksDelegateComponent_id

        MCGridTracksDelegate {
            width: dimensions.cover_normal
            height: dimensions.cover_normal+20
        }
    }
}
