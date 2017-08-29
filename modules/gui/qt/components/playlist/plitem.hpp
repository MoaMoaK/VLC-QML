#ifndef PLITEM_HPP
#define PLITEM_HPP

#include "qt.hpp"
#include <qt5/QtCore/QString>


class PLItem
{
public:
    PLItem( playlist_item_t* _pl_item, int _pl_id );
    QString getTitle();
    QString getDuration();

    void activate( playlist_t* pl );

    int getId() { return pl_id; }

private:
    playlist_item_t* getItem() { return pl_item; }

private:
    playlist_item_t* pl_item;
    int pl_id;
};

#endif // PLITEM_HPP
