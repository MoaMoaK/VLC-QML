import QtQuick 2.0
import QtQuick.Controls 2.0

import "qrc:///qml/"
//import "../utils"

Rectangle {
    id: root

    property bool expanded: false

    height: stack_view_id.currentItem.implicitHeight + stack_view_id.anchors.topMargin + stack_view_id.anchors.bottomMargin
    width: parent.width

    Behavior on height {
        PropertyAnimation { duration: 200; easing.type: Easing.InOutBounce; }
    }

    MouseArea {
        id: mouseArea_root_id
        anchors.fill: root

        hoverEnabled: true
        propagateComposedEvents: true
        onEntered: { root.color = expanded ? "#ffffff" : "#f0f0f0" }
        onExited: { root.color = "#ffffff" }
        onClicked: {
            expanded = !expanded
            root.color = expanded ? "#ffffff" : "#f0f0f0"
            stack_view_id.replace(expanded ? expand_view_id : collapse_view_id)
            mouse.accepted = false
        }
    }

    StackView {
        id: stack_view_id
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.topMargin: 5
        anchors.bottomMargin: 5

        initialItem: expanded ? expand_view_id : collapse_view_id

        replaceEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
            }
        }
        replaceExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
            }
        }

        Component
        {
            id: expand_view_id

            Column {
                spacing: 5

                HorizontalRule {}

                Row {
                    id: expand_row_id
                    height: Math.max( expand_cover_id.height, expand_infos_id.height )
                    spacing: 5

                    Image {
                        id: expand_cover_id
                        width: 80
                        height: 80
                        source: model.cover || "qrc:///noart.png"
                    }

                    Column {
                        id: expand_infos_id
                        width: stack_view_id.width - expand_cover_id.width - expand_row_id.spacing
                        spacing: 5

                        Text {
                            text: "<b>"+(model.title || "Unknown title")+"</b>"
                        }

                        ListView {
                            id: expand_track_id
                            x: 30
                            height: tracks.length * (spacing + 2 + 12)
                            width: expand_infos_id.width - x
                            interactive: false
                            model: tracks

                            delegate: Rectangle {
                                height: expand_track_name_id.font.pixelSize + 2
                                width: expand_track_id.width

                                Text {
                                    id: expand_track_name_id
                                    text: "["+tracks[index].getTrackNumber()+"] "+tracks[index].getTitle()+" - "+tracks[index].getDuration()
                                }

                                MouseArea {
                                    anchors.fill: parent

                                    hoverEnabled: true

                                    onEntered: { parent.color = "#f0f0f0" }
                                    onExited: { parent.color = "#ffffff" }
                                    onClicked: { console.log( "clicked : "+tracks[index].getTitle() ) }
                                }
                            }
                        }
                    }
                }

                HorizontalRule {}

            }



        }

        Component
        {
            id: collapse_view_id
            Row {
                id: collapse_row_id
                height: collapse_cover_id.height
                spacing: 5

                Image {
                    id: collapse_cover_id
                    width: 32
                    height: 32
                    source: model.cover || "qrc:///noart.png"
                }

                Text {
                    id: collapse_title_id
                    text : "<b>"+(model.title || "Unknown title")+"</b> ["+model.duration+"]"
                    anchors.verticalCenter: parent.verticalCenter
                    width: Math.min( ( parent.width-collapse_cover_id.width-parent.spacing )*2/3 , implicitWidth )
                    elide: Text.ElideRight
                }

                Text {
                    id: collapse_infos_id
                    text: model.artist
                    anchors.verticalCenter: parent.verticalCenter
                    width: Math.min( parent.width-parent.spacing-collapse_cover_id.width-parent.spacing-collapse_title_id.width , implicitWidth )
                    elide: Text.ElideRight
                    font.pixelSize: 8
                }
            }
        }
    }
}


