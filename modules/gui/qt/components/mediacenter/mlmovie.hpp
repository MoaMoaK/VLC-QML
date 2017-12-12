#ifndef MLMOVIE_HPP
#define MLMOVIE_HPP

#include <qt5/QtCore/QString>
#include <medialibrary/Types.h>

class MLMovie
{
public:
    MLMovie( medialibrary::AlbumPtr data );

    QString getTitle() { return QString(""); }
    QString getDuration() { return QString(""); }
    QString getCover() { return QString(""); }
};

#endif // MLMOVIE_HPP
