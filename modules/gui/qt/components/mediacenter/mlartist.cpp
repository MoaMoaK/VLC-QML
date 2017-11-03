#include "mlartist.hpp"

MLArtist::MLArtist(medialibrary::ArtistPtr data, QObject *parent) : MLItem(parent)
{
    m_id = data->id();
    name = QString( data->name().c_str() );
    shortBio = QString( data->shortBio().c_str() );
    albums = QList<QObject*>();
    std::vector<medialibrary::AlbumPtr> a = data->albums();
    for (int i=0 ; i<a.size() ; i++)
        albums.append( new MLAlbum( a[i]) );
    cover = QString( data->artworkMrl().c_str() );
}

QString MLArtist::getId() const
{
    return QString( std::to_string(m_id).c_str() );
}

QString MLArtist::getName() const
{
    return name;
}

QString MLArtist::getShortBio() const
{
    return shortBio;
}

QList<QObject*> MLArtist::getAlbums() const
{
    return albums;
}

QString MLArtist::getCover() const
{
    return cover;
}

QString MLArtist::getNbAlbums() const
{
    return QString( std::to_string( albums.count() ).c_str() );
}

QString MLArtist::getPresName() const
{
    return name;
}

QString MLArtist::getPresImage() const
{
    return cover;
}

QString MLArtist::getPresInfo() const
{
    return shortBio;
}

