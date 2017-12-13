#include "mlitemmodel.hpp"

#include "components/mediacenter/mlitem.hpp"
#include "components/mediacenter/mlalbum.hpp"
#include "components/mediacenter/mlartist.hpp"
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
    // Albums
    case GET_ALBUM_ID :
    {
        MLAlbum* ml_album = dynamic_cast<MLAlbum*>(ml_item);
        if (ml_album != NULL)
            return QVariant::fromValue( ml_album->getId() );
        else
            return QVariant();
    }
    case GET_ALBUM_TITLE :
    {
        MLAlbum* ml_album = dynamic_cast<MLAlbum*>(ml_item);
        if (ml_album != NULL)
            return QVariant::fromValue( ml_album->getTitle() );
        else
            return QVariant();
    }
    case GET_ALBUM_RELEASE_YEAR :
    {
        MLAlbum* ml_album = dynamic_cast<MLAlbum*>(ml_item);
        if (ml_album != NULL)
            return QVariant::fromValue( ml_album->getReleaseYear() );
        else
            return QVariant();
    }
    case GET_ALBUM_SHORT_SUMMARY :
    {
        MLAlbum* ml_album = dynamic_cast<MLAlbum*>(ml_item);
        if (ml_album != NULL)
            return QVariant::fromValue( ml_album->getShortSummary() );
        else
            return QVariant();
    }
    case GET_ALBUM_COVER :
    {
        MLAlbum* ml_album = dynamic_cast<MLAlbum*>(ml_item);
        if (ml_album != NULL)
            return QVariant::fromValue( ml_album->getCover() );
        else
            return QVariant();
    }
    case GET_ALBUM_TRACKS :
    {
        MLAlbum* ml_album = dynamic_cast<MLAlbum*>(ml_item);
        if (ml_album != NULL)
            return QVariant::fromValue<MLItemModel*>( ml_album->getTracks() );
        else
            return QVariant();
    }
    case GET_ALBUM_MAIN_ARTIST :
    {
        MLAlbum* ml_album = dynamic_cast<MLAlbum*>(ml_item);
        if (ml_album != NULL)
            return QVariant::fromValue( ml_album->getArtist() );
        else
            return QVariant();
    }
    case GET_ALBUM_ARTISTS :
    {
        MLAlbum* ml_album = dynamic_cast<MLAlbum*>(ml_item);
        if (ml_album != NULL)
            return QVariant::fromValue( ml_album->getArtists() );
        else
            return QVariant();
    }
    case GET_ALBUM_NB_TRACKS :
    {
        MLAlbum* ml_album = dynamic_cast<MLAlbum*>(ml_item);
        if (ml_album != NULL)
            return QVariant::fromValue( ml_album->getNbTracks() );
        else
            return QVariant();
    }
    case GET_ALBUM_DURATION :
    {
        MLAlbum* ml_album = dynamic_cast<MLAlbum*>(ml_item);
        if (ml_album != NULL)
            return QVariant::fromValue( ml_album->getDuration() );
        else
            return QVariant();
    }

    // Artists
    case GET_ARTIST_ID :
    {
        MLArtist* ml_artist = dynamic_cast<MLArtist*>(ml_item);
        if (ml_artist != NULL)
            return QVariant::fromValue( ml_artist->getId() );
        else
            return QVariant();
    }
    case GET_ARTIST_NAME :
    {
        MLArtist* ml_artist = dynamic_cast<MLArtist*>(ml_item);
        if (ml_artist != NULL)
            return QVariant::fromValue( ml_artist->getName() );
        else
            return QVariant();
    }
    case GET_ARTIST_SHORT_BIO :
    {
        MLArtist* ml_artist = dynamic_cast<MLArtist*>(ml_item);
        if (ml_artist != NULL)
            return QVariant::fromValue( ml_artist->getShortBio() );
        else
            return QVariant();
    }
    case GET_ARTIST_ALBUMS :
    {
        MLArtist* ml_artist = dynamic_cast<MLArtist*>(ml_item);
        if (ml_artist != NULL)
            return QVariant::fromValue<MLItemModel*>( ml_artist->getAlbums() );
        else
            return QVariant();
    }
    case GET_ARTIST_COVER :
    {
        MLArtist* ml_artist = dynamic_cast<MLArtist*>(ml_item);
        if (ml_artist != NULL)
            return QVariant::fromValue( ml_artist->getCover() );
        else
            return QVariant();
    }
    case GET_ARTIST_NB_ALBUMS :
    {
        MLArtist* ml_artist = dynamic_cast<MLArtist*>(ml_item);
        if (ml_artist != NULL)
            return QVariant::fromValue( ml_artist->getNbAlbums() );
        else
            return QVariant();
    }

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

    // Albums
    roles[GET_ALBUM_ID] = "album_id";
    roles[GET_ALBUM_TITLE] = "album_title";
    roles[GET_ALBUM_RELEASE_YEAR] = "album_release_year";
    roles[GET_ALBUM_SHORT_SUMMARY] = "album_shortsummary";
    roles[GET_ALBUM_COVER] = "album_cover";
    roles[GET_ALBUM_TRACKS] = "album_tracks";
    roles[GET_ALBUM_MAIN_ARTIST] = "album_main_artist";
    roles[GET_ALBUM_ARTISTS] = "album_artists";
    roles[GET_ALBUM_NB_TRACKS] = "album_nb_tracks";
    roles[GET_ALBUM_DURATION] = "album_duration";

    // Artists
    roles[GET_ARTIST_ID] = "artist_id";
    roles[GET_ARTIST_NAME] = "artist_name";
    roles[GET_ARTIST_SHORT_BIO] = "artist_short_bio";
    roles[GET_ARTIST_ALBUMS] = "artist_albums";
    roles[GET_ARTIST_COVER] = "artist_cover";
    roles[GET_ARTIST_NB_ALBUMS] = "artist_nb_albums";

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
