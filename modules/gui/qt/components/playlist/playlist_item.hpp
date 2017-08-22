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

class AbstractPLItem
{
    friend class PLItem; /* super ugly glue stuff */
    friend class MLItem;
    friend class VLCModel;
    friend class PLModel;
    friend class MLModel;

public:
    virtual ~AbstractPLItem() {}

protected:
    virtual int id( ) const = 0;
    int childCount() const { return children.count(); }
    int indexOf( AbstractPLItem *item ) const { return children.indexOf( item ); };
    int lastIndexOf( AbstractPLItem *item ) const { return children.lastIndexOf( item ); };
    AbstractPLItem *parent() { return parentItem; }
    virtual input_item_t *inputItem() = 0;
    void insertChild( AbstractPLItem *item, int pos = -1 ) { children.insert( pos, item ); }
    void appendChild( AbstractPLItem *item ) { insertChild( item, children.count() ); } ;
    virtual AbstractPLItem *child( int id ) const = 0;
    void removeChild( AbstractPLItem *item );
    void clearChildren();
    virtual QString getURI() const = 0;
    virtual QString getTitle() const = 0;
    virtual bool readOnly() const = 0;

    QList<AbstractPLItem *> children;
    AbstractPLItem *parentItem;
};

class PLItem : public AbstractPLItem
{
    friend class PLModel;

public:
    virtual ~PLItem();
    bool hasSameParent( PLItem *other ) { return parent() == other->parent(); }
    bool operator< ( AbstractPLItem& );

    PLItem(intf_thread_t *_p_intf, playlist_item_t *, PLItem *parent );

protected:
    input_item_t *inputItem() Q_DECL_OVERRIDE { return p_input; }

    virtual void displayInfo()=0;
    Q_INVOKABLE virtual QString getTitle() const Q_DECL_OVERRIDE;


    intf_thread_t *p_intf;
    int i_playlist_id;

private:
    /* AbstractPLItem */
    int id() const Q_DECL_OVERRIDE;
    AbstractPLItem *child( int id ) const Q_DECL_OVERRIDE { return children.value( id ); };
    virtual QString getURI() const Q_DECL_OVERRIDE;
    virtual bool readOnly() const Q_DECL_OVERRIDE;


    /* Local */

    int row();
    void takeChildAt( int );

    PLItem( intf_thread_t *intf, playlist_item_t * );
    void init( intf_thread_t *intf, playlist_item_t *, PLItem * );
    int i_flags;
    input_item_t *p_input;
};

#endif

