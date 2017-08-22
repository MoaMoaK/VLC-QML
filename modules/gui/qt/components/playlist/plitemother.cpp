#include "plitemother.hpp"

PLItemOther::PLItemOther( intf_thread_t *_p_intf, playlist_item_t *p_item, PLItem *parent) :
    PLItem(_p_intf, p_item, parent)
{ }

void PLItemOther::displayInfo() {
    fprintf(stderr, "displayInfo->Other : %s \n", inputItem()->psz_name);
}

