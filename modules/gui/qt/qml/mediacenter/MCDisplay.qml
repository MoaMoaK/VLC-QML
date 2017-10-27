import QtQuick 2.0
import QtQuick.Controls 2.0


StackView {
    id: stack

    property var media
    property string currentView: "music-albums"

    function setView( v ) {
        if ((v==="music" || v==="music-albums") && currentView!=="music-albums") {
            currentView = "music-albums";
            stack.replace(musicAlbumsView_id);
        } else if (v==="music-artists" && currentView!=="music-artists") {
            currentView = "music-artists";
            stack.replace(musicArtistsView_id);
        } else if (v==="music-genres" && currentView!=="music-genres") {
            currentView = "music-genres";
            stack.replace(musicGenresView_id);
        } else if (v==="music-tracks" && currentView!=="music-tracks") {
            currentView = "music-tracks";
            stack.replace(musicTracksView_id);
        } else if (v==="video" && currentView!=="video") {
            currentView = "video";
            stack.replace(videoView_id);
        } else if (v==="network" && currentView!=="network") {
            currentView = "network";
            stack.replace(networkView_id);
        }
    }

    function cycleViews () {
       currentItem.cycleViews();
    }

    height : parent.height
    anchors.left: parent.left
    anchors.right: parent.right

    initialItem: musicAlbumsView_id

    replaceEnter: Transition {
        PropertyAnimation {
            property: "opacity"
            from: 0
            to: 1
            duration: 200
        }
    }
    replaceExit: Transition {
        PropertyAnimation {
            property: "opacity"
            from: 1
            to: 0
            duration: 200
        }
    }

    Component {
        id: musicAlbumsView_id
        MCMusicAlbumsDisplay {
            height : stack.height
            anchors.left: stack.left
            anchors.right: stack.right
            media: stack.media
        }
    }

    Component {
        id: musicArtistsView_id
        MCMusicArtistsDisplay {
            height : stack.height
            anchors.left: stack.left
            anchors.right: stack.right
            media: stack.media
        }
    }

    Component {
        id: musicGenresView_id
        MCMusicGenresDisplay {
            height : stack.height
            anchors.left: stack.left
            anchors.right: stack.right
            media: stack.media
        }
    }

    Component {
        id: musicTracksView_id
        MCMusicTracksDisplay {
            height : stack.height
            anchors.left: stack.left
            anchors.right: stack.right
            media: stack.media
        }
    }

    Component {
        id: videoView_id
        MCVideoDisplay  {
            height : stack.height
            anchors.left: stack.left
            anchors.right: stack.right
            media: stack.media
        }
    }

    Component {
        id: networkView_id
        MCNetworkDisplay {
            height : stack.height
            anchors.left: stack.left
            anchors.right: stack.right
            media: stack.media
        }
    }

}
