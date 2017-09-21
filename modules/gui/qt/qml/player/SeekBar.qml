import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import "qrc:///qml/"
//import "../utils/"

//Item {
//    height: 500
//    width: 1000

Slider {

    function getTimeDispFromSec( sec ) {
        var min = Math.floor( sec/60 );
        sec = sec%60;
        var h = Math.floor( min/60 );
        min = min%60;
        var time = sec.toString();
        time = min.toString() + ":" + time;
        time = h.toString() + ":" + time;
        return time;
    }

    function getSecFromValue( val ) {
        return Math.floor( val * seekBar.getInputLength() / ( slider.maximumValue-slider.minimumValue ) );
    }

    function getValueFromPosX( posX ) {
        return ( posX/slider.width ) * ( slider.maximumValue-slider.minimumValue )
    }

    function getTimeDispFromPosX( posX ) {
        return getTimeDispFromSec(getSecFromValue(getValueFromPosX(posX)));
    }

    function getRatio( ) {
        return slider.value / (slider.maximumValue-slider.minimumValue);
    }


    id: slider

    maximumValue: seekBar.maximum
    minimumValue: seekBar.minimum
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
            Chapters {
                id: chap
                anchors {
                    left: background.left
                    right: background.right
                    top: background.bottom
                }
                height: 5
                seek_bar: seekBar
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
            state: slider.state == "hovered" ? "hovered" : ""

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

    TimeDisplayTip {
        id: timeDisplayTip
        opacity: 0.0
        x: Math.max( 0, Math.min( positionX - timeDisplayTip.width/2, parent.width - timeDisplayTip.width ) )
        y: 0 - height+7
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
            timeDisplayTip.positionX = mouseX;
            timeDisplayTip.text = getTimeDispFromPosX(mouseX);
            if (sliderMouseArea.pressed) {
                seekBar.value = getValueFromPosX(mouseX);
                seekBar.updatePos();
            }
        }
        onPressed: {
            seekBar.value = getValueFromPosX(mouseX);
            seekBar.updatePos();
        }
    }

}
//}
