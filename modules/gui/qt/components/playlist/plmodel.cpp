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
        if ( ! item->getTitle().isEmpty() )
            return QVariant( item->getTitle() );
        else
            return QVariant( item->getName() );
    }
    case ALBUM_TITLE_ROLE :
    {
        PLItem *item = getItem(index);

        if (!item) return QVariant();
        return QVariant( item->getAlbumTitle() );
    }
    case DURATION_ROLE :
    {
        PLItem *item = getItem(index);

        if (!item) return QVariant();
        return QVariant( item->getDuration() );
    }
    case COVER_ROLE :
    {
        PLItem *item = getItem(index);

        if (!item) return QVariant();
        return QVariant( item->getCover() );
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
    roles[ALBUM_TITLE_ROLE] = "album_title";
    roles[DURATION_ROLE] = "duration";
    roles[COVER_ROLE] = "cover";
    roles[CURRENT_ROLE] = "current";
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

    // Need a full-model reset, else only the removed row will
    // be reloaded in views and if this items leaves a group with
    // only one element it can't be detected
    beginResetModel();
    {
        // Doc at /src/playlist/item.c L.336
        playlist_NodeDelete(
            THEPL,
            playlist_ItemGetByInput(
                THEPL,
                plitems.at(index)->getInputItem()
            )
        );

        plitems.removeAt(index);
    }
    endResetModel();
}

void PLModel::appendItem( PLItem* item, bool play )
{
    if( !item ) return;

    // Need a full-model reset, else only the added row will
    // be reloaded in views and if this items forms a new group,
    // it can't be detected
    beginResetModel();
    {
        plitems.append( item );

        // Doc at /src/playlist/item.c L.488
        playlist_AddInput(THEPL, item->getInputItem(), play, true);
    }
    endResetModel();
}

/* Retrieve the item at the given index */
PLItem* PLModel::getItem( const QModelIndex & index ) const
{
    int r = index.row();
    if (index.isValid() && r >= 0 && r < rowCount())
        return plitems.at(r);
    else
        return NULL;
}

/**** Invokable functions ****/

/* Convenient function that create an object that can be passed to QML
 * and acts like a standard model item */
QVariantMap PLModel::get(int row) {
    QHash<int,QByteArray> names = roleNames();
    QHashIterator<int, QByteArray> i(names);
    QVariantMap res;
    while (i.hasNext()) {
        i.next();
        QModelIndex idx = index(row, 0);
        QVariant data = idx.data(i.key());
        res[i.value()] = data;
    }
    return res;
}

/* Play the item at index given */
void PLModel::play_item(int index)
{
    if (index < 0 || index >= rowCount()) return;
    plitems.at(index)->activate( THEPL );
}

/* Remove the item at index given from the playlist */
void PLModel::remove_item(int index)
{
    removeItem( index );
}



