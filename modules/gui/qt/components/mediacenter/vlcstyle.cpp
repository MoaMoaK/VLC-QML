#include "vlcstyle.hpp"

VLCStyle::VLCStyle() : QQmlPropertyMap()
{
#define prop(name,value) insert(name, QVariant(value))
    prop("margin_xsmall", 8);
    prop("margin_small", 12);
    prop("margin_normal", 16);
    prop("margin_large", 24);
    prop("margin_xlarge", 32);

    prop("fontSize_xsmall", 8);
    prop("fontSize_small", 10);
    prop("fontSize_normal", 12);
    prop("fontSize_large", 14);
    prop("fontSize_xlarge", 16);

    prop("heightAlbumCover_xsmall", 32);
    prop("heightAlbumCover_small", 64);
    prop("heightAlbumCover_normal", 128);
    prop("heightAlbumCover_large", 256);
    prop("heightAlbumCover_xlarge", 512);

    prop("icon_xsmall", 8);
    prop("icon_small", 16);
    prop("icon_normal", 32);
    prop("icon_large", 64);
    prop("icon_xlarge", 128);

    prop("cover_xsmall", 64);
    prop("cover_small", 96);
    prop("cover_normal", 128);
    prop("cover_large", 160);
    prop("cover_xlarge", 192);

    prop("heightBar_xsmall", 8);
    prop("heightBar_small", 46);
    prop("heightBar_normal", 32);
    prop("heightBar_large", 64);
    prop("heightBar_xlarge", 128);

    prop("bgColor_daymode", "#FFFFFF");
    prop("bgColor_nightmode", "#000000");
    prop("hoverBgColor_daymode", "#F0F0F0");
    prop("hoverBgColor_nightmode", "#0F0F0F");
    prop("textColor_daymode", "#000000");
    prop("textColor_nightmode", "#FFFFFF");
    prop("bannerColor_daymode", "#e6e6e6");
    prop("bannerColor_nightmode", "#191919");
    prop("hoverBannerColor_daymode", "#d6d6d6");
    prop("hoverBannerColor_nightmode", "#292929");
#undef prop
}
