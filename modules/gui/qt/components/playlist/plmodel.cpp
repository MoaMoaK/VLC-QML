#include "plmodel.hpp"


#include <qt5/QtCore/QString>

#include <vlc_playlist.h>
#include <vlc_input_item.h>

PLModel::PLModel(intf_thread_t *_p_intf, QObject *parent)
    : QAbstractListModel(parent)
{
    p_intf = _p_intf;

    DCONNECT( THEMIM->getIM(), metaChanged( input_item_t *),
              this, processInputItemUpdate( ) );
    CONNECT( THEMIM, playlistItemAppended( int, int ),
             this, processItemAppend( int, int) );
    CONNECT( THEMIM, playlistItemRemoved( int ),
             this, processItemRemoval( ) );
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

    return THEPL->items.i_size;
}

QVariant PLModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    switch (role)
    {
    case TITLE_ROLE :
        return QVariant( QString( THEPL->items.p_elems[index.row()]->p_input->psz_name ) );
    case DURATION_ROLE :
    {
        mtime_t duration = THEPL->items.p_elems[index.row()]->p_input->i_duration;
        int secs = duration / 1000000;
        char psz_secs[MSTRTIME_MAX_SIZE];
        secstotimestr( psz_secs, secs);
        return QVariant( QString( psz_secs ) );
    }
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
    return roles;
}

/**** Events processing ****/

void PLModel::processInputItemUpdate( )
{
    emit dataChanged(index(0, 0), index(rowCount(), 10));
}

void PLModel::processItemRemoval( )
{
    emit dataChanged(index(0, 0), index(rowCount(), 10));
}

void PLModel::processItemAppend( int i_pl_itemid, int i_pl_itemidparent )
{
    beginInsertRows(QModelIndex(), i_pl_itemid-2, i_pl_itemid-2);
    endInsertRows();
}
