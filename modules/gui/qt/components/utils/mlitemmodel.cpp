#include "mlitemmodel.hpp"

#include "components/mediacenter/mlitem.hpp"
#include "components/mediacenter/mlalbumtrack.hpp"


MLItemModel::MLItemModel(const QList<MLItem *> *item, QObject *parent):
    QAbstractListModel( parent )
{
    ml_item_list = new QList<MLItem *>;
    for (int i=0 ; i<item->count() ; i++)
        ml_item_list->append(item->at(i));
}


MLItemModel::MLItemModel(const MLItemModel &other):
    ml_item_list ( other.getMLItemModel() )
{ }

MLItemModel::~MLItemModel()
{ }

MLItemModel& MLItemModel::operator=(const MLItemModel& other)
{
    ml_item_list = other.getMLItemModel();
}

int MLItemModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return ml_item_list->count();
}

QVariant MLItemModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    MLItem * ml_item = getItem(index);
    switch (role)
    {
    // Tracks
    case GET_TRACK_TITLE :
    {
        MLAlbumTrack* ml_track = dynamic_cast<MLAlbumTrack*>(ml_item);
        if (ml_track != NULL)
            return QVariant::fromValue( ml_track->getTitle() );
        else
            return QVariant();
    }
    case GET_TRACK_COVER :
    {
        MLAlbumTrack* ml_track = dynamic_cast<MLAlbumTrack*>(ml_item);
        if (ml_track != NULL)
            return QVariant::fromValue( ml_track->getCover() );
        else
            return QVariant();
    }
    case GET_TRACK_NUMBER :
    {
        MLAlbumTrack* ml_track = dynamic_cast<MLAlbumTrack*>(ml_item);
        if (ml_track != NULL)
            return QVariant::fromValue( ml_track->getTrackNumber() );
        else
            return QVariant();
    }
    case GET_TRACK_DURATION :
    {
        MLAlbumTrack* ml_track = dynamic_cast<MLAlbumTrack*>(ml_item);
        if (ml_track != NULL)
            return QVariant::fromValue( ml_track->getDuration() );
        else
            return QVariant();
    }

    default :
        return QVariant();
    }

}

QHash<int, QByteArray> MLItemModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    // Tracks
    roles[GET_TRACK_TITLE] = "track_title";
    roles[GET_TRACK_COVER] = "track_cover";
    roles[GET_TRACK_NUMBER] = "track_number";
    roles[GET_TRACK_DURATION] = "track_duration";

    return roles;
}

QVariantMap MLItemModel::get(int row) {
    QHash<int,QByteArray> names = roleNames();
    QHashIterator<int, QByteArray> i(names);
    QVariantMap res;
    while (i.hasNext()) {
        i.next();
        QModelIndex idx = index(row, 0);
        QVariant data = idx.data(i.key());
        res[i.value()] = data;
    }
    return res;
}

MLItem* MLItemModel::getItem(const QModelIndex &index) const
{
    int r = index.row();
    if (index.isValid())
        return ml_item_list->at(r);
    else
        return NULL;
}

QList<MLItem *> *MLItemModel::getMLItemModel() const
{
    return ml_item_list;
}
