#ifndef MC_MEDIALIB_HPP
#define MC_MEDIALIB_HPP


#include <qt5/QtCore/Qt>
#include <qt5/QtCore/QAbstractListModel>
#include <qt5/QtCore/QVariant>
#include <qt5/QtCore/QHash>
#include <qt5/QtCore/QByteArray>
#include <qt5/QtCore/QList>

#include "qt.hpp"
#include "input_manager.hpp"
#include "mlalbum.hpp"
#include "mlmovie.hpp"
#include "mlserie.hpp"

#include <medialibrary/IMediaLibrary.h>
#include <medialibrary/IAlbum.h>
#include <medialibrary/Types.h>
#include "excallback.hpp"

enum MCMediaLibRoles {
    SET_ALBUMS = Qt::UserRole + 1,
    SET_MOVIES,
    SET_SERIES,
    TITLE,
    COVER,
    DURATION
};

enum MCMediaLibCategory {
    ALBUMS,
    MOVIE,
    SERIE
};

class MCMediaLib : public QAbstractListModel
{
    Q_OBJECT

public:
    MCMediaLib(intf_thread_t *_p_intf, QObject *parent = nullptr);

    /* Subclassing QAbstractListModel */
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    bool setData( const QModelIndex &index, const QVariant & value, int role = Qt::EditRole ) override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const;

private:
    MLAlbum* getAlbumItem(const QModelIndex &index ) const;
    MLMovie* getMovieItem(const QModelIndex &index ) const;
    MLSerie* getSerieItem(const QModelIndex &index ) const;

    void retrieveAlbums();
    void retrieveMovies();
    void retrieveSeries();

    intf_thread_t *p_intf;
    QList<MLAlbum*> *albums;
    QList<MLMovie*> *movies;
    QList<MLSerie*> *series;
    MCMediaLibCategory *current_cat;

    /* Medialibrary */
    medialibrary::IMediaLibrary* ml;
    medialibrary::ExCallback* cb;

};


#endif // MC_MEDIALIB_HPP
