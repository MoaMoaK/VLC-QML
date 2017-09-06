#ifndef CONTROLBUTTONMODEL_HPP
#define CONTROLBUTTONMODEL_HPP

#include <qt5/QtCore/Qt>
#include <qt5/QtCore/QObject>
#include <qt5/QtCore/QAbstractListModel>
#include <qt5/QtCore/QByteArray>
#include <qt5/QtCore/QHash>
#include <qt5/QtCore/QVariant>
#include <qt5/QtCore/QList>
#include "controlbuttonitem.hpp"

class ControlButtonModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum ControlButtonRoles {
        TEXT_ROLE = Qt::UserRole + 1,
        ICON_ROLE,
        SINGLE_CLICK_ROLE,
        DOUBLE_CLICK_ROLE
    };

    ControlButtonModel(intf_thread_t *_p_intf, QObject *parent = nullptr);

    /* Subclassing QAbstractListModel */
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData( const QModelIndex &index, const QVariant & value, int role = Qt::EditRole ) override;
    Qt::ItemFlags flags(const QModelIndex &index) const override;

private:
    ControlButtonItem* getItem(const QModelIndex &index ) const;

    QList<ControlButtonItem*> buttonList;
    intf_thread_t *p_intf;
};

#endif // CONTROLBUTTONMODEL_HPP
