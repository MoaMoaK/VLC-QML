#ifndef MLARTIST_HPP
#define MLARTIST_HPP

#include <qt5/QtCore/QObject>
#include <qt5/QtCore/QString>
#include <qt5/QtCore/QList>
#include <medialibrary/IAlbum.h>
#include <medialibrary/IArtist.h>
#include <medialibrary/Types.h>

#include "mlalbum.hpp"
#include "mlitem.hpp"

class MLArtist : public MLItem
{
    Q_OBJECT
public:
    MLArtist(medialibrary::ArtistPtr data, QObject *parent = nullptr);

    Q_INVOKABLE QString getId() const;
    Q_INVOKABLE QString getName() const;
    Q_INVOKABLE QString getShortBio() const;
    Q_INVOKABLE QList<QObject*> getAlbums() const;
    Q_INVOKABLE QString getCover() const;
    Q_INVOKABLE QString getNbAlbums() const;

    Q_INVOKABLE QString getPresName() const;

private:
    int64_t m_id;
    QString name;
    QString shortBio;
    QList<QObject*> albums;
    QString cover;
};

#endif // MLARTIST_HPP
