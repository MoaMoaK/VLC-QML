#ifndef MLTRACK_HPP
#define MLTRACK_HPP

#include <qt5/QtCore/QObject>
#include <qt5/QtCore/QString>
#include <medialibrary/IMedia.h>
#include <medialibrary/IAlbumTrack.h>
#include <medialibrary/Types.h>

class MLAlbumTrack : public QObject
{
    Q_OBJECT

public:
    explicit MLAlbumTrack(QObject *parent = nullptr);
    MLAlbumTrack( medialibrary::MediaPtr data, QObject *parent = nullptr);

    Q_INVOKABLE QString getTitle() const;
    Q_INVOKABLE QString getTrackNumber() const;
    Q_INVOKABLE QString getDuration() const;

private:
    QString title;
    unsigned int trackNumber;
    int64_t duration;

signals:

public slots:
};

#endif // MLTRACK_HPP
