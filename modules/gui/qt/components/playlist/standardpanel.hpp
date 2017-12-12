/*****************************************************************************
 * standardpanel.hpp : Panels for the playlist
 ****************************************************************************
 * Copyright (C) 2000-2005 the VideoLAN team
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

#ifndef VLC_QT_STANDARDPANEL_HPP_
#define VLC_QT_STANDARDPANEL_HPP_

#ifdef HAVE_CONFIG_H
# include "config.h"
#endif

#include "qt.hpp"
#include "components/playlist/playlist.hpp"
#include "components/playlist/vlc_model.hpp"
#include "components/video_overlay.hpp"
#include "components/interface_widgets.hpp"
#include "components/mediacenter/vlcstyle.hpp"

#include <qt5/QtWidgets/QWidget>
#include <qt5/QtWidgets/QFrame>
#include <qt5/QtWidgets/QHBoxLayout>
#include <qt5/QtQml/QQmlPropertyMap>
#include <QModelIndexList>
#include <QQmlContext>
#include <QtQuickWidgets/QQuickWidget>


#include <vlc_playlist.h> /* playlist_item_t */

#include <typeinfo>

class QSignalMapper;
class QWheelEvent;
class QStackedLayout;
class QModelIndex;


class QAbstractItemView;
class QTreeView;
class PlIconView;
class PlListView;
class PicFlowView;

class PLSelector;
class PlaylistWidget;
class PixmapAnimator;

class StandardPLPanel: public QWidget
{
    Q_OBJECT

public:
    StandardPLPanel( PlaylistWidget *, intf_thread_t *,
                     playlist_item_t *, PLSelector *, VLCModel * );
    virtual ~StandardPLPanel();

//    enum { ICON_VIEW = 0,
//           TREE_VIEW ,
//           LIST_VIEW,
//           PICTUREFLOW_VIEW,
//           VIEW_COUNT };

//    int currentViewIndex() const;

//    static QMenu *viewSelectionMenu(StandardPLPanel *obj);

    VideoOverlay* getVideoOverlay() { return videoOverlay; }

protected:
    VLCModel *model;
    void wheelEvent( QWheelEvent *e ) Q_DECL_OVERRIDE;
//    bool popup( const QPoint &point );

private:
    intf_thread_t *p_intf;

    PLSelector  *p_selector;

//    QQuickWidget  *treeView;
    QQuickWidget  *mainView;
//    QQuickWidget  *listView;
//    QQuickWidget  *picFlowView;

//    QWidget  *currentView;

    QHBoxLayout    *mainLayout;
    VideoOverlay      *videoOverlay;

    QSignalMapper *selectColumnsSigMapper;

    int lastActivatedPLItemId;
    int currentRootIndexPLId;

//    void createTreeView();
    void createMainView();
//    void createListView();
//    void createCoverView();
    void updateZoom( int i_zoom );
    virtual bool eventFilter ( QObject * watched, QEvent * event ) Q_DECL_OVERRIDE;

    /* Wait spinner */
    PixmapAnimator *spinnerAnimation;

public slots:
    void setRootItem( playlist_item_t *, bool );
    void browseInto( const QModelIndex& );
    void showMainView();
//    void setWaiting( bool ); /* spinner */

private slots:
//    void deleteSelection();
    void handleExpansion( const QModelIndex& );
//    void activate( const QModelIndex & );

    void browseInto();
    void browseInto( int );

//    void gotoPlayingItem();

//    void search( const QString& searchText );
    void searchDelayed( const QString& searchText );

//    void popupPlView( const QPoint & );
//    void popupSelectColumn( QPoint );
//    void popupAction( QAction * );
    void increaseZoom() { updateZoom( 1 ); };
    void decreaseZoom() { updateZoom( -1 ); };
//    void toggleColumnShown( int );

//    void cycleViews();
//    void updateViewport(); /* spinner */

signals:
    void viewChanged( const QModelIndex& );
};


//static const QString viewNames[ StandardPLPanel::VIEW_COUNT ]
//                                = { qtr( "Icons" ),
//                                    qtr( "Detailed List" ),
//                                    qtr( "List" ),
//                                    qtr( "PictureFlow") };

#endif
