import QtQuick 2.0
import QtQuick.Controls 2.0

import "qrc:///utils/" as Utils

Rectangle {
    id: root

    property bool expanded: false

    height: stack_view_id.item.implicitHeight
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
            mouse.accepted = false
        }
    }

    Loader {
        id: stack_view_id
        anchors.fill: parent
        anchors.leftMargin: 10

        sourceComponent: expanded ? expand_view_id : collapse_view_id

        Component
        {
            id: expand_view_id

            Column {
                spacing: 5

                Utils.HorizontalRule {}

                Row {
                    id: expand_row_id
                    height: Math.max( expand_cover_id.height, expand_infos_id.height )
                    spacing: 5

                    Image {
                        id: expand_cover_id
                        width: 80
                        height: 80
                        source: model.album_cover || "qrc:///noart.png"
                    }

                    Column {
                        id: expand_infos_id
                        width: stack_view_id.width - expand_cover_id.width - expand_row_id.spacing
                        spacing: 5

                        Text {
                            text: "<b>"+(model.album_title || "Unknown title")+"</b>"
                        }

                        Utils.TracksDisplay {
                            x: 30
                            height: album_nb_tracks * (2 + 12)
                            width: expand_infos_id.width - x

                            tracks: album_tracks
                        }


                    }
                }

                Utils.HorizontalRule {}

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
                    source: model.album_cover || "qrc:///noart.png"
                }

                Column {
                    id: collapse_column_id
                    width: root.width - collapse_cover_id.width - collapse_row_id.spacing
                    height: collapse_cover_id.height
                    spacing : 5
                    Text {
                        id: collapse_title_id
                        text : "<b>"+(model.album_title || "Unknown title")+"</b> ["+model.album_duration+"]"
                        width: Math.min(parent.width, implicitWidth)
                        height: implicitHeight
                        elide: Text.ElideRight
                    }

                    Text {
                        id: collapse_infos_id
                        text: model.album_main_artist
                        width: Math.min(parent.width, implicitWidth)
                        height: implicitHeight
                        elide: Text.ElideRight
                        font.pixelSize: 8
                    }
                }
            }
        }
    }
}


