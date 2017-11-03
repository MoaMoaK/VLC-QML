#include "mlalbumtrack.hpp"

MLAlbumTrack::MLAlbumTrack(QObject *parent) : MLItem(parent)
{
    title = nullptr;
    trackNumber = 0;
    duration = 0;
}

MLAlbumTrack::MLAlbumTrack( medialibrary::MediaPtr data, QObject *parent ):
    MLItem(parent)
{
    title = QString( data->title().c_str() );
    trackNumber = data->albumTrack()->trackNumber();
    duration = data->duration();
}

QString MLAlbumTrack::getTitle() const
{
    return title;
}

QString MLAlbumTrack::getTrackNumber() const
{
    return QString( std::to_string(trackNumber).c_str() );
}

QString MLAlbumTrack::getDuration() const
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

QString MLAlbumTrack::getPresName() const
{
    return title;
}

QString MLAlbumTrack::getPresImage() const
{
    return "qrc:///noart.png";
}

QString MLAlbumTrack::getPresInfo() const
{
    return "";
}
