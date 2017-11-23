/************************************************************
 * The banner to display sources (Music, Video, Network)
 ************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {

    function toggleView () {
        medialib.toogleView();
    }

    function selectSource( name ) {
        // To be implemented by the parent
        return ;
    }

    property bool need_toggleView_button: false

    id: pLBannerSources
    color: medialib.isNightMode() ? vlc_style.bannerColor_nightmode : vlc_style.bannerColor_daymode

    RowLayout {
        anchors.fill: parent

        Repeater {
            // The repeater to display each button
            id: sourcesButtons
            Layout.fillHeight: true
            Layout.fillWidth: true

            model: buttonModel
            delegate: buttonView
        }

        ListModel {
            // The model telling the text to display, the
            // associated image and the name to send to medialib
            // in order to notify to change the medialib model
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

        Component {
            // One button for the sources = rect(img+txt)
            id: buttonView

            Rectangle {
                id: rect
                height: parent.height
                width: txt.implicitWidth + icon.width + vlc_style.margin_small*3

                color: medialib.isNightMode() ? vlc_style.bannerColor_nightmode : vlc_style.bannerColor_daymode

                Image {
                    id: icon

                    anchors {
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                        rightMargin: vlc_style.margin_xsmall
                        leftMargin: vlc_style.margin_small
                    }

                    source: model.pic
                    height: vlc_style.icon_normal
                    width: vlc_style.icon_normal
                    fillMode: Image.PreserveAspectFit
                }

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

        Image {
            // A button to choose the view displayed (list or grid)
            // Should be moved in the end
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            Layout.preferredHeight: height
            Layout.preferredWidth: width
            Layout.rightMargin: vlc_style.margin_normal
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



}


