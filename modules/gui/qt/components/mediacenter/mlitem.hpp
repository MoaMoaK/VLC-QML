#ifndef MLITEM_HPP
#define MLITEM_HPP

#include <qt5/QtCore/QObject>
#include <qt5/QtCore/QString>

#include "components/utils/mlitemmodel.hpp"

class MLItem : public QObject
{
    Q_OBJECT
public:
    MLItem(QObject *parent = nullptr);
    MLItem(const MLItem *ml_item);
    ~MLItem();

    Q_INVOKABLE virtual QString getPresName() const = 0;
    Q_INVOKABLE virtual QString getPresImage() const = 0;
    Q_INVOKABLE virtual QString getPresInfo() const = 0;
    Q_INVOKABLE virtual MLItemModel* getDetailsObjects() const = 0;
};


#endif // MLITEM_HPP
