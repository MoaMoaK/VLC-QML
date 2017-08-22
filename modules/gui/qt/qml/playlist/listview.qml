import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
//    StackView {
//        id: stack
//        initialItem: mainView
//        anchors.fill: parent

//    }
//    Item {
//        stack.onRemoved: destroy() // Will be destroyed sometime after this call.
//    }

//    Component {

//        id: mainView


//        Row {
//            spacing: 10

//            Button {
//                text: "Push"
//                onClicked: {
//                    console.profile()
//                    console.trace()
//                    stack.push(mainView)
//                    console.profileEnd()
//                }
//            }
//            Button {
//                text: "Pop"
//                enabled: stack.depth > 1
//                onClicked: {console.profile() ; console.trace() ; stack.pop() ; console.profileEnd()}
//            }
//            Text {
//              text: stack.depth
//            }
//        }
//    }


//    StackView {
//        anchors.fill: parent
//        id: stack
//        initialItem: list
//    }

    Item {
        id: list

        ListView {
            id: listView
            model: m
            delegate: Column {
                id: column

                Rectangle {
                    id: rectMinInfo
                    width: parent.width
                    height: 32
                    color: "#ffffff"

    //                MouseArea {
    //                    onClicked: stack.push(detail)
    //                    anchors.fill: parent
    //                }

                    Row {
                        id: row
                        anchors.fill: parent

                        Image {
                            id: image
                            width: 32
                            height: 32
                            source: model.cover
                        }

                        Text {
                            text: model.title
                        }
                    }
                }
            }
        }
    }

//    Component {
//        id: detail

//        Button {
//            text: "Pop"
//            x: 150
//            width: 100
//            height: 30
//            onClicked: {console.log("pop"); stack.pop() }
//        }
//    }


//        Column {
//            id: column

//            Button {
//                text: "Pop"
//                onClicked: {console.log("pop"); stack.pop() }
//            }

//            Rectangle {
//                id: rectangle
//                height: 32
//                color: "#e9e9e9"
//                anchors.left: parent.left
//                anchors.leftMargin: 0
//                anchors.right: parent.right
//                anchors.rightMargin: 0

//                Row {
//                    id: row1
//                    anchors.fill: parent

//                    Rectangle {
//                        anchors.top: parent.top
//                        anchors.topMargin: 0
//                        anchors.bottom: parent.bottom
//                        anchors.bottomMargin: 0
//                        height: 32
//                        width: 32
//                        color: "#ff00ff"
//                        MouseArea {
//                            anchors.fill: parent
//                            onClicked: {console.log("clicked")}
//                        }


//                    }

//                        Image {
//                            id: image
//                            anchors.top: parent.top
//                            anchors.topMargin: 0
//                            anchors.bottom: parent.bottom
//                            anchors.bottomMargin: 0
//                            source: "qrc:///menu/previous"
//                            MouseArea {
//                                propagateComposedEvents: true
//                                Rectangle {
//                                    anchors.fill: parent
//                                    color: "#ff00ff"
//                                }

//                                anchors.fill: image
//                                onClicked: {console.log("clicked")}
//                            }

//                        }


//                    Text {
//                        id: text1
//                        text: qsTr("<b>Title</b>")
//                        verticalAlignment: Text.AlignVCenter
//                        anchors.top: parent.top
//                        anchors.topMargin: 0
//                        anchors.bottom: parent.bottom
//                        anchors.bottomMargin: 0
//                        font.pixelSize: 12
//                    }
//                }
//            }

//            Rectangle {
//                id: rectangle1
//                height: 1000-32
//                color: "#ffffff"
//                anchors.left: parent.left
//                anchors.leftMargin: 0
//                anchors.right: parent.right
//                anchors.rightMargin: 0

//                Row {
//                    id: row
//                    spacing: 10
//                    anchors.fill: parent

//                    Image {
//                        id: image1
//                        x: 10
//                        anchors.top: parent.top
//                        anchors.topMargin: 100
//                        anchors.bottom: parent.bottom
//                        anchors.bottomMargin: 400
//                        source: "../../../../../../Téléchargements/chatons.jpg"
//                    }

//                    Text {
//                        id: text2
//                        width: 600
//                        text: qsTr("Titre et tout le blabla (descriptions bien joil mais qui sert surtout a remplir la page auNklfdnslngsfdlnlfdk kbvd knfjkdlsnvk ndkls,kjjjjjjjjjjksjdqbgvkbsdk vhsflkds,fdlsg Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non risus euismod ex fermentum mollis. Integer ornare mauris justo, sed iaculis neque porta in. Aliquam eu dapibus urna. Nam sagittis ultrices blandit. Nulla pretium sem in nulla convallis condimentum. Aenean viverra, ipsum non tempus pulvinar, nulla velit auctor leo, eu fermentum enim enim id ex. Nulla quis justo eget sem dictum suscipit et vitae nunc. Maecenas fringilla justo quis ullamcorper cursus. Nulla quis sapien et quam pellentesque laoreet. Suspendisse bibendum lobortis diam ut dapibus. Duis eget nisi non justo vulputate rutrum. Mauris arcu odio, dapibus a lorem ut, malesuada consequat. ")
//                        //text: qsTr("Titre")
//                        anchors.top: parent.top
//                        anchors.topMargin: 200
//                        anchors.bottom: parent.bottom
//                        anchors.bottomMargin: 0
//                        wrapMode: Text.WordWrap
//                        font.pixelSize: 12
//                    }
//                }
//            }


//        }



}
