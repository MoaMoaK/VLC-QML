import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
//    height: 42
//    width: 200
    Rectangle {
        anchors.fill: parent
        color: "#ffffff"

        Slider {
            anchors {
                fill: parent
                margins: 10;
            }

            id: slider
            value: seekBar.getValueRatio()
        }
    }
}
