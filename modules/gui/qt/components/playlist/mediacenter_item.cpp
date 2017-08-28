/*****************************************************************************
 * playlist_item.cpp : Manage playlist item
 ****************************************************************************
 * Copyright © 2006-2011 the VideoLAN team
 * $Id$
 *
 * Authors: Clément Stenac <zorglub@videolan.org>
 *          Jean-Baptiste Kempf <jb@videolan.org>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston MA 02110-1301, USA.
 *****************************************************************************/

#ifdef HAVE_CONFIG_H
# include "config.h"
#endif

#include <assert.h>

#include "qt.hpp"
#include "vlc_es.h"
#include "mediacenter_item.hpp"
#include "standardpanel.hpp"
#include "dialogs/playlist.hpp"
#include <vlc_input_item.h>

/*************************************************************************
 * Playlist item implementation
 *************************************************************************/

void MCItem::clearChildren()
{
    qDeleteAll( plitem_children );
    plitem_children.clear();
}

void MCItem::removeChild( MCItem *item )
{
    plitem_children.removeOne( item );
    delete item;
}

void MCItem::updateType()
{
    itemType = guessItemType();
}

void MCItem::staticUpdateType(const vlc_event_t *p_event,
                              void *user_data)
{
    MCItem * item = reinterpret_cast<MCItem*> (user_data) ;
    if (item)
        item->updateType();
}

playlist_item_type MCItem::guessItemType()
{
    input_item_t *input = inputItem();
    playlist_item_type res = OTHER;
    if (input)
    {
        es_format_t **es = input->es;
        int nb_es = input->i_es;
        if (es)
        {
            for (int i=0 ; i<nb_es ; i++)
            {
                es_format_category_e cat = es[i]->i_cat;
                if (cat == VIDEO_ES)
                    res = MOVIE;
                else if (cat == AUDIO_ES && res != MOVIE)
                    res = MUSIC;
            }
        }
    }

    return res;
}

/*
   Playlist item is just a wrapper, an abstraction of the playlist_item
   in order to be managed by PLModel

   PLItem have a parent, and id and a input Id
*/

void MCItem::init( intf_thread_t *_p_intf, playlist_item_t *_playlist_item, MCItem *p_parent )
{
    parentItem = p_parent;          /* Can be NULL, but only for the rootItem */
    i_playlist_id = _playlist_item->i_id;           /* Playlist item specific id */
    p_input = _playlist_item->p_input;
    i_flags = _playlist_item->i_flags;
    input_item_Hold( p_input );
    p_intf = _p_intf;
    updateType();
    vlc_event_attach(&(inputItem()->event_manager),
                     vlc_InputItemPreparseEnded,
                     staticUpdateType, this);
}

/*
   Constructors
   Call the above function init
   */
MCItem::MCItem( intf_thread_t *_p_intf, playlist_item_t *p_item, MCItem *p_parent )
{
    init(_p_intf, p_item, p_parent );
}

MCItem::MCItem( intf_thread_t *_p_intf, playlist_item_t * p_item )
{
    init( _p_intf, p_item, NULL );
}

MCItem::~MCItem()
{
    input_item_Release( p_input );
    qDeleteAll( plitem_children );
    plitem_children.clear();

    vlc_event_detach(&(inputItem()->event_manager),
                     vlc_InputItemPreparseEnded,
                     staticUpdateType, this);
}

int MCItem::id() const
{
    return i_playlist_id;
}

void MCItem::takeChildAt( int index )
{
    MCItem *child = plitem_children[index];
    child->parentItem = NULL;
    plitem_children.removeAt( index );
}

/* This function is used to get one's parent's row number in the model */
int MCItem::row()
{
    if( parentItem )
        return parentItem->indexOf( this );
    return 0;
}

bool MCItem::operator< ( MCItem& other )
{
    MCItem *item1 = this;
    while( item1->parentItem )
    {
        MCItem *item2 = &other;
        while( item2->parentItem )
        {
            if( item1 == item2->parentItem ) return true;
            if( item2 == item1->parentItem ) return false;
            if( item1->parentItem == item2->parentItem )
                return item1->parentItem->indexOf( item1 ) <
                       item1->parentItem->indexOf( item2 );
            item2 = item2->parentItem;
        }
        item1 = item1->parentItem;
    }
    return false;
}

QString MCItem::getURI() const
{
    QString uri;
    vlc_mutex_lock( &p_input->lock );
    uri = QString( p_input->psz_uri );
    vlc_mutex_unlock( &p_input->lock );
    return uri;
}

QString MCItem::getTitle() const
{
    QString title;
    char *fb_name = input_item_GetTitle( p_input );
    if( EMPTY_STR( fb_name ) )
    {
        free( fb_name );
        fb_name = input_item_GetName( p_input );
    }
    title = qfu(fb_name);
    free(fb_name);
    return title;
}

bool MCItem::readOnly() const
{
    return i_flags & PLAYLIST_RO_FLAG;
}

void MCItem::displayInfo()
{
    switch (itemType)
    {
    case (MOVIE):
    {
        StandardPLPanel *mv = PlaylistDialog::getInstance(p_intf)->exportPlaylistWidget()->mainView;
        mv->showInfoMovie(this);
        break;
    }
    case (MUSIC):
    {
        msg_Info(p_intf, "Ceci est un MUSIC");
        break;
    }
    default:
    {
        msg_Info(p_intf, "Ceci est un OTHER");
        break;
    }
    }

    if (itemType == MOVIE)
    {

    }
}

QString MCItem::getArtworkURL()
{
    return input_item_GetArtworkURL(inputItem());
}

void MCItem::back()
{
   StandardPLPanel *mv = PlaylistDialog::getInstance(p_intf)->exportPlaylistWidget()->mainView;
   mv->hideInfoMovie();
}
