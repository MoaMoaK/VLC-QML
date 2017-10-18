#include "mcmedialib.hpp"


#include <qt5/QtCore/QString>

#include <vlc_playlist.h>
#include <vlc_input_item.h>

MCMediaLib::MCMediaLib(intf_thread_t *_p_intf, QObject *parent)
    : QAbstractListModel(parent)
{
    p_intf = _p_intf;
    current_cat = MCMediaLibCategory::ALBUMS;

    ml = NewMediaLibrary();
    cb = new medialibrary::ExCallback();
    ml->initialize("/home/moamoak/vlc-bdd.db", "/home/moamoak/vlc-thumb", cb);
    ml->start();

    albums = NULL;
    movies = NULL;
    series = NULL;
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

    switch (current_cat) :
    {
    case MCMediaLibCategory::ALBUMS:
        return albums->count();
        break;

    case MCMediaLibCategory::MOVIE:
        return movies->count();
        break;

    case MCMediaLibCategory::SERIE:
        return series->count();
        break;

    default:
        return 0;
    }
}

bool MCMediaLib::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid())
        return false;

    switch (role)
    {
    case MCMediaLibRoles::SET_ALBUMS:
        if (!albums)
            retrieveAlbums();
        current_cat = MCMediaLibCategory::ALBUMS;
        return true;

    case MCMediaLibCategory::MOVIE:
        if (!movies)
            retrieveMovies();
        current_cat = MCMediaLibCategory::MOVIE;
        return true;

    case MCMediaLibCategory::SERIE:
        if (!series)
            retrieveSeries();
        current_cat = MCMediaLibCategory::SERIE;
        return true;
    }

}

QVariant MCMediaLib::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    switch (role)
    {
    case MCMediaLibRoles::TITLE :
        switch (current_cat) :
        {
        case MCMediaLibCategory::ALBUMS:
            MLAlbum* item = getAlbumItem( index );
            if (!item) return QVariant();
            return QVariant( item->title() );

        case MCMediaLibCategory::MOVIE:
            MLAlbum* item = getAlbumItem( index );
            if (!item) return QVariant();
            return QVariant( item->title() );

        case MCMediaLibCategory::SERIE:
            MLAlbum* item = getAlbumItem( index );
            if (!item) return QVariant();
            return QVariant( item->title() );

        default:
            return QVariant();
        }

    case MCMediaLibRoles::COVER :
        switch (current_cat) :
        {
        case MCMediaLibCategory::ALBUMS:
            MLAlbum* item = getAlbumItem( index );
            if (!item) return QVariant();
            return QVariant( item->cover() );

        case MCMediaLibCategory::MOVIE:
            MLAlbum* item = getAlbumItem( index );
            if (!item) return QVariant();
            return QVariant( item->cover() );

        case MCMediaLibCategory::SERIE:
            MLAlbum* item = getAlbumItem( index );
            if (!item) return QVariant();
            return QVariant( item->cover() );

        default:
            return QVariant();
        }

    case MCMediaLibRoles::DURATION :
        switch (current_cat) :
        {
        case MCMediaLibCategory::ALBUMS:
            MLAlbum* item = getAlbumItem( index );
            if (!item) return QVariant();
            return QVariant( item->duration() );

        case MCMediaLibCategory::MOVIE:
            MLAlbum* item = getAlbumItem( index );
            if (!item) return QVariant();
            return QVariant( item->duration() );

        case MCMediaLibCategory::SERIE:
            MLAlbum* item = getAlbumItem( index );
            if (!item) return QVariant();
            return QVariant( item->duration() );

        default:
            return QVariant();
        }

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
    roles[MCMediaLibRoles::SET_ALBUMS] = "set_audio";
    roles[MCMediaLibRoles::SET_MOVIES]= "set_movies";
    roles[MCMediaLibRoles::SET_SERIES] = "set_series";
    roles[MCMediaLibRoles::TITLE] = "title";
    roles[MCMediaLibRoles::COVER] = "cover";
    roles[MCMediaLibRoles::DURATION] = "duration";
    return roles;
}

MLAlbum* MCMediaLib::getAlbumItem( const QModelIndex & index ) const
{
    int r = index.row();
    if (index.isValid() && r >= 0 && r < rowCount())
        return albums->at(r);
    else
        return NULL;
}

MLMovie* MCMediaLib::getMovieItem( const QModelIndex & index ) const
{
    int r = index.row();
    if (index.isValid() && r >= 0 && r < rowCount())
        return movies->at(r);
    else
        return NULL;
}

MLSerie* MCMediaLib::getSerieItem( QModelIndex & index ) const
{
    int r = index.row();
    if (index.isValid() && r >= 0 && r < rowCount())
        return series->at(r);
    else
        return NULL;
}

void MCMediaLib::retrieveAlbums()
{
    std::vector<AlbumPtr> a = ml->albums();
    for ( int i=0 ; i<a.size() ; i++ )
        albums->append( new MLAlbum( a[i] ) );
}

void MCMediaLib::retrieveMovies()
{
/* Not implemented in API yet
 *    std::vector<MoviePtr> m = ml->movies();
 *    for ( int i=0 ; i<m.size() ; i++ )
 *        movies->append( new MLMovie( m[i] ) );
 */
}

void MCMediaLib::retrieveSeries()
{
/* Not implemented in API yet
 *    std::vector<SeriesPtr> s = ml->series();
 *    for ( int i=0 ; i<s.size() ; i++ )
 *        series->append( new MLAlbum( s[i] ) );
 */
}
