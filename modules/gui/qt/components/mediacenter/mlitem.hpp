#ifndef MLITEM_HPP
#define MLITEM_HPP

#include <qt5/QtCore/QObject>

class MLItem : public QObject
{
    Q_OBJECT
public:
    MLItem(QObject *parent = nullptr);
    MLItem(const MLItem &ml_item);
    ~MLItem();

signals:

public slots:
};

#endif // MLITEM_HPP
