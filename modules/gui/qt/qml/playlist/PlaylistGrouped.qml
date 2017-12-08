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
        if (i<0 || i> get_nb() )
            return undefined;
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
        sourceComponent: commonGrouped
        property int currentIndex: indexFirst
        property var model: get_item( indexFirst )
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
