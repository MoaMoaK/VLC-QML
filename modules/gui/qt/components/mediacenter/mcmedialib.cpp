#include "mcmedialib.hpp"


#include <qt5/QtCore/QString>

#include <vlc_playlist.h>
#include <vlc_input_item.h>

MCMediaLib::MCMediaLib(intf_thread_t *_p_intf, QQuickWidget *_qml_item, QObject *parent)
    : p_intf( _p_intf ),
      qmlItem( _qml_item ),
      current_cat ( CAT_MUSIC_ALBUM ),
      current_sort( medialibrary::SortingCriteria::Default ),
      is_desc( false ),
      ml( NewMediaLibrary() ),
      cb( new medialibrary::ExCallback() ),
      m_gridView( true ),
      QAbstractListModel(parent)
{
    ml->initialize("/home/moamoak/vlc-bdd.db", "/home/moamoak/vlc-thumb", cb);
    ml->start();

    albums = NULL;
    artists = NULL;
    genres = NULL;
    tracks = NULL;
    videos = NULL;
    networks = NULL;

    current_obj = NULL;
    current_main_obj = NULL;

    retrieveAlbums();
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

QVariant MCMediaLib::hasPresentation() {
    if (current_main_obj)
        return true;
    else
        return false;
}

QVariant MCMediaLib::getCategory()
{
    return QVariant( current_cat );
}

QVariant MCMediaLib::getObjects()
{
    return QVariant::fromValue<MLItemModel*>( new MLItemModel(current_obj) );
//    QList<QObject*> objects = QList<QObject*>();
//    switch(current_cat)
//    {
//    case CAT_MUSIC_ALBUM:
//        for ( int i=0 ; i<albums->count() ; i++ )
//            objects.append( albums->at(i) );
//        return QVariant::fromValue(objects);

//    case CAT_MUSIC_ARTIST:
//        for ( int i=0 ; i<artists->count() ; i++ )
//            objects.append( artists->at(i) );
//        return QVariant::fromValue(objects);

//    case CAT_MUSIC_GENRE:
//        for ( int i=0 ; i<genres->count() ; i++ )
//            objects.append( genres->at(i) );
//        return QVariant::fromValue(objects);

//    case CAT_MUSIC_TRACKS:
//        for ( int i=0 ; i<tracks->count() ; i++ )
//            objects.append( tracks->at(i) );
//        return QVariant::fromValue(objects);

//    case CAT_VIDEO:
//        for ( int i=0 ; i<videos->count() ; i++ )
//            objects.append( videos->at(i) );
//        return QVariant::fromValue(objects);

//    case CAT_NETWORK:
//        for ( int i=0 ; i<networks->count() ; i++ )
//            objects.append( networks->at(i) );
//        return QVariant::fromValue(objects);

//    default:
//        return QVariant();
//    }
}

QVariant MCMediaLib::isGridView()
{
    return QVariant( m_gridView );
}

void MCMediaLib::toogleView()
{
    m_gridView = !m_gridView;
    invokeQML("changedView()");
}

void MCMediaLib::select( const int &item_id )
{
    if (item_id >= 0 && item_id <= current_obj->count())
    {
        current_main_obj = current_obj->at(item_id);
        current_obj = current_main_obj->getDetailsObjects();
//        if (current_main_obj) delete current_main_obj;
//        if (current_obj) delete current_obj;

        switch (current_cat)
        {
        case CAT_MUSIC_ALBUM:
            current_cat = CAT_MUSIC_TRACKS;
            break;

        case CAT_MUSIC_ARTIST:
            current_cat = CAT_MUSIC_ALBUM;
            break;

        case CAT_MUSIC_GENRE:
            current_cat = CAT_MUSIC_ALBUM;
            break;

        default:
            break;
        }
    }

    invokeQML("reloadPresentation()");
    invokeQML("reloadData()");
}

QVariant MCMediaLib::getPresObject()
{
    if (current_main_obj)
        return QVariant::fromValue( current_main_obj );
    else
        return QVariant();
}

void MCMediaLib::selectSource( const QString &name )
{
    if (name == "music" && current_cat != CAT_MUSIC_ALBUM)
    {
        msg_Dbg( p_intf, "Switching to music-general view");
        current_cat = CAT_MUSIC_ALBUM;
        retrieveAlbums();
        if (current_main_obj) current_main_obj = NULL;
        invokeQML("reloadPresentation()");
        invokeQML("changedCategory()");
    }
    else if (name == "music-albums" && current_cat != CAT_MUSIC_ALBUM)
    {
        msg_Dbg( p_intf, "Switching to music-albums view");
        current_cat = CAT_MUSIC_ALBUM;
        retrieveAlbums();
        if (current_main_obj) current_main_obj = NULL;
        invokeQML("reloadPresentation()");
        invokeQML("changedCategory()");
    }
    else if (name == "music-artists" && current_cat != CAT_MUSIC_ARTIST)
    {
        msg_Dbg( p_intf, "Switching to music-artists view");
        current_cat = CAT_MUSIC_ARTIST;
        retrieveArtists();
        if (current_main_obj) current_main_obj = NULL;
        invokeQML("reloadPresentation()");
        invokeQML("changedCategory()");
    }
    else if (name == "music-genre" && current_cat != CAT_MUSIC_GENRE)
    {
        msg_Dbg( p_intf, "Switching to music-genre view");
        current_cat = CAT_MUSIC_GENRE;
        retrieveGenres();
        if (current_main_obj) current_main_obj = NULL;
        invokeQML("reloadPresentation()");
        invokeQML("changedCategory()");
    }
    else if (name == "music-tracks" && current_cat != CAT_MUSIC_TRACKS)
    {
        msg_Dbg( p_intf, "Switching to music-track view");
        current_cat = CAT_MUSIC_TRACKS;
        retrieveTracks();
        if (current_main_obj) current_main_obj = NULL;
        invokeQML("reloadPresentation()");
        invokeQML("changedCategory()");
    }
    else if (name == "video" && current_cat != CAT_VIDEO)
    {
        msg_Dbg( p_intf, "Switching to video-general view");
        current_cat = CAT_VIDEO;
        retrieveMovies();
        if (current_main_obj) current_main_obj = NULL;
        invokeQML("reloadPresentation()");
        invokeQML("changedCategory()");
    }
    else if (name == "network" && current_cat != CAT_NETWORK)
    {
        msg_Dbg( p_intf, "Switching to network-general view");
        current_cat = CAT_NETWORK;
        retrieveSeries();
        if (current_main_obj) current_main_obj = NULL;
        invokeQML("reloadPresentation()");
        invokeQML("changedCategory()");
    }
}

void MCMediaLib::sort( const QString &criteria )
{
    if (criteria == "Alphabetic asc")
    {
        msg_Dbg( p_intf, "Sorting by ascending alphabetic order");
        current_sort = medialibrary::SortingCriteria::Alpha;
        is_desc = false;
    }
    else if (criteria == "Alphabetic desc")
    {
        msg_Dbg( p_intf, "Sorting by descending alphabetic order");
        current_sort = medialibrary::SortingCriteria::Alpha;
        is_desc = true;
    }
    else if (criteria == "Duration asc")
    {
        msg_Dbg( p_intf, "Sorting by ascending duration order");
        current_sort = medialibrary::SortingCriteria::Duration;
        is_desc = false;
    }
    else if (criteria == "Duration desc")
    {
        msg_Dbg( p_intf, "Sorting by descending duration order");
        current_sort = medialibrary::SortingCriteria::Duration;
        is_desc = true;
    }
    else if (criteria == "Date asc")
    {
        msg_Dbg( p_intf, "Sorting by ascending date order");
        current_sort = medialibrary::SortingCriteria::ReleaseDate;
        is_desc = false;
    }
    else if (criteria == "Date desc")
    {
        msg_Dbg( p_intf, "Sorting by descending date order");
        current_sort = medialibrary::SortingCriteria::ReleaseDate;
        is_desc = true;
    }
    else if (criteria == "Artist asc")
    {
        msg_Dbg( p_intf, "Sorting by ascending artist order");
        current_sort = medialibrary::SortingCriteria::Artist;
        is_desc = false;
    }
    else if (criteria == "Artist desc")
    {
        msg_Dbg( p_intf, "Sorting by descending artist order");
        current_sort = medialibrary::SortingCriteria::Artist;
        is_desc = false;
    }
    if (!hasPresentation().toBool())
    {
        sortCurrent();
        invokeQML("reloadData()");
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


MLGenre* MCMediaLib::getGenreItem( const QModelIndex & index ) const
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
//        if (current_obj != NULL) delete current_obj;
        current_obj = new QList<MLItem*>();
        std::vector<medialibrary::AlbumPtr> a = ml->albums(current_sort, is_desc);
        for ( int i=0 ; i<a.size() ; i++ )
        {
            MLAlbum* item = new MLAlbum( a[i] );
            albums->append( item );
            current_obj->append( item );
        }
    }
    endResetModel();
}

void MCMediaLib::retrieveArtists( medialibrary::SortingCriteria sort, bool desc )
{
    beginResetModel();
    {
        if (artists) delete artists;
        artists = new QList<MLArtist*>();
//        if (current_obj != NULL) delete current_obj;
        current_obj = new QList<MLItem*>();
        std::vector<medialibrary::ArtistPtr> a = ml->artists(current_sort, is_desc);
        for ( int i=0 ; i<a.size() ; i++ )
        {
            MLArtist* item = new MLArtist( a[i] );
            artists->append( item );
            current_obj->append( item );
        }
    }
    endResetModel();
}

void MCMediaLib::retrieveGenres( medialibrary::SortingCriteria sort, bool desc )
{
    beginResetModel();
    {
        if (genres) delete genres;
        genres = new QList<MLGenre*>();
//        if (current_obj != NULL) delete current_obj;
        current_obj = new QList<MLItem*>();
        std::vector<medialibrary::GenrePtr> g = ml->genres(current_sort, is_desc);
        for ( int i=0 ; i<g.size() ; i++ )
        {
            MLGenre* item = new MLGenre( g[i] );
            genres->append( item );
            current_obj->append( item );
        }
    }
    endResetModel();
}

void MCMediaLib::retrieveTracks( medialibrary::SortingCriteria sort, bool desc )
{
    beginResetModel();
    {
        if (tracks) delete tracks;
        tracks = new QList<MLAlbum*>();
//        if (current_obj) delete current_obj;
        current_obj = new QList<MLItem*>();
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
//        if (current_obj != NULL) delete current_obj;
        current_obj = new QList<MLItem*>();
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
//        if (current_obj != NULL) delete current_obj;
        current_obj = new QList<MLItem*>();
/* NOT IMPLEMENTED YET IN API
 *        std::vector<SeriesPtr> s = ml->series(sort, desc);
 *        for ( int i=0 ; i<s.size() ; i++ )
 *            series->append( new MLAlbum( s[i] ) );
 */
    }
    endResetModel();
}

void MCMediaLib::invokeQML( const char* func ) {
    QQuickItem *root = qmlItem->rootObject();
    int methodIndex = root->metaObject()->indexOfMethod(func);
    QMetaMethod method = root->metaObject()->method(methodIndex);
    method.invoke(root);
}
