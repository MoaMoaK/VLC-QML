#ifndef MLAUDIO_HPP
#define MLAUDIO_HPP

#include <QString>
#include <medialibrary/IAlbum.h>
#include <medialibrary/Types.h>

class MLAlbum
{
public:
    MLAlbum(medialibrary::AlbumPtr data );

    QString title() { return title; }
    QString duration() { return duration; }
    QString cover() { return cover; }

private:
    QString title;
    QString duration;
    QString cover;
};

#endif // MLAUDIO_HPP
