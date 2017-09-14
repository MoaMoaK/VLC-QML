import QtQuick 2.0

Item {

    Column {
        anchors.fill: parent
        Rectangle {
            height: 42
            width: parent.width
            color: "#ffffff"

            SeekBar { }
        }

        Rectangle {
            height: 42
            width: parent.width
            color: "#ffffff"

            ListView {
                spacing: 5
                anchors.fill: parent
                anchors.margins: 5
                orientation: ListView.Horizontal
                interactive: false

                model: buttonList
                delegate: ControlButton {

                    iconURL: model.icon
                    name: model.text

                    function singleClick() { model.single_click = 1; }
                    function doubleClick() { model.double_click = 2; }
                }
            }
        }
    }

}
