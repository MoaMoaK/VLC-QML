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

    property color banner_color: "#e6e6e6"
    property color hover_color: "#d6d6d6"
    property bool need_toggleView_button: false

    id: pLBannerSources
    color: banner_color

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
                width: txt.implicitWidth + icon.width + dimensions.margin_small*3

                color: banner_color

                Image {
                    id: icon

                    anchors {
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                        rightMargin: dimensions.margin_xsmall
                        leftMargin: dimensions.margin_small
                    }

                    source: model.pic
                    height: dimensions.icon_normal
                    width: dimensions.icon_normal
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    id: txt

                    anchors {
                        left: icon.right
                        verticalCenter: parent.verticalCenter
                        rightMargin: dimensions.margin_small
                        leftMargin: dimensions.margin_xsmall
                    }

                    text: model.displayText
                    font.pixelSize: dimensions.fontSize_normal
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: selectSource( model.name )
                    hoverEnabled: true
                    onEntered: { rect.color = hover_color; }
                    onExited: { rect.color = banner_color; }
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
            Layout.rightMargin: dimensions.margin_normal
            height: dimensions.icon_normal
            width: dimensions.icon_normal

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


