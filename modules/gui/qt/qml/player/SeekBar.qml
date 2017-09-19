import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import "qrc:///qml/"
//import "../utils/"

//Item {
//    height: 500
//    width: 1000

Slider {

    function getRatio( ) {
        return slider.value / (slider.maximumValue-slider.minimumValue);
    }

    anchors {
        left: parent.left
        right: parent.right
        margins: 10;
    }
    y: parent.height/2 - height/2
    id: slider

    value: seekBar.value

    style : SliderStyle {

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
        }
        handle: Rectangle {
            id: handle
            anchors.centerIn: parent
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
            state: slider.state == "hovered" ? "hovered" : ""

            states: [
                State {
                    name: "hovered"
                    PropertyChanges { target: handle ; opacity: 1.0 }
                }
            ]

            transitions: Transition {
                from: ""; to: "hovered"; reversible: true
                NumberAnimation {
                    properties: "opacity"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }

        }
    }

    TimeDisplayTip {
        id: timeDisplayTip
        text: (positionX/slider.width).toFixed(10).toString()
        opacity: 0.0
        x: Math.max( 0, Math.min( positionX - timeDisplayTip.width/2, parent.width - timeDisplayTip.width ) )
        y: 0 - height
    }

    states: [
        State {
            name: "hovered"
            PropertyChanges { target: timeDisplayTip ; opacity: 1.0 }
        }
    ]

    transitions: Transition {
        from: ""; to: "hovered"; reversible: true
        NumberAnimation {
            properties: "opacity"
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }

    MouseArea {
        id: sliderMouseArea
        propagateComposedEvents: true
        anchors.fill: slider
        hoverEnabled: true
        onEntered: { slider.state = "hovered" }
        onExited: { slider.state = "" }
        onMouseXChanged: {
            timeDisplayTip.positionX = mouseX
            if (sliderMouseArea.pressed) { slider.value = mouseX / slider.width }
        }
        onPressed: slider.value = mouseX / slider.width

    }

}
//}
