#include "mcmedialib.hpp"


#include <qt5/QtCore/QString>

#include <vlc_playlist.h>
#include <vlc_input_item.h>

MCMediaLib::MCMediaLib(intf_thread_t *_p_intf, QObject *parent)
    : QAbstractListModel(parent)
{
    p_intf = _p_intf;
    current_cat = CAT_MUSIC_ALBUM;

    ml = NewMediaLibrary();
    cb = new medialibrary::ExCallback();
    ml->initialize("/home/moamoak/vlc-bdd.db", "/home/moamoak/vlc-thumb", cb);
    ml->start();

    albums = NULL;
    artists = NULL;
    genres = NULL;
    tracks = NULL;
    videos = NULL;
    networks = NULL;

    retrieveAlbums(medialibrary::SortingCriteria::Duration);
}

QVariant MCMediaLib::headerData(int section, Qt::Orientation orientation, int role) const
{
    return QVariant (QString("This is a header"));
}

int MCMediaLib::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    switch (current_cat)
    {
    case CAT_MUSIC_ALBUM :
        return albums->count();
        break;

    case CAT_MUSIC_ARTIST :
        return artists->count();
        break;

    case CAT_MUSIC_GENRE :
        return genres->count();
        break;

    case CAT_MUSIC_TRACKS :
        return tracks->count();
        break;

    case CAT_VIDEO :
        return videos->count();
        break;

    case CAT_NETWORK :
        return networks->count();
        break;

    default:
        return 0;
    }
}

QVariant MCMediaLib::getCategory()
{
    switch(current_cat)
    {
    case CAT_MUSIC_ALBUM:
        return QVariant("music-albums");

    case CAT_MUSIC_ARTIST:
        return QVariant("music-artists");

    case CAT_MUSIC_GENRE:
        return QVariant("music-genres");

    case CAT_MUSIC_TRACKS:
        return QVariant("music-tracks");

    case CAT_VIDEO:
        return QVariant("video");

    case CAT_NETWORK:
        return QVariant("network");

    default:
        return QVariant("");
    }
}

void MCMediaLib::selectSource( const QString &name )
{
    if (name == "music" && current_cat != CAT_MUSIC_ALBUM)
    {
        msg_Dbg( p_intf, "Switching to music-general view");
        current_cat = CAT_MUSIC_ALBUM;
        retrieveAlbums();
    }
    else if (name == "music-albums" && current_cat != CAT_MUSIC_ALBUM)
    {
        msg_Dbg( p_intf, "Switching to music-albums view");
        current_cat = CAT_MUSIC_ALBUM;
        retrieveAlbums();
    }
    else if (name == "music-artists" && current_cat != CAT_MUSIC_ARTIST)
    {
        msg_Dbg( p_intf, "Switching to music-artists view");
        current_cat = CAT_MUSIC_ARTIST;
        retrieveArtists();
    }
    else if (name == "music-genre" && current_cat != CAT_MUSIC_GENRE)
    {
        msg_Dbg( p_intf, "Switching to music-genre view");
        current_cat = CAT_MUSIC_GENRE;
        retrieveGenres();
    }
    else if (name == "music-tracks" && current_cat != CAT_MUSIC_TRACKS)
    {
        msg_Dbg( p_intf, "Switching to music-track view");
        current_cat = CAT_MUSIC_TRACKS;
        retrieveTracks();
    }
    else if (name == "video" && current_cat != CAT_VIDEO)
    {
        msg_Dbg( p_intf, "Switching to video-general view");
        current_cat = CAT_VIDEO;
        retrieveMovies();
    }
    else if (name == "network" && current_cat != CAT_NETWORK)
    {
        msg_Dbg( p_intf, "Switching to network-general view");
        current_cat = CAT_NETWORK;
        retrieveSeries();
    }
}

void MCMediaLib::sort( const QString &criteria )
{
    if (criteria == "Alphabetic asc")
    {
        msg_Dbg( p_intf, "Sorting by ascending alphabetic order");
        sortCurrent(medialibrary::SortingCriteria::Alpha);
    }
    else if (criteria == "Alphabetic desc")
    {
        msg_Dbg( p_intf, "Sorting by descending alphabetic order");
        sortCurrent(medialibrary::SortingCriteria::Alpha, true);
    }
    else if (criteria == "Duration asc")
    {
        msg_Dbg( p_intf, "Sorting by ascending duration order");
        sortCurrent(medialibrary::SortingCriteria::Duration);
    }
    else if (criteria == "Duration desc")
    {
        msg_Dbg( p_intf, "Sorting by descending duration order");
        sortCurrent(medialibrary::SortingCriteria::Duration, true);
    }
    else if (criteria == "Date asc")
    {
        msg_Dbg( p_intf, "Sorting by ascending date order");
        sortCurrent(medialibrary::SortingCriteria::ReleaseDate);
    }
    else if (criteria == "Date desc")
    {
        msg_Dbg( p_intf, "Sorting by descending date order");
        sortCurrent(medialibrary::SortingCriteria::ReleaseDate, true);
    }
    else if (criteria == "Artist asc")
    {
        msg_Dbg( p_intf, "Sorting by ascending artist order");
        sortCurrent(medialibrary::SortingCriteria::Artist);
    }
    else if (criteria == "Artist desc")
    {
        msg_Dbg( p_intf, "Sorting by descending artist order");
        sortCurrent(medialibrary::SortingCriteria::Artist, true);
    }
}

void MCMediaLib::sortCurrent(medialibrary::SortingCriteria sort, bool desc)
{
    switch (current_cat)
    {
    case CAT_MUSIC_ALBUM:
        retrieveAlbums(sort, desc);
        break;
    case CAT_MUSIC_ARTIST:
        retrieveArtists(sort, desc);
        break;
    case CAT_MUSIC_GENRE:
        retrieveGenres(sort, desc);
        break;
    case CAT_MUSIC_TRACKS:
        retrieveTracks(sort, desc);
        break;
    case CAT_VIDEO:
        retrieveMovies(sort, desc);
        break;
    case CAT_NETWORK:
        retrieveSeries(sort, desc);
        break;
    default:
        break;
    }
}

bool MCMediaLib::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid())
        return false;

    return false;

}

QVariant MCMediaLib::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    switch (current_cat) {
    case CAT_MUSIC_ALBUM :
    {
        MLAlbum *item = getAlbumItem( index );
        if (!item) return QVariant();

        switch (role) {
        case GET_ID :
            return QVariant( item->getId() );
        case GET_TITLE :
            return QVariant( item->getTitle() );
        case GET_RELEASE_YEAR :
            return QVariant( item->getReleaseYear() );
        case GET_SHORT_SUMMARY :
            return QVariant( item->getShortSummary() );
        case GET_COVER :
            return QVariant( item->getCover() );
        case GET_TRACKS :
            return QVariant::fromValue( item->getTracks() );
        case GET_ARTIST :
            return QVariant( item->getArtist() );
        case GET_NB_TRACKS :
            return QVariant( item->getNbTracks() );
        case GET_DURATION :
            return QVariant( item->getDuration() );
        case GET_ALBUM :
            return QVariant::fromValue( item );
        default:
            return QVariant();
        }
    }

    case CAT_MUSIC_ARTIST :
    {
        MLArtist *item = getArtistItem( index );
        if (!item) return QVariant();

        switch (role) {
        case GET_ID :
            return QVariant( item->getId() );
        case GET_NAME :
            return QVariant( item->getName() );
        case GET_SHORT_BIO :
            return QVariant( item->getShortBio() );
        case GET_ALBUMS :
            return QVariant::fromValue( item->getAlbums() );
        case GET_COVER :
            return QVariant( item->getCover() );
        case GET_NB_ALBUMS :
            return QVariant( item->getNbAlbums() );
        case GET_ARTIST :
            return QVariant::fromValue( item );
        default:
            return QVariant();
        }
    }



/* NOT IMPLEMENTED YET
 *    case CAT_MUSIC_GENRE :
 *    {
 *        MLMusicAlbum *item = getAlbumItem( index );
 *        if (!item) return QVariant();
 *
 *        switch (role) {
 *        default:
 *            return QVariant();
 *        }
 *    }
 */


/* NOT IMPLEMENTED YET
 *    case CAT_MUSIC_TRACK :
 *    {
 *        MLMusicAlbum *item = getAlbumItem( index );
 *        if (!item) return QVariant();
 *
 *        switch (role) {
 *        default:
 *            return QVariant();
 *        }
 *    }
 */

/* NOT IMPLEMENTED YET
 *    case CAT_MOVIE :
 *    {
 *        MLMovie *item = getMovieItem( index );
 *        if (!item) return QVariant();
 *
 *        switch (role) {
 *        default:
 *            return QVariant();
 *        }
 *    }
 */

/* NOT IMPLEMENTED YET
 *    case CAT_SERIE :
 *    {
 *        MLSerie *item = getSerieItem( index );
 *        if (!item) return QVariant();
 *
 *        switch (role) {
 *        default:
 *            return QVariant();
 *        }
 *    }
 */

    default:
        return QVariant();
    }
}

QHash<int, QByteArray> MCMediaLib::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::FontRole] = "font";
    roles[Qt::DisplayRole] = "display";
    roles[Qt::DecorationRole] = "decoration";
    roles[Qt::BackgroundRole] = "background";
    roles[GET_ID] = "id";
    roles[GET_TITLE] = "title";
    roles[GET_RELEASE_YEAR] = "release_year";
    roles[GET_SHORT_SUMMARY] = "short_summary";
    roles[GET_COVER] = "cover";
    roles[GET_TRACKS] = "tracks";
    roles[GET_ARTIST] = "artist";
    roles[GET_NB_TRACKS] = "nb_tracks";
    roles[GET_DURATION] = "duration";
    roles[GET_ALBUM] = "album";
    roles[GET_NAME] = "name";
    roles[GET_SHORT_BIO] = "short_bio";
    roles[GET_ALBUMS] = "albums";
    roles[GET_NB_ALBUMS] = "nb_albums";
    return roles;
}

void MCMediaLib::update()
{
    switch (current_cat)
    {
    case CAT_MUSIC_ALBUM :
        retrieveAlbums();
        break;

    case CAT_MUSIC_ARTIST :
        retrieveArtists();
        break;

    case CAT_MUSIC_GENRE :
        retrieveGenres();
        break;

    case CAT_MUSIC_TRACKS :
        retrieveTracks();
        break;

    case CAT_VIDEO :
        retrieveMovies();
        break;

    case CAT_NETWORK :
        retrieveSeries();
        break;

    default:
        break;
    }
}




// Getters for items in the model

MLAlbum* MCMediaLib::getAlbumItem( const QModelIndex & index ) const
{
    int r = index.row();
    if (index.isValid() && r >= 0 && r < rowCount())
        return albums->at(r);
    else
        return NULL;
}


MLArtist *MCMediaLib::getArtistItem( const QModelIndex & index ) const
{
    int r = index.row();
    if (index.isValid() && r >= 0 && r < rowCount())
        return artists->at(r);
    else
        return NULL;
}


MLAlbum* MCMediaLib::getGenreItem( const QModelIndex & index ) const
{
    int r = index.row();
    if (index.isValid() && r >= 0 && r < rowCount())
        return genres->at(r);
    else
        return NULL;
}


MLAlbum* MCMediaLib::getTrackItem( const QModelIndex & index ) const
{
    int r = index.row();
    if (index.isValid() && r >= 0 && r < rowCount())
        return tracks->at(r);
    else
        return NULL;
}

MLMovie* MCMediaLib::getMovieItem( const QModelIndex & index ) const
{
    int r = index.row();
    if (index.isValid() && r >= 0 && r < rowCount())
        return videos->at(r);
    else
        return NULL;
}

MLSerie* MCMediaLib::getSerieItem( const QModelIndex & index ) const
{
    int r = index.row();
    if (index.isValid() && r >= 0 && r < rowCount())
        return networks->at(r);
    else
        return NULL;
}




// Retriever to fetch items in medialib

void MCMediaLib::retrieveAlbums( medialibrary::SortingCriteria sort, bool desc )
{
    beginResetModel();
    {
        if (albums) delete albums;
        albums = new QList<MLAlbum*>();
        std::vector<medialibrary::AlbumPtr> a = ml->albums(sort, desc);
        for ( int i=0 ; i<a.size() ; i++ )
            albums->append( new MLAlbum( a[i] ) );
    }
    endResetModel();
}

void MCMediaLib::retrieveArtists( medialibrary::SortingCriteria sort, bool desc )
{
    beginResetModel();
    {
        if (artists) delete artists;
        artists = new QList<MLArtist*>();
        std::vector<medialibrary::ArtistPtr> a = ml->artists(sort, desc);
        for ( int i=0 ; i<a.size() ; i++ )
            artists->append( new MLArtist( a[i] ) );
    }
    endResetModel();
}

void MCMediaLib::retrieveGenres( medialibrary::SortingCriteria sort, bool desc )
{
    beginResetModel();
    {
        if (genres) delete genres;
        genres = new QList<MLAlbum*>();
/* NOT IMPLEMENTED YET
 *        std::vector<medialibrary::AlbumPtr> g = ml->genres(sort, desc);
 *        for ( int i=0 ; i<g.size() ; i++ )
 *            genres->append( new MLAlbum( g[i] ) );
 */
    }
    endResetModel();
}

void MCMediaLib::retrieveTracks( medialibrary::SortingCriteria sort, bool desc )
{
    beginResetModel();
    {
        if (tracks) delete tracks;
        tracks = new QList<MLAlbum*>();
/* NOT IMPLEMENTED YET
 *        std::vector<medialibrary::AlbumPtr> t = ml->tracks(sort, desc);
 *        for ( int i=0 ; i<t.size() ; i++ )
 *            tracks->append( new MLAlbum( t[i] ) );
 */
    }
    endResetModel();
}

void MCMediaLib::retrieveMovies( medialibrary::SortingCriteria sort, bool desc )
{
    beginResetModel();
    {
        if (videos) delete videos;
        videos = new QList<MLMovie*>();
/* NOT IMPLEMENTED YET IN API
 *        std::vector<MoviePtr> m = ml->movies(sort, desc);
 *        for ( int i=0 ; i<m.size() ; i++ )
 *            movies->append( new MLMovie( m[i] ) );
 */
    }
    endResetModel();
}

void MCMediaLib::retrieveSeries( medialibrary::SortingCriteria sort, bool desc )
{
    beginResetModel();
    {
        if (networks) delete networks;
        networks = new QList<MLSerie*>();
/* NOT IMPLEMENTED YET IN API
 *        std::vector<SeriesPtr> s = ml->series(sort, desc);
 *        for ( int i=0 ; i<s.size() ; i++ )
 *            series->append( new MLAlbum( s[i] ) );
 */
    }
    endResetModel();
}
