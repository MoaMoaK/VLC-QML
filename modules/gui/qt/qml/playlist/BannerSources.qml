import QtQuick 2.0

Rectangle {

    function toggleView () {
        return;
    }

    property int banner_height: 32
    property string banner_color: "#e6e6e6"
    property string hover_color: "#d6d6d6"
    property bool need_toggleView_button: false

    id: pLBannerSources
    height: banner_height
    color: banner_color
    anchors.left: parent.left
    anchors.right: parent.right

    ListView {
        spacing: 0
        anchors.fill: parent
        orientation: ListView.Horizontal
        interactive: false

        model: buttonModel
        delegate: buttonView

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


    ListModel {
        id: buttonModel
        ListElement { displayText: "Movie" ; pic: "qrc:///sidebar/movie" ; num: 2 }
        ListElement { displayText: "Music" ; pic: "qrc:///sidebar/music" ; num: 3 }
        ListElement { displayText: "Pictures" ; pic: "qrc:///sidebar/pictures" ; num: 4 }
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

            MouseArea {
                anchors.fill: parent
                onClicked: selector.setSourceFromNum(num)
                hoverEnabled: true
                onEntered: { rect.color = hover_color }
                onExited: { rect.color = banner_color }
            }
        }
    }
}


