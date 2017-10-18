#include "mlalbum.hpp"

MLAlbum::MLAlbum( medialibrary::AlbumPtr data )
{
    title = QString( data->title() );
    duration = QString( data->duration() );
    cover = QString( data->artworkURL() );
}
