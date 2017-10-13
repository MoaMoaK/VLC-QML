#include "plitem.hpp"

#include "vlc_input_item.h"

PLItem::PLItem(playlist_item_t *_pl_item , int _pl_id) :
    pl_item( _pl_item ),
    pl_id( _pl_id )
{

}

QString PLItem::getTitle()
{
    char* title = input_item_GetTitle( pl_item->p_input );
    return QString( title );
}

QString PLItem::getName()
{
    char* uri = input_item_GetName( pl_item->p_input );
    return QString( uri );
}

QString PLItem::getDuration()
{
    mtime_t duration = input_item_GetDuration( pl_item->p_input );
    int secs = duration / 1000000;
    char psz_secs[MSTRTIME_MAX_SIZE];
    secstotimestr( psz_secs, secs);
    return QString( psz_secs );
}

void PLItem::activate( playlist_t *pl )
{
    playlist_item_t *p_parent = getItem();

    while( p_parent )
    {
        if( p_parent->i_id == pl->root.i_id ) break;
        p_parent = p_parent->p_parent;
    }
    if( p_parent )
        playlist_ViewPlay( pl, p_parent, getItem() );
}
