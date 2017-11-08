#include "mlgenre.hpp"


MLGenre::MLGenre( medialibrary::GenrePtr data, QObject *parent ) : MLItem(parent)
{
    id = data->id();
    name = QString( data->name().c_str() );
    nbTracks = data->nbTracks();
    artists = QList<MLItem*>();
    std::vector<medialibrary::ArtistPtr> a = data->artists();
    for (int i=0 ; i<a.size() ; i++ )
        artists.append( new MLArtist( a[i] ) );
    tracks = QList<MLItem*>();
    std::vector<medialibrary::MediaPtr> t = data->tracks();
    for (int i=0 ; i<t.size() ; i++ )
        tracks.append( new MLAlbumTrack( t[i] ) );
    albums = QList<MLItem*>();
    std::vector<medialibrary::AlbumPtr> a2 = data->albums();
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

QList<MLItem* > *MLGenre::getDetailsObjects()
{
    return &albums;
}

