/************************************************************
 * The banner to display sources (Music, Video, Network)
 ************************************************************/

import QtQuick 2.0

Rectangle {
    id: pLBannerSources

    property bool need_toggleView_button: false

    // Triggered when the toogleView button is selected
    function toggleView () {
        medialib.toogleView();
    }
    // Force to recalculate the colors
    function changedNightMode() {
        color = medialib.isNightMode() ? vlc_style.bannerColor_nightmode : vlc_style.bannerColor_daymode;
        update();
    }
    // Force the source to be redrawn
    function update() {
        sourcesButtons.model = undefined;
        sourcesButtons.model = buttonModel;
    }
    // Trigerred when a source is clicked
    // To be implemented by the parent
    function selectSource( name ) {
        return ;
    }

    color: medialib.isNightMode() ? vlc_style.bannerColor_nightmode : vlc_style.bannerColor_daymode

    Row {
        anchors.fill: parent

        /* Repeater to display each button */
        Repeater {
            id: sourcesButtons

            model: buttonModel
            delegate: buttonView
        }

        /* Model telling the text to display */
        // The associated image and the name to send to medialib
        // in order to notify to change the medialib model
        ListModel {
            id: buttonModel

            ListElement {
                displayText: "Music"
                pic: "qrc:///sidebar/music"
                name: "music"
            }
            ListElement {
                displayText: "Video"
                pic: "qrc:///sidebar/movie"
                name: "video"
            }
            ListElement {
                displayText: "Network"
                pic: "qrc:///sidebar/screen"
                name: "network"
            }
        }

        /* Button for the sources */
        Component {
            id: buttonView

            Rectangle {
                id: rect

                height: parent.height
                width: txt.implicitWidth + icon.width + vlc_style.margin_small*3

                color: medialib.isNightMode() ? vlc_style.bannerColor_nightmode : vlc_style.bannerColor_daymode

                /* Icon for this source */
                Image {
                    id: icon

                    anchors {
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                        rightMargin: vlc_style.margin_xsmall
                        leftMargin: vlc_style.margin_small
                    }
                    height: vlc_style.icon_normal
                    width: vlc_style.icon_normal

                    source: model.pic
                    fillMode: Image.PreserveAspectFit
                }

                /* Name of this source */
                Text {
                    id: txt

                    anchors {
                        left: icon.right
                        verticalCenter: parent.verticalCenter
                        rightMargin: vlc_style.margin_small
                        leftMargin: vlc_style.margin_xsmall
                    }

                    text: model.displayText
                    font.pixelSize: vlc_style.fontSize_normal
                    color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: selectSource( model.name )
                    hoverEnabled: true
                    onEntered: { rect.color = medialib.isNightMode() ? vlc_style.hoverBannerColor_nightmode : vlc_style.hoverBannerColor_daymode; }
                    onExited: { rect.color = medialib.isNightMode() ? vlc_style.bannerColor_nightmode : vlc_style.bannerColor_daymode; }
                }
            }
        }
    }

    /* button to choose the view displayed (list or grid) */
    Image {
        anchors.right: parent.right
        anchors.rightMargin: vlc_style.margin_normal
        anchors.verticalCenter: parent.verticalCenter
        height: vlc_style.icon_normal
        width: vlc_style.icon_normal

        fillMode: Image.PreserveAspectFit
        source: "qrc:///toolbar/tv"

        enabled: need_toggleView_button
        visible: need_toggleView_button

        MouseArea {
            anchors.fill: parent

            enabled: need_toggleView_button
            onClicked: toggleView()
        }
    }



}


