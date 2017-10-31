#ifndef MC_MEDIALIB_HPP
#define MC_MEDIALIB_HPP


#include <qt5/QtCore/Qt>
#include <qt5/QtCore/QAbstractListModel>
#include <qt5/QtCore/QVariant>
#include <qt5/QtCore/QHash>
#include <qt5/QtCore/QByteArray>
#include <qt5/QtCore/QList>
#include <qt5/QtQuickWidgets/QQuickWidget>
#include <qt5/QtQuick/QQuickItem>
#include <qt5/QtCore/QMetaObject>
#include <qt5/QtCore/QMetaMethod>

#include "qt.hpp"
#include "input_manager.hpp"
#include "mlalbum.hpp"
#include "mlmovie.hpp"
#include "mlserie.hpp"
#include "mlartist.hpp"

#include <medialibrary/IMediaLibrary.h>
#include <medialibrary/IAlbum.h>
#include <medialibrary/Types.h>
#include "excallback.hpp"

enum MCMediaLibRoles {
    GET_ID = Qt::UserRole + 1,
    GET_TITLE,
    GET_RELEASE_YEAR,
    GET_SHORT_SUMMARY,
    GET_COVER,
    GET_TRACKS,
    GET_ARTIST,
    GET_NB_TRACKS,
    GET_DURATION,
    GET_ALBUM,
    GET_NAME,
    GET_SHORT_BIO,
    GET_ALBUMS,
    GET_NB_ALBUMS
};

enum MCMediaLibCategory {
    CAT_MUSIC_ALBUM,
    CAT_MUSIC_ARTIST,
    CAT_MUSIC_GENRE,
    CAT_MUSIC_TRACKS,
    CAT_VIDEO,
    CAT_NETWORK
};

enum MCMediaLibView {
    VIEW_NOVIEW,
    VIEW_MUSIC,
    VIEW_MUSIC_ALBUMS,
    VIEW_MUSIC_ARTISTS,
    VIEW_MUSIC_GENRES,
    VIEW_MUSIC_TRACKS,
    VIEW_VIDEO,
    VIEW_VIDEO_TVSHOWS,
    VIEW_VIDEO_SEASONS,
    VIEW_VIDEO_TRACKS,
    VIEW_NETWORK,
    VIEW_PLAYLITS,
    VIEW_BROWSER
};

class MCMediaLib : public QAbstractListModel
{
    Q_OBJECT

public:
    MCMediaLib(intf_thread_t *_p_intf, QQuickWidget* _qml_item, QObject *parent = nullptr);

    /* Subclassing QAbstractListModel */
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    bool setData( const QModelIndex &index, const QVariant & value, int role = Qt::EditRole ) override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const;

    void update();

    Q_INVOKABLE QVariant hasPresentation();
    Q_INVOKABLE QVariant getCategory();
    Q_INVOKABLE QVariant getObjects();
    Q_INVOKABLE QVariant isGridView();
    Q_INVOKABLE void toogleView();
    Q_INVOKABLE void select(const int &item_id);
    Q_INVOKABLE QVariant getPresObject();
    Q_INVOKABLE void selectSource(const QString &name );
    Q_INVOKABLE void sort(const QString &criteria );

private:
    MLAlbum* getAlbumItem(const QModelIndex &index ) const;
    MLArtist* getArtistItem(const QModelIndex &index ) const;
    MLAlbum* getGenreItem(const QModelIndex &index ) const;
    MLAlbum* getTrackItem(const QModelIndex &index ) const;
    MLMovie* getMovieItem(const QModelIndex &index ) const;
    MLSerie* getSerieItem(const QModelIndex &index ) const;

    void retrieveAlbums(medialibrary::SortingCriteria sort = medialibrary::SortingCriteria::Default, bool desc = false);
    void retrieveArtists(medialibrary::SortingCriteria sort = medialibrary::SortingCriteria::Default, bool desc = false);
    void retrieveGenres(medialibrary::SortingCriteria sort = medialibrary::SortingCriteria::Default, bool desc = false);
    void retrieveTracks(medialibrary::SortingCriteria sort = medialibrary::SortingCriteria::Default, bool desc = false);
    void retrieveMovies(medialibrary::SortingCriteria sort = medialibrary::SortingCriteria::Default, bool desc = false);
    void retrieveSeries(medialibrary::SortingCriteria sort = medialibrary::SortingCriteria::Default, bool desc = false);

    intf_thread_t *p_intf;
    QQuickWidget *qmlItem;

    bool m_gridView;

    QList<MLAlbum*> *albums;
    QList<MLArtist*> *artists;
    QList<MLAlbum*> *genres;
    QList<MLAlbum*> *tracks;
    QList<MLMovie*> *videos;
    QList<MLSerie*> *networks;
    MCMediaLibCategory current_cat;
    medialibrary::SortingCriteria current_sort;
    bool is_desc;
    QList<QObject*> *current_obj;
    QObject *current_main_obj;

    /* Medialibrary */
    medialibrary::IMediaLibrary* ml;
    medialibrary::ExCallback* cb;

    void sortCurrent(medialibrary::SortingCriteria sort = medialibrary::SortingCriteria::Default, bool desc = false);

    void invokeQML(const char *func );
};


#endif // MC_MEDIALIB_HPP
