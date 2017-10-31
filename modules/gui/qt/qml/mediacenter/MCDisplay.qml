import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3


ColumnLayout {

    function changedView() {
        viewLoader.sourceComponent = medialib.isGridView() ? gridViewComponent_id : listViewComponent_id;
        console.log("View changed");
    }

    function changedCategory() {
        viewLoader.item.changedCategory();
    }

    function reloadData() {
        viewLoader.item.reloadData();
    }

    Presentation {
        z: 10
        Layout.fillWidth: true
        height: medialib.hasPresentation() ? dimensions.heightBar_xlarge : 0
        Layout.preferredHeight: height
        Layout.minimumHeight: height
        Layout.maximumHeight: height
    }
    Loader {
        id: viewLoader
        z: 0
        Layout.fillWidth: true
        Layout.fillHeight: true
        sourceComponent: medialib.isGridView() ? gridViewComponent_id : listViewComponent_id
    }

    Component {
        id: gridViewComponent_id
        ElementsGridView {
            id: gridView_id
        }
    }

    Component {
        id: listViewComponent_id
        ElementsListView {
            id: listView_id
        }
    }
}



//StackView {
//    id: stack

//    property string currentView: "music-albums"

//    function setView( v ) {
//        if ((v==="music" || v==="music-albums") && currentView!=="music-albums") {
//            currentView = "music-albums";
//            stack.replace(musicAlbumsView_id);
//        } else if (v==="music-artists" && currentView!=="music-artists") {
//            currentView = "music-artists";
//            stack.replace(musicArtistsView_id);
//        } else if (v==="music-genres" && currentView!=="music-genres") {
//            currentView = "music-genres";
//            stack.replace(musicGenresView_id);
//        } else if (v==="music-tracks" && currentView!=="music-tracks") {
//            currentView = "music-tracks";
//            stack.replace(musicTracksView_id);
//        } else if (v==="video" && currentView!=="video") {
//            currentView = "video";
//            stack.replace(videoView_id);
//        } else if (v==="network" && currentView!=="network") {
//            currentView = "network";
//            stack.replace(networkView_id);
//        }
//    }

//    function cycleViews () {
//       currentItem.cycleViews();
//    }

//    height : parent.height
//    anchors.left: parent.left
//    anchors.right: parent.right

//    initialItem: musicAlbumsView_id

//    replaceEnter: Transition {
//        PropertyAnimation {
//            property: "opacity"
//            from: 0
//            to: 1
//            duration: 200
//        }
//    }
//    replaceExit: Transition {
//        PropertyAnimation {
//            property: "opacity"
//            from: 1
//            to: 0
//            duration: 200
//        }
//    }

//    Component {
//        id: musicAlbumsView_id
//        MCMusicAlbumsDisplay {
//            height : stack.height
//            anchors.left: stack.left
//            anchors.right: stack.right
//            media: medialib
//        }
//    }

//    Component {
//        id: musicArtistsView_id
//        MCMusicArtistsDisplay {
//            height : stack.height
//            anchors.left: stack.left
//            anchors.right: stack.right
//            media: medialib
//        }
//    }

//    Component {
//        id: musicGenresView_id
//        MCMusicGenresDisplay {
//            height : stack.height
//            anchors.left: stack.left
//            anchors.right: stack.right
//            media: medialib
//        }
//    }

//    Component {
//        id: musicTracksView_id
//        MCMusicTracksDisplay {
//            height : stack.height
//            anchors.left: stack.left
//            anchors.right: stack.right
//            media: medialib
//        }
//    }

//    Component {
//        id: videoView_id
//        MCVideoDisplay  {
//            height : stack.height
//            anchors.left: stack.left
//            anchors.right: stack.right
//            media: medialib
//        }
//    }

//    Component {
//        id: networkView_id
//        MCNetworkDisplay {
//            height : stack.height
//            anchors.left: stack.left
//            anchors.right: stack.right
//            media: medialib
//        }
//    }

//}
