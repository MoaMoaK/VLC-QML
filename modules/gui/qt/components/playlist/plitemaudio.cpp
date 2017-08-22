#include "plitemaudio.hpp"

PLItemAudio::PLItemAudio( intf_thread_t *_p_intf, playlist_item_t *p_item, PLItem *parent) :
    PLItem(_p_intf, p_item, parent)
{ }

void PLItemAudio::displayInfo() {
    fprintf(stderr, "displayInfo->Audio : %s \n", inputItem()->psz_name);
}
