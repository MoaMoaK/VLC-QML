import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {

    function toggleView () {
        // To be implemented by the parent
        return;
    }

    function selectSource( name ) {
        // To be implemented by the parent
        return ;
    }

    function sort( criteria ){
        // To be implemented by the parent
        return ;
    }

    property int banner_height: 32
    property color banner_color: "#e6e6e6"
    property color hover_color: "#d6d6d6"
    property bool need_toggleView_button: false

    id: pLBannerSources
    height: banner_height
    color: banner_color
    anchors.left: parent.left
    anchors.right: parent.right

    Row {
        anchors.fill: parent
        spacing: 0


        Repeater {
            id: sourcesButtons
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            model: buttonModel
            delegate: buttonView
        }

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

        Component {
            id: buttonView

            Rectangle {
                id: rect
                anchors.top: parent.top
                anchors.topMargin: 0
                height: parent.height
                width: txt.implicitWidth + icon.width + 20

                color: banner_color

                Image {
                    id: icon

                    anchors {
                        top: parent.top
                        left: parent.left
                        margins: 0
                    }

                    source: model.pic
                    height: 32
                    width: 32
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    id: txt

                    anchors {
                        top: parent.top
                        left: icon.right
                        margins: 10
                    }

                    text: model.displayText
                    font.pixelSize: 12
                }

//                Rectangle {
//                    id: sub_elts_rect_id
//                    anchors.top: parent.top
//                    anchors.left: txt.right
//                    anchors.topMargin: 0
//                    anchors.leftMargin: 10
//                    height: parent.height
//                    width: 0

//                    Behavior on width {
//                        PropertyAnimation { duration: 200; easing.type: Easing.InOutCubic; }
//                    }


//                    color: hover_color

//                    Row {
//                        id: sub_elts_row_id
//                        anchors.fill: parent
//                        spacing: 10
//                        Repeater {
//                            model: modelData.subElts
//                            Text {
//                                anchors.verticalCenter: parent.verticalCenter
//                                text: modelData.displayText + "  "
//                            }
//                        }
//                    }
//                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: selectSource( model.name )
                    hoverEnabled: true
                    onEntered: { rect.color = hover_color; /*sub_elts_rect_id.width = sub_elts_row_id.implicitWidth;*/ }
                    onExited: { rect.color = banner_color; /*sub_elts_rect_id.width = 0;*/ }
                }
            }
        }

        ComboBox {
            id: combo

            anchors.verticalCenter: parent.verticalCenter
            width: 150

            model: sortModel
            onCurrentIndexChanged: sort( sortModel.get(currentIndex).text )
        }

        ListModel {
            id: sortModel
            ListElement { text: "Alphabetic asc" }
            ListElement { text: "Alphabetic desc" }
            ListElement { text: "Duration asc" }
            ListElement { text: "Duration desc" }
            ListElement { text: "Date asc" }
            ListElement { text: "Date desc" }
            ListElement { text: "Artist asc" }
            ListElement { text: "Artist desc" }
        }
    }

    Image {
        height: parent.height - 10
        width: parent.height - 10
        anchors {
            top: parent.top
            right: parent.right
            topMargin: 5
            rightMargin: 20
        }
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


