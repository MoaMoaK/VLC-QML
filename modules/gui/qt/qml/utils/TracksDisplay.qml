/***********************************************
 * A component to display a listview of tracks
 ***********************************************/

import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    property var tracks: []
    property int parentIndex: 0

    ListView {
        id: expand_track_id

        x: 30
        height: parent.height
        width: parent.width - x

        model: tracks
        delegate: ListItem {
            height: vlc_style.heightBar_small
            width: parent.width

            line1: Text{
                text: (model.track_title || "Unknown track")+" - "+model.track_duration
                elide: Text.ElideRight
                color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
            }

            onItemClicked: console.log("Clicked on : "+model.track_title)
            onPlayClicked: {
                console.log('Clicked on play : '+model.track_title);
                medialib.addAndPlay(parentIndex, index);
            }
            onAddToPlaylistClicked: {
                console.log('Clicked on addToPlaylist : '+model.track_title);
                medialib.addToPlaylist(parentIndex, index);
            }
        }

        ScrollBar.vertical: ScrollBar { }
    }
}
