#ifndef MLTRACK_HPP
#define MLTRACK_HPP

#include <qt5/QtCore/QObject>
#include <qt5/QtCore/QString>
#include <medialibrary/IMedia.h>
#include <medialibrary/IAlbumTrack.h>
#include <medialibrary/Types.h>

#include "mlitem.hpp"

class MLAlbumTrack : public MLItem
{
    Q_OBJECT

public:
    explicit MLAlbumTrack(QObject *parent = nullptr);
    MLAlbumTrack( medialibrary::MediaPtr data, QObject *parent = nullptr);

    Q_INVOKABLE QString getTitle() const;
    Q_INVOKABLE QString getTrackNumber() const;
    Q_INVOKABLE QString getDuration() const;

    Q_INVOKABLE QString getPresName() const;

private:
    QString title;
    unsigned int trackNumber;
    int64_t duration;

signals:

public slots:
};

#endif // MLTRACK_HPP
