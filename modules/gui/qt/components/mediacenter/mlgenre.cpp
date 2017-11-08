#include "mlgenre.hpp"


MLGenre::MLGenre( medialibrary::GenrePtr _data, QObject *parent ) : MLItem(parent)
{
    data = _data;
    id = _data->id();
    name = QString( _data->name().c_str() );
    nbTracks = _data->nbTracks();
    artists = QList<MLItem*>();
    std::vector<medialibrary::ArtistPtr> a = _data->artists();
    for (int i=0 ; i<a.size() ; i++ )
        artists.append( new MLArtist( a[i] ) );
    tracks = QList<MLItem*>();
    std::vector<medialibrary::MediaPtr> t = _data->tracks();
    for (int i=0 ; i<t.size() ; i++ )
        tracks.append( new MLAlbumTrack( t[i] ) );
    albums = QList<MLItem*>();
    std::vector<medialibrary::AlbumPtr> a2 = _data->albums();
    for (int i=0 ; i<a2.size() ; i++ )
        albums.append( new MLAlbum( a2[i] ) );
}

QString MLGenre::getId() const
{
    return QString( std::to_string(id).c_str() );
}

QString MLGenre::getName() const
{
    return name;
}

QString MLGenre::getNbTracks() const
{
    return QString( std::to_string(nbTracks).c_str() );
}

MLItemModel* MLGenre::getArtists() const
{
    return new MLItemModel( &artists );
}

MLItemModel* MLGenre::getTracks() const
{
    return new MLItemModel( &tracks );
}

MLItemModel* MLGenre::getAlbums() const
{
    return new MLItemModel( &albums );
}

QString MLGenre::getPresName() const
{
    return name;
}

QString MLGenre::getPresImage() const
{
    return QString();
}

QString MLGenre::getPresInfo() const
{
    return QString();
}

QList<MLItem* > *MLGenre::getDetailsObjects(medialibrary::SortingCriteria sort, bool desc)
{
    QList<MLItem *> *result = new QList<MLItem *>();
    std::vector<medialibrary::AlbumPtr> t = data->albums(sort, desc);
    for (int i=0 ; i<t.size() ; i++ )
        result->append( new MLAlbum( t[i] ) );
    return result;
}

