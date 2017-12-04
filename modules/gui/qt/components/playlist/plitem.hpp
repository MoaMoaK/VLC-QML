#ifndef PLITEM_HPP
#define PLITEM_HPP

#include "qt.hpp"
#include <qt5/QtCore/QString>
#include "components/mediacenter/mlalbumtrack.hpp"


class PLItem
{
public:
    PLItem( MLAlbumTrack* _item);
    QString getTitle();
    QString getName();
    QString getDuration();

    input_item_t* getInputItem() { return inputItem; }

    void activate( playlist_t* pl );

private:
    MLAlbumTrack* getItem() { return pl_item; }

private:
    MLAlbumTrack* pl_item;

    input_item_t* inputItem;
};

#endif // PLITEM_HPP
