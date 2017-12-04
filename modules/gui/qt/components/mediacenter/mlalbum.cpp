#include "mlalbum.hpp"

MLAlbum::MLAlbum(medialibrary::AlbumPtr _data , QObject *parent) : MLItem(parent)
{
    data = _data;
    id = _data->id();
    title = QString( _data->title().c_str() );
    releaseYear = _data->releaseYear();
    shortSummary = QString( _data->shortSummary().c_str() );
    cover = QString( _data->artworkMrl().c_str() );
    tracks = QList<MLItem*>();
    std::vector<medialibrary::MediaPtr> t = _data->tracks();
    for (int i=0 ; i<t.size() ; i++ )
        tracks.append( new MLAlbumTrack( t[i] ) );
    mainArtist = QString( _data->albumArtist()->name().c_str() );
    otherArtists = QList<QString>();
    std::vector<medialibrary::ArtistPtr> a = _data->artists( false );
    for (int i=0 ; i<a.size() ; i++ )
        otherArtists.append( QString( a[i]->name().c_str() ) );
    nbTracks = _data->nbTracks();
    duration = _data->duration();
}

QString MLAlbum::getId() const
{
    return QString( std::to_string(id).c_str() );
}

QString MLAlbum::getTitle() const
{
    return title;
}

QString MLAlbum::getReleaseYear() const
{
    return QString( std::to_string(releaseYear).c_str() );
}

QString MLAlbum::getShortSummary() const
{
    return shortSummary;
}

QString MLAlbum::getCover() const
{
    return cover;
}

MLItemModel* MLAlbum::getTracks() const
{
    return new MLItemModel( &tracks );
}

QString MLAlbum::getArtist() const
{
    return mainArtist;
}

QList<QString> MLAlbum::getArtists() const
{
    return otherArtists;
}

QString MLAlbum::getNbTracks() const
{
    return QString( std::to_string(nbTracks).c_str() );
}

QString MLAlbum::getDuration() const
{
    unsigned int sec = duration / 1000;
    unsigned int min = sec / 60;
    unsigned int hour = min / 60;
    QString sec_disp = QString( std::to_string( sec - min * 60 ).c_str() );
    QString min_disp = QString( std::to_string( min - hour * 60 ).c_str() );
    QString hour_disp = QString( std::to_string( hour ).c_str() );

    if ( hour > 0 )
        return hour_disp + ":" + min_disp + ":" + sec_disp;
    else
        return min_disp + ":" + sec_disp;
}

QString MLAlbum::getPresName() const
{
    return title;
}

QString MLAlbum::getPresImage() const
{
    return cover;
}

QString MLAlbum::getPresInfo() const
{
    return shortSummary;
}

QList<MLAlbumTrack*>* MLAlbum::getPLTracks() const
{
    QList<MLAlbumTrack*>* result = new QList<MLAlbumTrack*>();
    std::vector<medialibrary::MediaPtr> t = data->tracks();
    for (int i=0 ; i<t.size() ; i++ )
        result->append( new MLAlbumTrack( t[i] ) );
    return result;
}

QList<MLItem *> *MLAlbum::getDetailsObjects(medialibrary::SortingCriteria sort, bool desc)
{
    QList<MLItem *> *result = new QList<MLItem *>();
    std::vector<medialibrary::MediaPtr> t = data->tracks(sort, desc);
    for (int i=0 ; i<t.size() ; i++ )
        result->append( new MLAlbumTrack( t[i] ) );
    return result;
}
