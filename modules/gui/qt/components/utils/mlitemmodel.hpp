#ifndef MLITEMMODEL_HPP
#define MLITEMMODEL_HPP

#include <qt5/QtCore/QAbstractListModel>
#include <qt5/QtCore/QVariant>
#include <qt5/QtCore/QHash>
#include <qt5/QtCore/QByteArray>
#include <qt5/QtCore/QObject>
#include <qt5/QtCore/QList>
#include <qt5/QtCore/QModelIndex>
#include <qt5/QtCore/Qt>

class MLItem;
class MLAlbum;
class MLArtist;
class MLGenre;

enum MLItemModelRoles {

    // Albums
    GET_ALBUM_ID = Qt::UserRole + 1,
    GET_ALBUM_TITLE,
    GET_ALBUM_RELEASE_YEAR,
    GET_ALBUM_SHORT_SUMMARY,
    GET_ALBUM_COVER,
    GET_ALBUM_TRACKS,
    GET_ALBUM_MAIN_ARTIST,
    GET_ALBUM_ARTISTS,
    GET_ALBUM_NB_TRACKS,
    GET_ALBUM_DURATION,

    // Artists
    GET_ARTIST_ID,
    GET_ARTIST_NAME,
    GET_ARTIST_SHORT_BIO,
    GET_ARTIST_ALBUMS,
    GET_ARTIST_COVER,
    GET_ARTIST_NB_ALBUMS,

    // Genres
    GET_GENRE_ID,
    GET_GENRE_NAME,
    GET_GENRE_NB_TRACKS,
    GET_GENRE_ARTISTS,
    GET_GENRE_TRACKS,
    GET_GENRE_ALBUMS,

    // Tracks
    GET_TRACK_TITLE,
    GET_TRACK_NUMBER,
    GET_TRACK_DURATION
};

class MLItemModel : public QAbstractListModel
{
    Q_OBJECT

public:
    MLItemModel(const QList<MLItem *> *item = NULL, QObject *parent = nullptr);
    MLItemModel(const MLItemModel &other );
    ~MLItemModel();

    MLItemModel& operator=(const MLItemModel& other);

    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

    QList<MLItem *> *getMLItemModel() const;

    Q_INVOKABLE QVariantMap get(int row);

private:
    MLItem* getItem(const QModelIndex &index) const;

    QList<MLItem *> *ml_item_list;
};

#endif // MLITEMMODEL_HPP
