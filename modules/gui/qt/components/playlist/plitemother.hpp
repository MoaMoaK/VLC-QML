#ifndef PLITEMOTHER_HPP
#define PLITEMOTHER_HPP


#include <qt5/QtCore/QObject>
#include <qt5/QtGui/QImage>
#include "playlist_item.hpp"
#include "vlc_playlist.h"
#include "vlc_input_item.h"


class PLItemOther : public PLItem
{
public:
    PLItemOther( intf_thread_t *_p_intf, playlist_item_t *, PLItem *parent);
    Q_INVOKABLE void displayInfo();

};


#endif // PLITEMOTHER_HPP
