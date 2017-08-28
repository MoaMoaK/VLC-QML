import QtQuick 2.0

Rectangle {

    property bool cur
    property string title
    property string duration

    color: cur ? "#CCCCCC" : "#FFFFFF"
    width : parent.width
    height:  textInfo.implicitHeight
    Text {
        id: textInfo
        text: duration ? '[' + duration + '] ' + (title ? title : "") : (title ? title : "")
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            parent.color = cur ? "#BBBBBB" : "#EEEEEE"
        }
        onExited: {
            parent.color = cur ? "#CCCCCC" : "#FFFFFF"
        }
        onClicked: { singleClick(); }
        onDoubleClicked: { doubleClick(); }
    }

}
