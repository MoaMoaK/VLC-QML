#include "plitem.hpp"

#include "vlc_input_item.h"

PLItem::PLItem(MLAlbumTrack *_item ) :
    pl_item( _item )
{
    inputItem = input_item_New(
        pl_item->getMRL().toLatin1().data(),
        pl_item->getTitle().toLatin1().data()
    );
}

QString PLItem::getTitle()
{
    return pl_item->getTitle();
}

QString PLItem::getName()
{
    return QString( "plop" );
}

QString PLItem::getDuration()
{
    return pl_item->getDuration();
}

void PLItem::activate( playlist_t *pl )
{

    playlist_item_t* playlist_item = playlist_ItemGetByInput(pl, inputItem);

    if( playlist_item )
        playlist_ViewPlay( pl, NULL, playlist_item );
}
