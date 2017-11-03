import QtQuick 2.0

Rectangle {
    property var obj: undefined

    Text {
        text: obj.getPresName()
    }

    Component.onCompleted: { console.log(obj.getTitle()); console.log( obj ) }
}
