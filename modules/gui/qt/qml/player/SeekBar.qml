import QtQuick 2.0
import QtQuick.Controls 2.2

Item {
    Rectangle {
        anchors.fill: parent
        color: "#ffffff"

        Slider {
            anchors {
                fill: parent
                margins: 10;
            }

            id: slider
            x: 51
            y: 104
            value: 0.5
        }


    }
}
