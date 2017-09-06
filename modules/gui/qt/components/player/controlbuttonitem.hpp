#ifndef CONTROLBUTTON_HPP
#define CONTROLBUTTON_HPP

#include <qt5/QtCore/QObject>
#include <qt5/QtCore/QString>
#include <qt5/QtCore/QUrl>
#include "components/controller.hpp"

class ControlButtonItem
{

public:
    ControlButtonItem(buttonType_e type, int opt);
    QString getButtonText();
    QString getButtonIcon();
    void singleClick();
    void doubleClick();

private:
    buttonType_e buttonType;
    int buttonOption;
};



#endif // CONTROLBUTTON_HPP
