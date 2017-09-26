import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: plDisplay

    property int default_width: 300
    property alias pl: listView.model

    width: default_width

    Image {
        id: toogleBar
        x: -20
        width: 20
        height: 20
        fillMode: Image.PreserveAspectFit
        source: "qrc:///toolbar/playlist"

        MouseArea {
            anchors.fill: parent
            onClicked: { plDisplay.width <= 20 ? openAnimation.running = true : closeAnimation.running = true }
        }
    }

    ListView {
        id: listView

        height: parent.height
        width: parent.width
        delegate: PLListViewDelegate {
            cur: model.current
            title: model.title
            duration: model.duration

            function singleClick() { }
            function doubleClick() { model.activate_item = 1 }
            function remove() { model.remove_item = 1 }
        }

        ScrollBar.vertical: ScrollBar { }

    }

    PropertyAnimation {
        id: closeAnimation
        target: plDisplay
        properties: "width"
        duration: 1000
        to: 0
        easing.type: Easing.InOutCubic
    }

    PropertyAnimation {
        id: openAnimation
        target: plDisplay
        properties: "width"
        duration: 1000
        to: default_width
        easing.type: Easing.InOutCubic
    }

}


