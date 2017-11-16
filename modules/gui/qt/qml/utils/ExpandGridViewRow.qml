import QtQuick 2.0
import QtQuick.Controls 2.0

Column {
    id: root

    property int beginIndex: 0
    property int endIndex: 0
    property int expandItemIndex: -1
    
    property var model
    property Component delegate
    property Component expandDelegate

    property int colSpacing: 0
    property int rowSpacing: 0
    property int expandSpacing: 0
    property bool fillWidth: false
    property bool fillHeight: false
    property bool expandFillWidth: false
    property int rootMaxWidth: 0

    property int cellHeight: 0
    property int cellWidth: 0
    property int expandHeight: 0
    property bool expandCompact: false
    property bool expandAdaptHeight: false

    property int expandDelay: 0
    property int collapseDelay: 0
    property int expandDuration: 0
    property int collapseDuration: 0

    property int itemsPerRow: 0

    function validExpandItemIndex() {
        return expandItemIndex >= beginIndex && expandItemIndex <= endIndex;
    }

    function get_item(i) {
        if (model.get && model.get(i))
            return model.get(i);
        if (model.itemData)
            return model.itemData(i);
        if (model[i])
            return model[i];
        console.log('Impossible to get item data from '+model+' at index '+i);
        return undefined;
    }

    function calc_expandzone_height() {
        if (expandAdaptHeight)
            return expandPanel_loader_id.item.implicitHeight;
        else if (expandCompact)
            return Math.min( expandPanel_loader_id.item.implicitHeight, expandHeight );
        else
            return expandHeight;
    }

    spacing : expandSpacing
    
    Row {
        id: main_row
        spacing: fillWidth ? Math.floor( (rootMaxWidth-(itemsPerRow)*cellWidth) / (itemsPerRow-1) ) : colSpacing

        Repeater {
            model : endIndex - beginIndex + 1
            
            Item {
                height: cellHeight
                width: cellWidth
                
                Loader {
                    sourceComponent: root.delegate
                    property var model: get_item(beginIndex + index)
                    property int currentIndex: beginIndex + index
                }

                MouseArea {
                    anchors.fill: parent
                    propagateComposedEvents: true
                    onClicked: {
                        toggleExpand(beginIndex + index);
                        mouse.accepted = false;
                    }
                }
            }
        }
    }

    Item {
        id: expandPanel_container_id
        width: 0
        height: 0

        Loader {
            id: expandPanel_loader_id
            sourceComponent: collapseZone
            width: expandPanel_container_id.width
            height: expandPanel_container_id.height
        }

        states: State {
            name: "expanded"; when: validExpandItemIndex()
            PropertyChanges {
                target: expandPanel_loader_id;
                sourceComponent: expandZone
            }
            PropertyChanges {
                target: expandPanel_container_id;
                height: calc_expandzone_height()
            }
            PropertyChanges {
                target: expandPanel_container_id;
                width: expandFillWidth ? rootMaxWidth : itemsPerRow * (cellWidth+main_row.spacing) - main_row.spacing
            }
        }

        transitions: [
            Transition {
                from: ""; to: "expanded"
                SequentialAnimation {
                    PropertyAnimation { properties: "width"; duration: expandDelay }
                    PropertyAnimation { properties: "sourceComponent"; duration: 0 }
                    PropertyAnimation { properties: "height"; duration: expandDuration }
                }
            },
            Transition {
                from: "expanded"; to: ""
                SequentialAnimation {
                    PropertyAnimation { duration: collapseDelay }
                    PropertyAnimation { properties: "height"; duration: collapseDuration }
                    PropertyAnimation { properties: "sourceComponent, width"; duration: 0 }
                }
            }
        ]
    }
    
    Component {
        id: expandZone
        Item {
            implicitHeight: expandDelegate_loader.item.implicitHeight
            Loader {
                id: expandDelegate_loader
                sourceComponent: root.expandDelegate
                property var model: get_item(expandItemIndex)
                property int currentIndex: expandItemIndex
            }
        }
    }

    Component {
        id: collapseZone
        Item {
            height: 0
            width: 0
        }
    }
}
