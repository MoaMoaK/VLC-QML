#include "mcmedialib.hpp"


#include <qt5/QtCore/QString>

#include <vlc_playlist.h>
#include <vlc_input_item.h>

MCMediaLib::MCMediaLib(intf_thread_t *_p_intf, QQuickWidget *_qml_item, QObject *parent)
    : p_intf( _p_intf ),
      qmlItem( _qml_item ),
      current_cat ( CAT_MUSIC_ALBUM ),
      old_cat ( CAT_MUSIC_ALBUM ),
      current_sort( medialibrary::SortingCriteria::Default ),
      is_desc( false ),
      is_night_mode( true ),
      ml( NewMediaLibrary() ),
      cb( new medialibrary::ExCallback() ),
      m_gridView( true ),
      QObject(parent)
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

// Are we exploring a specific item or just browsing generic category
QVariant MCMediaLib::hasPresentation() {
    if (current_main_obj)
        return true;
    else
        return false;
}

// Remove presentation to get back to the list of items that were in place before
void MCMediaLib::backPresentation() {
    switch (old_cat)
    {
    case CAT_MUSIC_ALBUM:
    {
        current_cat = CAT_MUSIC_ALBUM;
        retrieveAlbums();
        if (current_main_obj) current_main_obj = NULL;
        break;
    }
    case CAT_MUSIC_ARTIST:
    {
        current_cat = CAT_MUSIC_ARTIST;
        retrieveArtists();
        if (current_main_obj) current_main_obj = NULL;
        break;
    }
    case CAT_MUSIC_GENRE:
    {
        current_cat = CAT_MUSIC_GENRE;
        retrieveGenres();
        if (current_main_obj) current_main_obj = NULL;
        break;
    }
    case CAT_MUSIC_TRACKS:
    {
        current_cat = CAT_MUSIC_TRACKS;
        retrieveTracks();
        if (current_main_obj) current_main_obj = NULL;
        break;
    }
    case CAT_VIDEO:
    {
        current_cat = CAT_VIDEO;
        retrieveMovies();
        if (current_main_obj) current_main_obj = NULL;
        break;
    }
    case CAT_NETWORK:
    {
        current_cat = CAT_NETWORK;
        retrieveSeries();
        if (current_main_obj) current_main_obj = NULL;
        break;
    }
    default:
        break;
    }
    invokeQML("reloadPresentation()");
    invokeQML("changedCategory()");
}

// Which category should be displayed
QVariant MCMediaLib::getCategory()
{
    return QVariant( current_cat );
}

// Get the list of items that should be displayed
QVariant MCMediaLib::getObjects()
{
    return QVariant::fromValue<MLItemModel*>( new MLItemModel(current_obj) );
}

// Should the items be displayed as a grid or as list ?
QVariant MCMediaLib::isGridView()
{
    return QVariant( m_gridView );
}

// Is the night mode activated
QVariant MCMediaLib::isNightMode()
{
    return QVariant( is_night_mode );
}

// Toogle between grid and list view for the displayed items
void MCMediaLib::toogleView()
{
    m_gridView = !m_gridView;
    invokeQML("changedView()");
}

// A specific item has been selected -> update the list of obejcts and the presentation
void MCMediaLib::select( const int &item_id )
{
    if (item_id >= 0 && item_id <= current_obj->count())
    {
        if (!current_main_obj)
            old_cat = current_cat;

        current_main_obj = current_obj->at(item_id);
        current_obj = current_main_obj->getDetailsObjects(current_sort, is_desc);
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
    invokeQML("changedCategory()");
}

// The object that should be presented in the presentation banner
QVariant MCMediaLib::getPresObject()
{
    if (current_main_obj)
        return QVariant::fromValue( current_main_obj );
    else
        return QVariant();
}

// When a source (or sub-source) is selected (Music / Music>Albums / Videos / ...)
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

// When a sort has been selected, we need to recalculate the model
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
    if (current_main_obj)
    {
        current_obj = current_main_obj->getDetailsObjects(current_sort, is_desc);
    }
    else
    {
        sortCurrent();
    }
    invokeQML("reloadData()");
}

// Recalculate the list of root objects that should be displayed according to the current category and sort
void MCMediaLib::sortCurrent()
{
    switch (current_cat)
    {
    case CAT_MUSIC_ALBUM:
        retrieveAlbums();
        break;
    case CAT_MUSIC_ARTIST:
        retrieveArtists();
        break;
    case CAT_MUSIC_GENRE:
        retrieveGenres();
        break;
    case CAT_MUSIC_TRACKS:
        retrieveTracks();
        break;
    case CAT_VIDEO:
        retrieveMovies();
        break;
    case CAT_NETWORK:
        retrieveSeries();
        break;
    default:
        break;
    }
}

// Retriever to fetch items in medialib : Recalculate a specific list of root objects
void MCMediaLib::retrieveAlbums()
{
    if (albums) delete albums;
    albums = new QList<MLAlbum*>();
//    if (current_obj != NULL) delete current_obj;
    current_obj = new QList<MLItem*>();
    std::vector<medialibrary::AlbumPtr> a = ml->albums(current_sort, is_desc);
    for ( int i=0 ; i<a.size() ; i++ )
    {
        MLAlbum* item = new MLAlbum( a[i] );
        albums->append( item );
        current_obj->append( item );
    }
}

void MCMediaLib::retrieveArtists()
{
    if (artists) delete artists;
    artists = new QList<MLArtist*>();
//    if (current_obj != NULL) delete current_obj;
    current_obj = new QList<MLItem*>();
    std::vector<medialibrary::ArtistPtr> a = ml->artists(current_sort, is_desc);
    for ( int i=0 ; i<a.size() ; i++ )
    {
        MLArtist* item = new MLArtist( a[i] );
        artists->append( item );
        current_obj->append( item );
    }
}

void MCMediaLib::retrieveGenres()
{
    if (genres) delete genres;
    genres = new QList<MLGenre*>();
//    if (current_obj != NULL) delete current_obj;
    current_obj = new QList<MLItem*>();
    std::vector<medialibrary::GenrePtr> g = ml->genres(current_sort, is_desc);
    for ( int i=0 ; i<g.size() ; i++ )
    {
        MLGenre* item = new MLGenre( g[i] );
        genres->append( item );
        current_obj->append( item );
    }
}

void MCMediaLib::retrieveTracks()
{
    if (tracks) delete tracks;
    tracks = new QList<MLAlbumTrack*>();
//    if (current_obj) delete current_obj;
    current_obj = new QList<MLItem*>();
    std::vector<medialibrary::MediaPtr> t = ml->audioFiles(current_sort, is_desc);
    for ( int i=0 ; i<t.size() ; i++ )
    {
        MLAlbumTrack* item = new MLAlbumTrack( t[i] );
        tracks->append( item );
        current_obj->append( item );
    }
}

void MCMediaLib::retrieveMovies()
{
    if (videos) delete videos;
    videos = new QList<MLMovie*>();
//    if (current_obj != NULL) delete current_obj;
    current_obj = new QList<MLItem*>();
/* NOT IMPLEMENTED YET IN API
 *    std::vector<MoviePtr> m = ml->movies(sort, desc);
 *    for ( int i=0 ; i<m.size() ; i++ )
 *        movies->append( new MLMovie( m[i] ) );
 */
}

void MCMediaLib::retrieveSeries()
{
    if (networks) delete networks;
    networks = new QList<MLSerie*>();
//    if (current_obj != NULL) delete current_obj;
    current_obj = new QList<MLItem*>();
/* NOT IMPLEMENTED YET IN API
 *    std::vector<SeriesPtr> s = ml->series(sort, desc);
 *    for ( int i=0 ; i<s.size() ; i++ )
 *        series->append( new MLAlbum( s[i] ) );
 */
}

// Invoke a given QML function (used to notify the view part of a change)
void MCMediaLib::invokeQML( const char* func ) {
    QQuickItem *root = qmlItem->rootObject();
    int methodIndex = root->metaObject()->indexOfMethod(func);
    QMetaMethod method = root->metaObject()->method(methodIndex);
    method.invoke(root);
}
