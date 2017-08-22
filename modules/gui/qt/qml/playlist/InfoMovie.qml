import QtQuick 2.0

Item {
    width: 1000
    height: 1000

    function decideCover (cover) {
        if (cover)
            return cover
        else
            return "qrc:///noart.png"
    }

    Column {
        id: column
        anchors.fill: parent

        PLBannerSources {
            id : sourcesBanner
        }

        Rectangle {
            id: navbar
            height: 32
            z : 2
            color: "#eeeeee"
            anchors.top: sourcesBanner.bottom
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0

            Row {
                anchors.fill: parent

                Image {
                    height: 32; width:32
                    fillMode: Image.PreserveAspectFit
                    source: "qrc:///toolbar/dvd_prev"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {pl_item.back();}
                    }
                }

                Text {
                    text: "<b>"+pl_item.getTitle()+"</b>"
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    font.pixelSize: 12
                }
            }
        }

        Rectangle {
            height: 1000-32
            color: "#ffffff"
            anchors.top: navbar.bottom
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0

            Row {
                spacing: 10
                anchors.fill: parent

                Image {
                    x: 10
                    anchors.top: parent.top
                    anchors.topMargin: 100
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 400
                    height: 350; width:200
                    fillMode: Image.PreserveAspectFit
                    source: decideCover(pl_item.getArtworkURL())
                }

                Text {
                    width: 600
                    text: qsTr("Titre et tout le blabla (descriptions bien joil mais qui sert surtout a remplir la page auNklfdnslngsfdlnlfdk kbvd knfjkdlsnvk ndkls,kjjjjjjjjjjksjdqbgvkbsdk vhsflkds,fdlsg Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non risus euismod ex fermentum mollis. Integer ornare mauris justo, sed iaculis neque porta in. Aliquam eu dapibus urna. Nam sagittis ultrices blandit. Nulla pretium sem in nulla convallis condimentum. Aenean viverra, ipsum non tempus pulvinar, nulla velit auctor leo, eu fermentum enim enim id ex. Nulla quis justo eget sem dictum suscipit et vitae nunc. Maecenas fringilla justo quis ullamcorper cursus. Nulla quis sapien et quam pellentesque laoreet. Suspendisse bibendum lobortis diam ut dapibus. Duis eget nisi non justo vulputate rutrum. Mauris arcu odio, dapibus a lorem ut, malesuada consequat. ")
                    anchors.top: parent.top
                    anchors.topMargin: 200
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    wrapMode: Text.WordWrap
                    font.pixelSize: 12
                }
            }
        }


    }

}
