
#ifndef QVLC_HELP_DIALOG_H_
#define QVLC_HELP_DIALOG_H_ 1

#ifdef HAVE_CONFIG_H
# include "config.h"
#endif

#include "qt.hpp"

#include "util/qvlcframe.hpp"
#include "util/singleton.hpp"
#include "ui/help.h"
#include <QQuickView>


class HelpDialog : public QObject, public Singleton<HelpDialog>
{
    Q_OBJECT
private:
    HelpDialog( intf_thread_t * );
    ~HelpDialog();
    QQuickView view;

public slots:
    friend class    Singleton<HelpDialog>;

public :
    void show();
    Q_INVOKABLE void hide();
};

#endif
