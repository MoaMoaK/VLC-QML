import QtQuick 2.0
import QtQuick.Controls 2.0

ListView {

    function changedCategory() {
        model = [];
        if (medialib.getCategory() == 0) {
            delegate = listAlbumsDelegateComponent_id;
        } else {
            delegate = listArtistsDelegateComponent_id;
        }
        reloadData();
        console.log( "Changed category : "+medialib.getCategory() );

    }

    function reloadData() {
        model = medialib.getObjects();
        console.log( "Data reloaded" );
    }

    model: medialib.getObjects()

    delegate : listAlbumsDelegateComponent_id

    ScrollBar.vertical: ScrollBar { }

    Component {
        id: listAlbumsDelegateComponent_id

        MCListAlbumsDelegate { }
    }
    Component {
        id: listArtistsDelegateComponent_id

        MCListArtistsDelegate { }
    }
}
