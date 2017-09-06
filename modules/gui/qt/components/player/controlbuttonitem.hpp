#ifndef CONTROLBUTTON_HPP
#define CONTROLBUTTON_HPP

#include <qt5/QtCore/QObject>
#include <qt5/QtCore/QString>
#include <qt5/QtCore/QUrl>
#include "components/controller.hpp"
#include "actions_manager.hpp"

class ControlButtonItem
{

public:
    ControlButtonItem(intf_thread_t *_p_intf, buttonType_e type, int opt);
    QString getText();
    QString getIcon();
    void singleClick();
    void doubleClick();

private:
    intf_thread_t *p_intf;

    buttonType_e type;
    actionType_e action;
    int designOption;

    int state; // For buttons with multiple states
};



#endif // CONTROLBUTTON_HPP
