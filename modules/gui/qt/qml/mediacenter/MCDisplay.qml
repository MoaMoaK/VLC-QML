/*************************************************
 * The main component to display the mediacenter
 *************************************************/

import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Rectangle {

    // Notify the view has beeen changed
    function changedView() {
        viewLoader.item.changedView();
    }

    // Notify the category has been changed
    function changedCategory() {
        viewLoader.sourceComponent = chooseCat();
        reloadData();
        console.log( "Changed category : "+medialib.getCategory() );
    }

    // Function to get which component to display according to the category
    function chooseCat() {
        var cat = medialib.getCategory();
        if (cat === 0)
            return albumsDisplayComponent;
        else if (cat === 1)
            return artistsDisplayComponent;
        else if (cat === 2)
            return genresDisplayComponent;
        else if (cat === 3)
            return tracksDisplayComponent;
        else
            return albumsDisplayComponent;
    }

    // Force the data inside the displayed view to de reloaded
    function reloadData() {
        viewLoader.item.reloadData();
    }

    // Force to recalculate if the presentation needs to be displayed
    function reloadPresentation() {
        if ( medialib.hasPresentation() ) {
            presentationLoader_id.sourceComponent = presentationComponent_id;
        } else {
            presentationLoader_id.sourceComponent = noPresentationComponent_id;
       }
    }

    color: medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode

    ColumnLayout {
        anchors.fill : parent

        /* The Presentation Bar */
        Loader {
            id: presentationLoader_id
            z:10
            Layout.fillWidth: true
            height: item.height
            Layout.preferredHeight: height
            Layout.minimumHeight: height
            Layout.maximumHeight: height
            sourceComponent: medialib.hasPresentation() ? presentationComponent_id : noPresentationComponent_id

            // If the presentation bar should be displayed
            Component {
                id: presentationComponent_id

                Presentation {
                    height: vlc_style.heightBar_xlarge

                    Layout.preferredHeight: height
                    Layout.minimumHeight: height
                    Layout.maximumHeight: height

                    obj: medialib.getPresObject();
                }
            }
            // If the presentation bar should be hidden
            Component {
                id: noPresentationComponent_id

                Item {
                    height: 0
                    Layout.preferredHeight: height
                    Layout.minimumHeight: height
                    Layout.maximumHeight: height
                }
            }
        }

        /* The data elements */
        Loader {
            id: viewLoader
            z: 0
            Layout.fillWidth: true
            Layout.fillHeight: true
            sourceComponent: chooseCat()
            // Display some 'Artists' items
            Component {
                id: albumsDisplayComponent

                MusicAlbumsDisplay {
                    width: vlc_style.cover_normal
                    height: vlc_style.cover_normal+20
                }
            }
            // Display some 'Albums' items
            Component {
                id: artistsDisplayComponent

                MusicArtistsDisplay {
                    width: vlc_style.cover_normal
                    height: vlc_style.cover_normal+20
                }
            }
            // Display some 'Genres' items
            Component {
                id: genresDisplayComponent

                MusicGenresDisplay {
                    width: vlc_style.cover_normal
                    height: vlc_style.cover_normal+20
                }
            }
            // Display some 'Tracks' items
            Component {
                id: tracksDisplayComponent

                MusicTracksDisplay {
                    width: vlc_style.cover_normal
                    height: vlc_style.cover_normal+20
                }
            }
        }
    }
}
