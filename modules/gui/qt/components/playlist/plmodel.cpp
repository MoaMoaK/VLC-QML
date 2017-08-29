#include "plmodel.hpp"


#include <qt5/QtCore/QString>

#include <vlc_playlist.h>
#include <vlc_input_item.h>

PLModel::PLModel(intf_thread_t *_p_intf, QObject *parent)
    : QAbstractListModel(parent)
{
    p_intf = _p_intf;
    plitems = QList<PLItem*>();
}

QVariant PLModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    return QVariant (QString("This is a header"));
}

int PLModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return plitems.count();
}

bool PLModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid())
        return false;

    switch (role) {
    case ACTIVATE_ROLE:
    {
        PLItem *plitem = getItem(index);
        if (!plitem) return false;

        plitem->activate( THEPL );

        return true;
    }
    case REMOVE_ROLE:
    {
        if( !index.isValid() ) return false;
        removeItem( index.row() );
        return true;
    }
    default:
        return false;
    }

}


QVariant PLModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    switch (role)
    {
    case TITLE_ROLE :
    {
        PLItem *item = getItem(index);

        if (!item) return QVariant();
        return QVariant( item->getTitle() );
    }
    case DURATION_ROLE :
    {
        PLItem *item = getItem(index);

        if (!item) return QVariant();
        return QVariant( item->getDuration() );
    }
    case CURRENT_ROLE :
        return QVariant( false );
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> PLModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::FontRole] = "font";
    roles[Qt::DisplayRole] = "display";
    roles[Qt::DecorationRole] = "decoration";
    roles[Qt::BackgroundRole] = "background";
    roles[TITLE_ROLE] = "title";
    roles[DURATION_ROLE] = "duration";
    roles[CURRENT_ROLE] = "current";
    roles[ACTIVATE_ROLE] = "activate_item";
    roles[REMOVE_ROLE] = "remove_item";
    return roles;
}

Qt::ItemFlags PLModel::flags(const QModelIndex &index) const
{
    if (!index.isValid()) return Qt::NoItemFlags;
    return Qt::ItemIsEditable | Qt::ItemIsDropEnabled | Qt::ItemIsDragEnabled;
}

/**** Add and remove items to the playlist ****/

void PLModel::removeItem( int index )
{
    if( index < 0 || index > rowCount() ) return;

    beginRemoveRows(QModelIndex(), index, index);
    {
        plitems.removeAt(index);
    }
    endRemoveRows();
}

void PLModel::appendItem( playlist_item_t *item, int i_pl_itemid )
{
    if( !item ) return;

    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    {
        plitems.append( new PLItem(item, i_pl_itemid) );
    }
    endInsertRows();
}

PLItem* PLModel::getItem( const QModelIndex & index ) const
{
    int r = index.row();
    if (index.isValid() && r >= 0 && r < rowCount())
        return plitems.at(r);
    else
        return NULL;
}

int PLModel::getItemIndexFromPLId( int id )
{
    for (int i=0 ; i<plitems.size() ; i++)
    {
        if ( plitems.at(i)->getId() == id )
            return i;
    }
    return -1;
}


