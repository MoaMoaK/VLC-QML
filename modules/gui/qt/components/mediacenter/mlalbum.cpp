#include "mlalbum.hpp"

MLAlbum::MLAlbum(medialibrary::AlbumPtr data , QObject *parent) : MLItem(parent)
{
    m_id         =          data->id()                    ;
    title        = QString( data->title().c_str()        );
    releaseYear  =          data->releaseYear()           ;
    shortSummary = QString( data->shortSummary().c_str() );
    cover        = QString( data->artworkMrl().c_str()   );
    tracks       = QList<QObject*>();
    std::vector<medialibrary::MediaPtr> t = data->tracks();
    for (int i=0 ; i<t.size() ; i++ )
        tracks.append( new MLAlbumTrack( t[i] ) );
    mainArtist       = QString( data->albumArtist()->name().c_str() );
    otherArtists     = QList<QString>();
    std::vector<medialibrary::ArtistPtr> a = data->artists( false );
    for (int i=0 ; i<a.size() ; i++ )
        otherArtists.append( QString( a[i]->name().c_str() ) );
    nbTracks     =          data->nbTracks()              ;
    duration     =          data->duration()              ;
}

QString MLAlbum::getId() const
{
    return QString( std::to_string(m_id).c_str() );
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

QList<QObject*> MLAlbum::getTracks() const
{
    return tracks;
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
