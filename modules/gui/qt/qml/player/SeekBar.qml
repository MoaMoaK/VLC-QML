import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Slider {

    anchors {
        fill: parent
        margins: 10;
    }
    id: slider
    value: 0.5

    style : SliderStyle {

        groove: Item{
            id: background
            implicitWidth: 200
            implicitHeight: 10
            Rectangle {
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
                width: parent.width*slider.value
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
            opacity: 1.0


        }
    }

    }

}

