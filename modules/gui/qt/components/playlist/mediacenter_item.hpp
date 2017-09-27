/*****************************************************************************
 * playlist_item.hpp : Item for a playlist tree
 ****************************************************************************
 * Copyright (C) 2006-2011 the VideoLAN team
 * $Id$
 *
 * Authors: Clément Stenac <zorglub@videolan.org>
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

#ifndef VLC_QT_PLAYLIST_ITEM_HPP_
#define VLC_QT_PLAYLIST_ITEM_HPP_

#ifdef HAVE_CONFIG_H
# include "config.h"
#endif

#include "qt.hpp"

#include <qt5/QtCore/QList>
#include <qt5/QtCore/QString>
#include <qt5/QtCore/QObject>

enum playlist_item_type {
    MOVIE,
    MUSIC,
    OTHER
};

class MCItem : public QObject
{
    Q_OBJECT

    friend class MLItem; /* super ugly glue stuff */
    friend class VLCModel;
    friend class MCModel;
    friend class MLModel;

public:
    virtual ~MCItem();
    bool hasSameParent( MCItem *other ) { return plitem_parent() == other->plitem_parent(); }
    bool operator< ( MCItem& );

    MCItem(intf_thread_t *_p_intf, playlist_item_t *, MCItem *p_parent );

    void displayInfo();

    Q_INVOKABLE QString getTitle() const;
    Q_INVOKABLE QString getArtworkURL();
    Q_INVOKABLE void back();

    static void staticUpdateType(vlc_event_t const *p_event, void *user_data);
    void updateType();


protected:
    int id() const;
    int childCount() const { return plitem_children.count(); }
    int indexOf( MCItem *item ) const { return plitem_children.indexOf( item ); }
    int lastIndexOf( MCItem *item ) const { return plitem_children.lastIndexOf( item ); }
    input_item_t *inputItem() { return p_input; }
    MCItem *plitem_parent() { return parentItem; }
    void insertChild( MCItem *item, int pos = -1 ) { plitem_children.insert( pos, item ); }
    void appendChild( MCItem *item ) { insertChild( item, plitem_children.count() ); }
    void removeChild( MCItem *item );
    MCItem *child( int id ) const { return plitem_children.value( id ); }
    void clearChildren();
    QString getURI() const;
    bool readOnly() const;

    QList<MCItem *> plitem_children;
    MCItem *parentItem;

    playlist_item_type itemType;

    intf_thread_t *p_intf;
    int i_playlist_id;

private:
    int row();
    void takeChildAt( int );

    MCItem( intf_thread_t *intf, playlist_item_t * );
    void init( intf_thread_t *intf, playlist_item_t *, MCItem * );
    playlist_item_type guessItemType();
    int i_flags;
    input_item_t *p_input;
};

#endif

