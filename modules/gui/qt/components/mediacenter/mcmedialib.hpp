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
#include <qt5/QtQml/QQmlEngine>

#include "qt.hpp"
#include "input_manager.hpp"
#include "mlalbum.hpp"
#include "mlmovie.hpp"
#include "mlserie.hpp"
#include "mlgenre.hpp"
#include "mlartist.hpp"
#include "components/utils/mlitemmodel.hpp"

#include "components/playlist/plitem.hpp"
#include "components/playlist/plmodel.hpp"

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

class MCMediaLib : public QObject
{
    Q_OBJECT

public:
    MCMediaLib(
        intf_thread_t *_p_intf,
        QQuickWidget* _qml_item,
        PLModel* _pl_model,
        QObject *parent = nullptr
    );

    Q_INVOKABLE QVariant hasPresentation();
    Q_INVOKABLE void backPresentation();
    Q_INVOKABLE QVariant getCategory();
    Q_INVOKABLE QVariant getObjects();
    Q_INVOKABLE QVariant isGridView();
    Q_INVOKABLE void toogleView();
    Q_INVOKABLE QVariant isNightMode();
    Q_INVOKABLE void toogleNightMode();
    Q_INVOKABLE void select(const int &item_id);
    Q_INVOKABLE void addToPlaylist(const int &item_id);
    Q_INVOKABLE QVariant getPresObject();
    Q_INVOKABLE void selectSource(const QString &name );
    Q_INVOKABLE void sort(const QString &criteria );

private:
    void retrieveAlbums();
    void retrieveArtists();
    void retrieveGenres();
    void retrieveTracks();
    void retrieveMovies();
    void retrieveSeries();

    intf_thread_t *p_intf;
    QQuickWidget *qmlItem;
    PLModel* pl_model;

    bool m_gridView;

    QList<MLAlbum*> *albums;
    QList<MLArtist*> *artists;
    QList<MLGenre*> *genres;
    QList<MLAlbumTrack*> *tracks;
    QList<MLMovie*> *videos;
    QList<MLSerie*> *networks;
    MCMediaLibCategory current_cat;
    MCMediaLibCategory old_cat;
    medialibrary::SortingCriteria current_sort;
    bool is_desc;
    bool is_night_mode;
    QList<MLItem*> *current_obj;
    MLItem *current_main_obj;

    /* Medialibrary */
    medialibrary::IMediaLibrary* ml;
    medialibrary::ExCallback* cb;

    void sortCurrent();

    void invokeQML(const char *func );
};


#endif // MC_MEDIALIB_HPP
