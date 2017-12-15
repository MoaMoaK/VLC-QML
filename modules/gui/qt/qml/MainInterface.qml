/********************************************************************
 * The main component that is displayed.
 * Display the source selection, the mediacenter and the playlist
 * all in the same QML view.
 ********************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4

import "qrc:///mediacenter/" as MC
import "qrc:///playlist/" as PL

Item {
    // The functions the C++ part can call
    function reloadData() { mcDisplay.reloadData();}
    function changedCategory() { mcDisplay.changedCategory(); }
    function changedView() { mcDisplay.changedView(); }
    function changedNightMode() {
        sourcesBanner.changedNightMode();
        subSourcesBanner.changedNightMode();
        mcDisplay.changedNightMode();
        plDisplay.changedNightMode();
    }
    function reloadPresentation() { mcDisplay.reloadPresentation(); }

    width: 1000
    height: 1000

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        ColumnLayout {
            id: column

            anchors.top: parent.top
            anchors.bottom: parent.bottom
            Layout.fillWidth: true
            Layout.minimumWidth: 500
            spacing: 0

            /* Source selection*/
            BannerSources {
                id: sourcesBanner

                // function triggered when a source is selected
                function selectSource ( name ) {
                    medialib.selectSource(name);
                    subSourcesBanner.update();
                }

                z : 10
                height: vlc_style.heightBar_normal
                Layout.preferredHeight: height
                Layout.minimumHeight: height
                Layout.maximumHeight: height
                Layout.fillWidth: true

                need_toggleView_button: true
            }

            /* Sub-source selection */
            SubBannerSources {
                id: subSourcesBanner

                // function triggered when a source is selected
                function selectSource ( name ) {
                    medialib.selectSource(name);
                    subSourcesBanner.update();
                }

                z : 10
                height: vlc_style.heightBar_normal
                Layout.preferredHeight: height
                Layout.minimumHeight: height
                Layout.maximumHeight: height
                Layout.fillWidth: true
            }

            /* MediaCenter */
            MC.MCDisplay {
                id: mcDisplay

                z: 0
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

        }

        /* Playlist */
        PL.PLDisplay {
            id: plDisplay

            z: 20
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            Layout.maximumWidth: 400

            default_width: 300
        }
    }




}
