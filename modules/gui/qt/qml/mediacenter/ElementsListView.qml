import QtQuick 2.0
import QtQuick.Controls 2.0

ListView {

    function changedCategory() {
        model = [];
        chooseCat();
        reloadData();
        console.log( "Changed category : "+medialib.getCategory() );
    }

    function chooseCat() {
        if (medialib.getCategory() == 0)
            delegate = listAlbumsDelegateComponent_id;
        else if (medialib.getCategory() == 1)
            delegate = listArtistsDelegateComponent_id;
        else if (medialib.getCategory() == 2)
            delegate = listGenresDelegateComponent_id;
        else if (medialib.getCategory() == 3)
            delegate = listTracksDelegateComponent_id;
        else
            delegate = listAlbumsDelegateComponent_id;
    }

    function reloadData() {
        console.log( "Reload started : " + medialib.getObjects() )
        model = medialib.getObjects();
        console.log( "Data reloaded" );
    }

    model: medialib.getObjects()

    delegate : chooseCat();

    ScrollBar.vertical: ScrollBar { }

    Component {
        id: listAlbumsDelegateComponent_id

        MCListAlbumsDelegate { }
    }
    Component {
        id: listArtistsDelegateComponent_id

        MCListArtistsDelegate { }
    }
    Component {
        id: listGenresDelegateComponent_id

        MCListGenresDelegate { }
    }
    Component {
        id: listTracksDelegateComponent_id

        MCListTracksDelegate { }
    }
}
