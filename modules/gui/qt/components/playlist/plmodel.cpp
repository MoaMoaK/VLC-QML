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
        playlist_item_t *plitem = getItem(index);
        if (!plitem) return false;
        playlist_item_t *p_parent = plitem;
        while( p_parent )
        {
            if( p_parent->i_id == THEPL->root.i_id ) break;
            p_parent = p_parent->p_parent;
        }
        if( p_parent )
            playlist_ViewPlay( THEPL, p_parent, plitem );

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
        playlist_item_t *plitem = getItem(index);

        if (!plitem) return QVariant();
        return QVariant( QString( plitem->p_input->psz_name ) );
    }
    case DURATION_ROLE :
    {
        playlist_item_t *plitem = getItem(index);

        if (!plitem) return QVariant();

        mtime_t duration = plitem->p_input->i_duration;
        int secs = duration / 1000000;
        char psz_secs[MSTRTIME_MAX_SIZE];
        secstotimestr( psz_secs, secs);
        return QVariant( QString( psz_secs ) );
    }
    case CURRENT_ROLE :
        return QVariant( THEPL->i_current_index == index.row() );
    default:
        return QVariant(QString("Ceci est un item"));
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
    return roles;
}

Qt::ItemFlags PLModel::flags(const QModelIndex &index) const
{
    if (!index.isValid()) return Qt::NoItemFlags;
    return Qt::ItemIsEditable | Qt::ItemIsDropEnabled | Qt::ItemIsDragEnabled;
}

/**** Events processing ****/

void PLModel::processInputItemUpdate( )
{
    beginResetModel();
    emit dataChanged(index(0, 0), index(rowCount(), 10));
    endResetModel();
}

void PLModel::processItemRemoval( int i_pl_itemid )
{
    if( i_pl_itemid <= 0 ) return;
    beginRemoveRows(QModelIndex(), i_pl_itemid-2, i_pl_itemid-2);
    endRemoveRows();
}

void PLModel::processItemAppend( int i_pl_itemid, int i_pl_itemidparent )
{
    beginInsertRows(QModelIndex(), i_pl_itemid-2, i_pl_itemid-2);
    endInsertRows();
}

playlist_item_t* PLModel::getItem( const QModelIndex & index ) const
{
    if (index.isValid() && index.row() >= 0 && index.row() < rowCount())
        return THEPL->items.p_elems[index.row()];
    else
        return NULL;

}
