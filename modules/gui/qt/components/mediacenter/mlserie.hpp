#ifndef MLSERIE_HPP
#define MLSERIE_HPP

#include <qt5/QtCore/QString>
#include <medialibrary/Types.h>

class MLSerie
{
public:
    MLSerie( medialibrary::AlbumPtr data );

    QString getTitle() { return QString(""); }
    QString getDuration() { return QString(""); }
    QString getCover() { return QString(""); }
};

#endif // MLSERIE_HPP
