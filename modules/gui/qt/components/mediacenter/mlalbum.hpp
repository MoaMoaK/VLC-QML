#ifndef MLALBUM_HPP
#define MLALBUM_HPP

#include <qt5/QtCore/QObject>
#include <qt5/QtCore/QString>
#include <qt5/QtCore/QList>
#include <medialibrary/IAlbum.h>
#include <medialibrary/IArtist.h>
#include <medialibrary/Types.h>

#include "mlalbumtrack.hpp"
#include "mlitem.hpp"

class MLAlbum : public MLItem
{
    Q_OBJECT

public:
    MLAlbum( medialibrary::AlbumPtr data, QObject *parent = nullptr);

    Q_INVOKABLE QString getId() const;
    Q_INVOKABLE QString getTitle() const;
    Q_INVOKABLE QString getReleaseYear() const;
    Q_INVOKABLE QString getShortSummary() const;
    Q_INVOKABLE QString getCover() const;
    Q_INVOKABLE QList<QObject*> getTracks() const;
    Q_INVOKABLE QString getArtist() const;
    Q_INVOKABLE QList<QString> getArtists() const;
    Q_INVOKABLE QString getNbTracks() const;
    Q_INVOKABLE QString getDuration() const;

    Q_INVOKABLE QString getPresName() const;
    Q_INVOKABLE QString getPresImage() const;
    Q_INVOKABLE QString getPresInfo() const;

private:
    int64_t m_id;
    QString title;
    unsigned int releaseYear;
    QString shortSummary;
    QString cover;
    QList<QObject*> tracks;
    QString mainArtist;
    QList<QString> otherArtists;
    uint32_t nbTracks;
    unsigned int duration;
};

#endif // MLALBUM_HPP
