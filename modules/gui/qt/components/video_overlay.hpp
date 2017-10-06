#ifndef VIDEOOVERLAY_HPP
#define VIDEOOVERLAY_HPP

#include <qt5/QtWidgets/QWidget>

#include "components/interface_widgets.hpp"


class VideoOverlay : public QWidget
{
    Q_OBJECT
public:
    VideoOverlay(QWidget *parent = nullptr);

    VideoWidget* getVideo();
    void setVideo( VideoWidget* v );
    void resizeToFitVideo();
    void updatePosition();

private:
    QHBoxLayout *main_layout;
    VideoWidget *video;
};

#endif // VIDEOOVERLAY_HPP
