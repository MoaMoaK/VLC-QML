import QtQuick 2.0

Item {
    id: plDisplay


    property alias pl: listView.model

    Rectangle {
        id: toogleBar
        color: "#00FF00"
        x: -20
        width: 20
        height: 20

        MouseArea {
            anchors.fill: parent

            onClicked: { plDisplay.state = plDisplay.state == "" ? "hidden" : "" ; }
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
        }

    }

    states: [State {
            name: "hidden"
            PropertyChanges { target: plDisplay ; width: 0 }
        }
    ]

    transitions: [
        Transition {
            from: ""
            to: "hidden"
            reversible: true
            PropertyAnimation {
                properties: "width"
                duration: 1000
                easing.type: Easing.InOutCubic
            }
        }

    ]

}


