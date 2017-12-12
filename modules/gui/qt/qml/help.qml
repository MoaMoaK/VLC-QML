import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.2

Item {
    id: item1
    width: 400
    height: 450

    Rectangle {
        id: rectangle
        color: "#efebe7"
        anchors.fill: parent

        Button {
            id: button
            x: 310
            y: 150
            text: qsTr("Close")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            onClicked: dialog.hide()
        }

        TextArea {
            id: textArea
            x: 10
            text: helpText
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.bottom: button.top
            anchors.bottomMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            readOnly: true
            textFormat: TextEdit.AutoText
            onLinkActivated: Qt.openUrlExternally(link)
            wrapMode: Text.WordWrap
        }

    }


}
