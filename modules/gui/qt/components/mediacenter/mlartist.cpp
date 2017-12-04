#include "mlartist.hpp"

MLArtist::MLArtist(medialibrary::ArtistPtr _data, QObject *parent) : MLItem(parent)
{
    data = _data;
    id = _data->id();
    name = QString( _data->name().c_str() );
    shortBio = QString( _data->shortBio().c_str() );
    albums = QList<MLItem*>();
    std::vector<medialibrary::AlbumPtr> a = _data->albums();
    for (int i=0 ; i<a.size() ; i++)
        albums.append( new MLAlbum( a[i]) );
    cover = QString( _data->artworkMrl().c_str() );
}

QString MLArtist::getId() const
{
    return QString( std::to_string(id).c_str() );
}

QString MLArtist::getName() const
{
    return name;
}

QString MLArtist::getShortBio() const
{
    return shortBio;
}

MLItemModel* MLArtist::getAlbums() const
{
    return new MLItemModel( &albums );
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

QList<MLAlbumTrack*>* MLArtist::getPLTracks() const
{
    QList<MLAlbumTrack*>* result = new QList<MLAlbumTrack*>();
    std::vector<medialibrary::MediaPtr> t = data->media();
    for (int i=0 ; i<t.size() ; i++ )
        result->append( new MLAlbumTrack( t[i] ) );
    return result;
}

QList<MLItem *> *MLArtist::getDetailsObjects(medialibrary::SortingCriteria sort, bool desc)
{
    QList<MLItem *> *result = new QList<MLItem *>();
    std::vector<medialibrary::AlbumPtr> t = data->albums(sort, desc);
    for (int i=0 ; i<t.size() ; i++ )
        result->append( new MLAlbum( t[i] ) );
    return result;
}

