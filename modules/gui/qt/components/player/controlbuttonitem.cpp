#include "controlbuttonitem.hpp"
#include <iostream>

ControlButtonItem::ControlButtonItem(intf_thread_t *_p_intf, buttonType_e type, int opt) :
    p_intf( _p_intf ),
    type( type ),
    designOption( opt ),
    state( 0 )
{
    switch (type) {
    case PLAY_BUTTON:
        action = PLAY_ACTION;
        break;
    case STOP_BUTTON:
        action = STOP_ACTION;
        break;
    case OPEN_BUTTON:
        action = OPEN_ACTION;
        break;
    case PREV_SLOW_BUTTON:
        action = PREVIOUS_ACTION;
        break;
    case NEXT_FAST_BUTTON:
        action = NEXT_ACTION;
        break;
    case SLOWER_BUTTON:
        action = SLOWER_ACTION;
        break;
    case FASTER_BUTTON:
        action = FASTER_ACTION;
        break;
    case FULLSCREEN_BUTTON:
        action = FULLSCREEN_ACTION;
        break;
    case DEFULLSCREEN_BUTTON:
        action = FULLSCREEN_ACTION;
        break;
    case EXTENDED_BUTTON:
        action = EXTENDED_ACTION;
        break;
    case PLAYLIST_BUTTON:
        action = PLAYLIST_ACTION;
        break;
    case SNAPSHOT_BUTTON:
        action = SNAPSHOT_ACTION;
        break;
    case RECORD_BUTTON:
        action = RECORD_ACTION;
        break;
    case ATOB_BUTTON:
        action = ATOB_ACTION;
        break;
    case FRAME_BUTTON:
        action = FRAME_ACTION;
        break;
    case REVERSE_BUTTON:
        action = REVERSE_ACTION;
        break;
    case SKIP_BACK_BUTTON:
        action = SKIP_BACK_ACTION;
        break;
    case SKIP_FW_BUTTON:
        action = SKIP_FW_ACTION;
        break;
    case QUIT_BUTTON:
        action = QUIT_ACTION;
        break;
    case RANDOM_BUTTON:
        action = RANDOM_ACTION;
        break;
    case LOOP_BUTTON:
        action = LOOP_ACTION;
        break;
    case INFO_BUTTON:
        action = INFO_ACTION;
        break;
    case PREVIOUS_BUTTON:
        action = PREVIOUS_ACTION;
        break;
    case NEXT_BUTTON:
        action = NEXT_ACTION;
        break;
    case OPEN_SUB_BUTTON:
        action = OPEN_SUB_ACTION;
        break;
    case FULLWIDTH_BUTTON:
        action = FULLWIDTH_ACTION;
        break;
    default:
        action = PLAY_ACTION;
        break;
    }

}

QString ControlButtonItem::getText() {
    if ( type < BUTTON_MAX )
        return QString( nameL[type] );
    else
        return QString( "noname" );
}

QString ControlButtonItem::getIcon() {
    if ( type == PLAY_BUTTON )
        return QString( state == 0 ? "qrc:///toolbar/pause_b" : "qrc:///toolbar/play_b" );
    else if ( type < BUTTON_MAX )
    {
        QString copy = iconL[type];
        return QString( "qrc://" ).append( copy.remove(0,1) );
    }
    else
        return QString( "qrc:///noart.png" );
}

void ControlButtonItem::singleClick()
{
    ActionsManager::getInstance( p_intf )->doAction( (int) action );
    if ( type == PLAY_BUTTON )
        state = state == 0 ? 1 : 0;
}

void ControlButtonItem::doubleClick()
{
}
