import QtQuick 2.0

Rectangle {

    property int banner_height: 32
    property string banner_color: "#e6e6e6"
    property string hover_color: "#d6d6d6"

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


    ListModel {
        id: buttonModel
        ListElement { displayText: "Movie" ; num: 2 }
        ListElement { displayText: "Music" ; num: 3 }
        ListElement { displayText: "Pictures" ; num: 4 }
    }

    Component {
        id: buttonView

        Rectangle {
            id: rect
            anchors.top: parent.top
            anchors.topMargin: 0
            height: parent.height
            width: txt.implicitWidth + 20

            color: banner_color

            Text {
                id: txt

                anchors {
                    top: parent.top
                    left: parent.left
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


