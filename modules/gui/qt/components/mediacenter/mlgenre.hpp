#ifndef MLGENRE_HPP
#define MLGENRE_HPP

#include <qt5/QtCore/QObject>
#include <qt5/QtCore/QString>
#include <qt5/QtCore/QList>
#include <medialibrary/IGenre.h>
#include <medialibrary/IArtist.h>
#include <medialibrary/IAlbum.h>
#include <medialibrary/IAlbumTrack.h>
#include <medialibrary/Types.h>

#include "mlartist.hpp"
#include "mlalbum.hpp"
#include "mlalbumtrack.hpp"
#include "mlitem.hpp"
#include "components/utils/mlitemmodel.hpp"

class MLGenre : public MLItem
{
    Q_OBJECT

public:
    MLGenre( medialibrary::GenrePtr data, QObject *parent = nullptr);

    Q_INVOKABLE QString getId() const;
    Q_INVOKABLE QString getName() const;
    Q_INVOKABLE QString getNbTracks() const;
    Q_INVOKABLE MLItemModel* getArtists() const;
    Q_INVOKABLE MLItemModel* getTracks() const;
    Q_INVOKABLE MLItemModel* getAlbums() const;

    Q_INVOKABLE QString getPresName() const;
    Q_INVOKABLE QString getPresImage() const;
    Q_INVOKABLE QString getPresInfo() const;
    QList<MLItem* > *getDetailsObjects();

private:
    int64_t id;
    QString name;
    uint32_t nbTracks;
    QList<MLItem*> artists;
    QList<MLItem*> tracks;
    QList<MLItem*> albums;

};

#endif // MLGENRE_HPP
