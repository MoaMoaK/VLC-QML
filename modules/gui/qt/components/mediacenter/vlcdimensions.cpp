#include "vlcdimensions.hpp"

VLCDimensions::VLCDimensions() : QQmlPropertyMap()
{
#define VLCDim(name,value) insert(name, QVariant(value))
    VLCDim("margin_xsmall", 8);
    VLCDim("margin_small", 12);
    VLCDim("margin_normal", 16);
    VLCDim("margin_large", 24);
    VLCDim("margin_xlarge", 32);

    VLCDim("fontSize_xsmall", 8);
    VLCDim("fontSize_small", 10);
    VLCDim("fontSize_normal", 12);
    VLCDim("fontSize_large", 14);
    VLCDim("fontSize_xlarge", 16);

    VLCDim("heightAlbumCover_xsmall", 32);
    VLCDim("heightAlbumCover_small", 64);
    VLCDim("heightAlbumCover_normal", 128);
    VLCDim("heightAlbumCover_large", 256);
    VLCDim("heightAlbumCover_xlarge", 512);

    VLCDim("icon_xsmall", 8);
    VLCDim("icon_small", 16);
    VLCDim("icon_normal", 32);
    VLCDim("icon_large", 64);
    VLCDim("icon_xlarge", 128);

    VLCDim("heightBar_xsmall", 8);
    VLCDim("heightBar_small", 46);
    VLCDim("heightBar_normal", 32);
    VLCDim("heightBar_large", 64);
    VLCDim("heightBar_xlarge", 128);
#undef VLCDim
}
