import QtQuick 2.0
import QtQuick.Controls.Styles 1.4

SliderStyle {
    id: style

    property bool hovered : false
    property var seek_bar

    groove: Item{
        implicitWidth: 200
        implicitHeight: 10
        Rectangle {
            id: background
            width: parent.width
            height: parent.height
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#BCB9B5"; }
                GradientStop { position: 1.0; color: "#DAD6D3"; }
            }
            radius: 3
        }
        Rectangle {
            id: foreground
            width: parent.width*getRatio( );
            height: parent.height
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#2B85DA"; }
                GradientStop { position: 1.0; color: "#287DCC"; }
            }
            radius: 3
        }
        Chapters {
            id: chap
            anchors {
                left: background.left
                right: background.right
                top: background.bottom
            }
            height: 5
            opacity: 0.0
            seek_bar: style.seek_bar
            state: style.hovered ? "hovered" : ""

            states: [
                State {
                    name: "hovered"
                    PropertyChanges { target: chap ; opacity: 1.0 }
                }
            ]

            transitions: Transition {
                from: ""; to: "hovered"; reversible: true;
                NumberAnimation {
                    properties: "opacity";
                    duration: 200;
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }



    handle: Rectangle {
        id: handle
        x: parent.width*getRatio() - handle.width/2;
        anchors.verticalCenter: parent.verticalCenter;
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#E1E0DF"; }
            GradientStop { position: 1.0; color: "#C4C1BD"; }
        }
        border.color: "#ABA9A9"
        border.width: 1
        implicitWidth: 16
        implicitHeight: 16
        radius: 16
        opacity: 0.0
        state: style.hovered ? "hovered" : ""

        states: [
            State {
                name: "hovered"
                PropertyChanges { target: handle ; opacity: 1.0 }
            }
        ]

        transitions: Transition {
            from: ""; to: "hovered"; reversible: true;
            SequentialAnimation {
                NumberAnimation {
                    properties: "opacity";
                    duration: 500;
                    easing.type: Easing.OutQuart;
                }
                NumberAnimation { duration: 1500; }
            }
        }
    }



}
