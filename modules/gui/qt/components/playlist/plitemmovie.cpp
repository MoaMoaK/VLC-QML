#include "plitemmovie.hpp"

#include "standardpanel.hpp"

PLItemMovie::PLItemMovie( intf_thread_t *_p_intf, playlist_item_t *p_item, PLItem *parent) :
    PLItem(_p_intf, p_item, parent), QObject()
{ }

void PLItemMovie::displayInfo() {
    fprintf(stderr, "displayInfo->Movie : %s \n", inputItem()->psz_name);
    StandardPLPanel *mv = PlaylistDialog::getInstance(p_intf)->exportPlaylistWidget()->mainView;
    mv->showInfoMovie(this);
}

void PLItemMovie::back() {
    StandardPLPanel *mv = PlaylistDialog::getInstance(p_intf)->exportPlaylistWidget()->mainView;
    mv->hideInfoMovie();
}

QString PLItemMovie::getTitle() {
    return PLItem::getTitle();
}

QString PLItemMovie::getArtworkURL() {
    return input_item_GetArtworkURL(inputItem()) ;
}

