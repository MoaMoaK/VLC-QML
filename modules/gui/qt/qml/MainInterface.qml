import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4

import "qrc:///mediacenter/" as MC
import "qrc:///playlist/" as PL

Item {
    width: 1000
    height: 1000

    function reloadData() { mcDisplay.reloadData();}
    function changedCategory() { mcDisplay.changedCategory(); }
    function changedView() { mcDisplay.changedView(); }
    function reloadPresentation() { mcDisplay.reloadPresentation(); }

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

            BannerSources {
                id: sourcesBanner

                // Custom properties
                banner_color: "#e6e6e6"
                hover_color: "#d6d6d6"
                need_toggleView_button: true

                // Basic properties
                z : 10
                height: vlc_style.heightBar_normal
                Layout.preferredHeight: height
                Layout.minimumHeight: height
                Layout.maximumHeight: height
                Layout.fillWidth: true

                function selectSource ( name ) {
                    medialib.selectSource(name);
                    subSourcesBanner.update();
                }
            }

            SubBannerSources {
                id: subSourcesBanner

                // Custom properties
                banner_color: "#e6e6e6"
                hover_color: "#d6d6d6"

                // Basic properties
                z : 10
                height: vlc_style.heightBar_normal
                Layout.preferredHeight: height
                Layout.minimumHeight: height
                Layout.maximumHeight: height
                Layout.fillWidth: true

                function selectSource ( name ) {
                    medialib.selectSource(name);
                    subSourcesBanner.update();
                }
            }

            MC.MCDisplay {
                id: mcDisplay

                // Basic properties
                z: 0
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

        }

        PL.PLDisplay {
            // Custom properties
            pl: playlist
            default_width: 300

            // Basic properties
            z: 20
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            Layout.maximumWidth: 400
        }
    }




}
