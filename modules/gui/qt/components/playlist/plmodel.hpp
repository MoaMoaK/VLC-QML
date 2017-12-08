#ifndef PLMODEL_H
#define PLMODEL_H

#include <qt5/QtCore/Qt>
#include <qt5/QtCore/QAbstractListModel>
#include <qt5/QtCore/QVariant>
#include <qt5/QtCore/QHash>
#include <qt5/QtCore/QByteArray>
#include <qt5/QtCore/QList>

#include "qt.hpp"
#include "input_manager.hpp"
#include "plitem.hpp"

enum PLModelRoles {
    TITLE_ROLE = Qt::UserRole + 1,
    ALBUM_TITLE_ROLE,
    DURATION_ROLE,
    COVER_ROLE,
    CURRENT_ROLE
};

class PLModel : public QAbstractListModel
{
    Q_OBJECT

public:
    PLModel(intf_thread_t *_p_intf, QObject *parent = nullptr);

    /* Subclassing QAbstractListModel */
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const;
    Qt::ItemFlags flags(const QModelIndex &index) const override;

    /* Handling the playlist items */
    void removeItem(int index);
    void appendItem(PLItem* item, bool play);

    Q_INVOKABLE QVariantMap get(int row);
    Q_INVOKABLE void remove_item(int index);
    Q_INVOKABLE void play_item(int index);

private:
    PLItem* getItem(const QModelIndex &index ) const;

    intf_thread_t *p_intf;
    QList<PLItem*> plitems;

};

#endif // PLMODEL_H
