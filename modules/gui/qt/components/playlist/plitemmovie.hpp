#ifndef PLITEMMOVIE_HPP
#define PLITEMMOVIE_HPP

#include <qt5/QtCore/QObject>
#include <qt5/QtGui/QImage>
#include "playlist_item.hpp"
#include "vlc_playlist.h"
#include "vlc_input_item.h"
#include "dialogs/playlist.hpp"


class PLItemMovie : public QObject, public PLItem
{
    Q_OBJECT

public:
    PLItemMovie( intf_thread_t *_p_intf, playlist_item_t *, PLItem *parent );
    Q_INVOKABLE void displayInfo();
    Q_INVOKABLE void back();
    Q_INVOKABLE QString getTitle();
    Q_INVOKABLE QString getArtworkURL();

};

#endif // PLITEMMOVIE_HPP
