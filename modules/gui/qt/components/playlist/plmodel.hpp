#ifndef PLMODEL_H
#define PLMODEL_H

#include <qt5/QtCore/Qt>
#include <qt5/QtCore/QAbstractListModel>
#include <qt5/QtCore/QVariant>
#include <qt5/QtCore/QHash>
#include <qt5/QtCore/QByteArray>

#include "qt.hpp"
#include "input_manager.hpp"

enum PLModelRoles {
    TITLE_ROLE = Qt::UserRole + 1,
    DURATION_ROLE,
    CURRENT_ROLE
};

class PLModel : public QAbstractListModel
{
    Q_OBJECT

public:
    PLModel(intf_thread_t *_p_intf, QObject *parent = nullptr);

    // Header:
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    QHash<int, QByteArray> roleNames() const;

private:
    intf_thread_t *p_intf;

private slots:
    void processInputItemUpdate();
    void processItemRemoval(int i_pl_itemid);
    void processItemAppend(int i_pl_itemid, int i_pl_itemidparent);

};

#endif // PLMODEL_H
