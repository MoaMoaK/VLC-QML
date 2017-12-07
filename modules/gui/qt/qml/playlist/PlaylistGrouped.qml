/**********************************************************
 * The component used to display a full group of item inside
 * the playlist's list view from indexFirst to indexLast
 **********************************************************/

import QtQuick 2.0

Row {
    id: root

    property var model
    property int indexFirst
    property int indexLast
    property Component delegateGrouped
    property Component commonGrouped
    property alias vertSpace: group_col.spacing
    property alias horiSpace: root.spacing

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

    Loader {
        property var model: get_item( indexFirst )
        property int currentIndex: indexFirst
        sourceComponent: commonGrouped
    }

    Column {
        id: group_col

        Repeater {
            model: indexLast - indexFirst + 1

            Loader {
                width: root.width
                property var model: get_item( indexFirst + index )
                property int currentIndex: indexFirst + index
                sourceComponent: delegateGrouped
            }
        }
    }
}
