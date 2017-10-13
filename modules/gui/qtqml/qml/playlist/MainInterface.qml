import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4

Item {
    width: 1000
    height: 1000

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        Column {
            id: column
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            Layout.fillWidth: true
            Layout.minimumWidth: 500

            BannerSources {
                id: sourcesBanner

                // Custom properties
                banner_color: "#e6e6e6"
                hover_color: "#d6d6d6"
                banner_height: 32
                need_toggleView_button: true

                // Basic properties
                z : 10

                function toggleView () {
                    mcDisplay.cycleViews();
                }

                function selectSource ( num ) {
                    mcDisplay.hideInfoMovie();
                    selector.setSourceFromNum( num );
                }
            }

            MCDisplay {
                id: mcDisplay

                // Custom properties
                media : m

                // Basic properties
                z: 0
                height : parent.height - sourcesBanner.height
                anchors.right: parent.right
                anchors.left: parent.left
            }

        }

        PLDisplay {
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
