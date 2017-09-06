#include "controlbuttonitem.hpp"
#include <iostream>

ControlButtonItem::ControlButtonItem(buttonType_e type, int opt) :
    buttonType( type ),
    buttonOption( opt )
{

}

QString ControlButtonItem::getButtonText() {
    if ( buttonType < BUTTON_MAX )
        return QString( nameL[buttonType] );
    else
        return QString( "noname" );
}

QString ControlButtonItem::getButtonIcon() {
    if ( buttonType < BUTTON_MAX )
    {
        QString copy = iconL[buttonType];
        return QString( "qrc://" ).append( copy.remove(0,1) );
    }
    else
        return QString( "qrc:///noart.png" );
}

void ControlButtonItem::singleClick()
{
}

void ControlButtonItem::doubleClick()
{
}
