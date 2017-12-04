#include "mlalbumtrack.hpp"

MLAlbumTrack::MLAlbumTrack(QObject *parent) : MLItem(parent)
{
    data = NULL;
    title = nullptr;
    trackNumber = 0;
    duration = 0;
    mrl = nullptr;
}

MLAlbumTrack::MLAlbumTrack(medialibrary::MediaPtr _data, QObject *parent ):
    MLItem(parent)
{
    data = _data;
    title = QString( _data->title().c_str() );
    if (_data->subType() == medialibrary::IMedia::SubType::AlbumTrack)
        cover = QString( _data->albumTrack()->album()->artworkMrl().c_str() );
    else
        cover = QString();
    trackNumber = _data->albumTrack()->trackNumber();
    duration = _data->duration();
    mrl = QString( _data->files()[0]->mrl().c_str() );
}

QString MLAlbumTrack::getTitle() const
{
    return title;
}

QString MLAlbumTrack::getCover() const
{
    return cover;
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

QString MLAlbumTrack::getMRL() const
{
    return mrl;
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

QList<MLAlbumTrack*>* MLAlbumTrack::getPLTracks() const
{
    QList<MLAlbumTrack*>* result = new QList<MLAlbumTrack*>();
    result->append( const_cast<MLAlbumTrack*>(this) );
    return result;
}

QList<MLItem *> *MLAlbumTrack::getDetailsObjects(medialibrary::SortingCriteria sort, bool desc)
{
    return new QList<MLItem *>();
}
