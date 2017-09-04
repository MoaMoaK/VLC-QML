import QtQuick 2.0

Item {
    Rectangle {
        anchors.fill: parent
        color: "#ffffff"

        ListView {
            spacing: 0
            anchors.fill: parent
            anchors.margins: 5
            orientation: ListView.Horizontal
            interactive: false

            model: buttonList
            delegate: ControlButton {

                iconURL: model.iconURL
                name: model.name
            }
        }
    }

    ListModel {
        id: buttonList
        ListElement {
            name: "Play"
            iconURL: "qrc:///toolbar/play_b"
        }
        ListElement {
            name: "Previous"
            iconURL: "qrc:///toolbar/previous_b"
        }
        ListElement {
            name: "Next"
            iconURL: "qrc:///toolbar/next_b"
        }
    }
}
