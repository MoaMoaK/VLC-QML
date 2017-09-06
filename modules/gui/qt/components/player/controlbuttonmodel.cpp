#include "controlbuttonmodel.hpp"

ControlButtonModel::ControlButtonModel(intf_thread_t *_p_intf, QObject *parent) :
    QAbstractListModel(parent),
    p_intf(_p_intf)
{
    buttonList = QList<ControlButtonItem*>();
    buttonList.append( new ControlButtonItem(p_intf, PLAY_BUTTON, WIDGET_NORMAL) );
    buttonList.append( new ControlButtonItem(p_intf, PREVIOUS_BUTTON, WIDGET_NORMAL) );
    buttonList.append( new ControlButtonItem(p_intf, NEXT_BUTTON, WIDGET_NORMAL) );
}

QVariant ControlButtonModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    return QVariant (QString("This is a header"));
}

int ControlButtonModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return buttonList.count();
}

bool ControlButtonModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid())
        return false;

    switch (role) {
    case SINGLE_CLICK_ROLE:
    {
        ControlButtonItem *item = getItem(index);
        if (!item) return false;

        item->singleClick();
        emit dataChanged(index, index);
        return true;
    }
    case DOUBLE_CLICK_ROLE:
    {
        ControlButtonItem *item = getItem(index);
        if (!item) return false;

        item->doubleClick();
        emit dataChanged(index, index);
        return true;
    }
    default:
        return false;
    }

}

QVariant ControlButtonModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    switch (role)
    {
    case TEXT_ROLE :
    {
        ControlButtonItem *item = getItem(index);

        if (!item) return QVariant();
        return QVariant( item->getText() );
    }
    case ICON_ROLE :
    {
        ControlButtonItem *item = getItem(index);

        if (!item) return QVariant();
        return QVariant( item->getIcon() );
    }
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> ControlButtonModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::FontRole] = "font";
    roles[Qt::DisplayRole] = "display";
    roles[Qt::DecorationRole] = "decoration";
    roles[Qt::BackgroundRole] = "background";
    roles[TEXT_ROLE] = "text";
    roles[ICON_ROLE] = "icon";
    roles[SINGLE_CLICK_ROLE] = "single_click";
    roles[DOUBLE_CLICK_ROLE] = "double_click";
    return roles;
}

Qt::ItemFlags ControlButtonModel::flags(const QModelIndex &index) const
{
    if (!index.isValid()) return Qt::NoItemFlags;
    return Qt::ItemIsEditable | Qt::ItemIsDropEnabled | Qt::ItemIsDragEnabled;
}

ControlButtonItem* ControlButtonModel::getItem( const QModelIndex & index ) const
{
    int r = index.row();
    if (index.isValid() && r >= 0 && r < rowCount())
        return buttonList.at(r);
    else
        return NULL;
}
