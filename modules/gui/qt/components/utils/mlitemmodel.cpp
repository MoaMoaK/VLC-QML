#include "mlitemmodel.hpp"

MLItemModel::MLItemModel(QList<MLItem *> *item, QObject *parent):
    ml_item_list( item ),
    QAbstractListModel( parent )
{ }

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
        return QVariant::fromValue( reinterpret_cast<MLAlbum*>(ml_item)->getId() );
    case GET_ALBUM_TITLE :
        return QVariant::fromValue( reinterpret_cast<MLAlbum*>(ml_item)->getTitle() );
    case GET_ALBUM_RELEASE_YEAR :
        return QVariant::fromValue( reinterpret_cast<MLAlbum*>(ml_item)->getReleaseYear() );
    case GET_ALBUM_SHORT_SUMMARY :
        return QVariant::fromValue( reinterpret_cast<MLAlbum*>(ml_item)->getShortSummary() );
    case GET_ALBUM_COVER :
        return QVariant::fromValue( reinterpret_cast<MLAlbum*>(ml_item)->getCover() );
    case GET_ALBUM_TRACKS :
        return QVariant::fromValue<MLItemModel*>( reinterpret_cast<MLAlbum*>(ml_item)->getTracks() );
    case GET_ALBUM_MAIN_ARTIST :
        return QVariant::fromValue( reinterpret_cast<MLAlbum*>(ml_item)->getArtist() );
    case GET_ALBUM_ARTISTS :
        return QVariant::fromValue( reinterpret_cast<MLAlbum*>(ml_item)->getArtists() );
    case GET_ALBUM_NB_TRACKS :
        return QVariant::fromValue( reinterpret_cast<MLAlbum*>(ml_item)->getNbTracks() );
    case GET_ALBUM_DURATION :
        return QVariant::fromValue( reinterpret_cast<MLAlbum*>(ml_item)->getDuration() );

    // Artists
    case GET_ARTIST_ID :
        return QVariant::fromValue( reinterpret_cast<MLArtist*>(ml_item)->getId() );
    case GET_ARTIST_NAME :
        return QVariant::fromValue( reinterpret_cast<MLArtist*>(ml_item)->getName() );
    case GET_ARTIST_SHORT_BIO :
        return QVariant::fromValue( reinterpret_cast<MLArtist*>(ml_item)->getShortBio() );
    case GET_ARTIST_ALBUMS :
        return QVariant::fromValue<MLItemModel*>( reinterpret_cast<MLArtist*>(ml_item)->getAlbums() );
    case GET_ARTIST_COVER :
        return QVariant::fromValue( reinterpret_cast<MLArtist*>(ml_item)->getCover() );
    case GET_ARTIST_NB_ALBUMS :
        return QVariant::fromValue( reinterpret_cast<MLArtist*>(ml_item)->getNbAlbums() );

    // Tracks
    case GET_TRACK_TITLE :
        return QVariant::fromValue( reinterpret_cast<MLAlbumTrack*>(ml_item)->getTitle() );
    case GET_TRACK_NUMBER :
        return QVariant::fromValue( reinterpret_cast<MLAlbumTrack*>(ml_item)->getTrackNumber() );
    case GET_TRACK_DURATION :
        return QVariant::fromValue( reinterpret_cast<MLAlbumTrack*>(ml_item)->getDuration() );

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
    roles[GET_TRACK_NUMBER] = "track_number";
    roles[GET_TRACK_DURATION] = "track_duration";

    return roles;
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
