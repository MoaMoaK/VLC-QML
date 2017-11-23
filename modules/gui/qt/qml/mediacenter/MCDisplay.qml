import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Rectangle {
    function changedView() {
        viewLoader.item.changedView();
    }

    function changedCategory() {
        viewLoader.sourceComponent = chooseCat();
        reloadData();
        console.log( "Changed category : "+medialib.getCategory() );
    }

    function chooseCat() {
        if (medialib.getCategory() == 0)
            return albumsDisplayComponent;
        else if (medialib.getCategory() == 1)
            return artistsDisplayComponent;
        else if (medialib.getCategory() == 2)
            return genresDisplayComponent;
        else if (medialib.getCategory() == 3)
            return tracksDisplayComponent;
        else
            return albumsDisplayComponent;
    }

    function reloadData() {
        viewLoader.item.reloadData();
    }

    function reloadPresentation() {
        if ( medialib.hasPresentation() ) {
            presentationLoader_id.replace( presentationComponent_id );
            presentationLoader_id.height = vlc_style.heightBar_xlarge;
            presentationLoader_id.Layout.preferredHeigh = vlc_style.heightBar_xlarge;
            presentationLoader_id.Layout.minimumHeight = vlc_style.heightBar_xlarge;
            presentationLoader_id.Layout.maximumHeight = vlc_style.heightBar_xlarge;
        } else {
            presentationLoader_id.replace( noPresentationComponent_id );
            presentationLoader_id.height = 0;
            presentationLoader_id.Layout.preferredHeigh = 0;
            presentationLoader_id.Layout.minimumHeight = 0;
            presentationLoader_id.Layout.maximumHeight = 0;
        }

        console.log( "Presentation reloaded "+medialib.getPresObject() )
    }

    color: medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode

    ColumnLayout {
        anchors.fill : parent

        StackView {
            id: presentationLoader_id
            z:10
            Layout.fillWidth: true
            height: medialib.hasPresentation() ? vlc_style.heightBar_xlarge : 0
            Layout.preferredHeight: height
            Layout.minimumHeight: height
            Layout.maximumHeight: height
            initialItem: medialib.hasPresentation() ? presentationComponent_id : noPresentationComponent_id

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
                id: presentationComponent_id

                Presentation {
                    height: vlc_style.heightBar_xlarge

                    Layout.preferredHeight: height
                    Layout.minimumHeight: height
                    Layout.maximumHeight: height

                    obj: medialib.getPresObject();
                }
            }
            Component {
                id: noPresentationComponent_id

                Rectangle {
                    height: 0
                    Layout.preferredHeight: height
                    Layout.minimumHeight: height
                    Layout.maximumHeight: height
                }
            }
        }
        Loader {
            id: viewLoader
            z: 0
            Layout.fillWidth: true
            Layout.fillHeight: true
            sourceComponent: chooseCat()

            Component {
                id: albumsDisplayComponent

                MusicAlbumsDisplay {
                    width: vlc_style.cover_normal
                    height: vlc_style.cover_normal+20
                }
            }
            Component {
                id: artistsDisplayComponent

                MusicArtistsDisplay {
                    width: vlc_style.cover_normal
                    height: vlc_style.cover_normal+20
                }
            }
            Component {
                id: genresDisplayComponent

                MusicGenresDisplay {
                    width: vlc_style.cover_normal
                    height: vlc_style.cover_normal+20
                }
            }
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
