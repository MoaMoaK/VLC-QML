#ifndef MLTRACK_HPP
#define MLTRACK_HPP

#include <qt5/QtCore/QObject>
#include <qt5/QtCore/QString>
#include <medialibrary/IMedia.h>
#include <medialibrary/IAlbumTrack.h>
#include <medialibrary/IAlbum.h>
#include <medialibrary/Types.h>

#include "mlitem.hpp"
#include "components/utils/mlitemmodel.hpp"

class MLAlbumTrack : public MLItem
{
    Q_OBJECT

public:
    explicit MLAlbumTrack(QObject *parent = nullptr);
    MLAlbumTrack( medialibrary::MediaPtr _data, QObject *parent = nullptr);

    Q_INVOKABLE QString getTitle() const;
    Q_INVOKABLE QString getCover() const;
    Q_INVOKABLE QString getTrackNumber() const;
    Q_INVOKABLE QString getDuration() const;

    Q_INVOKABLE QString getPresName() const;
    Q_INVOKABLE QString getPresImage() const;
    Q_INVOKABLE QString getPresInfo() const;
    QList<MLItem *> *getDetailsObjects(medialibrary::SortingCriteria sort = medialibrary::SortingCriteria::Default, bool desc = false);

private:
    QString title;
    QString cover;
    unsigned int trackNumber;
    int64_t duration;

    medialibrary::MediaPtr data;

signals:

public slots:
};

#endif // MLTRACK_HPP
