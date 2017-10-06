#include "video_overlay.hpp"

VideoOverlay::VideoOverlay(QWidget *parent) : QWidget(parent),
    video( NULL ), main_layout( new QHBoxLayout() )
{
    main_layout->setMargin(0);
    setLayout(main_layout);
    resizeToFitVideo();
    updatePosition();

}

VideoWidget* VideoOverlay::getVideo() {
    return video;
}

void VideoOverlay::setVideo( VideoWidget* v ) {
    video = v;
    if (video)
        main_layout->addWidget(video);
    resizeToFitVideo();
    updatePosition();
    CONNECT(video, sizeChanged(int, int), this, resizeToFitVideo());
}

void VideoOverlay::resizeToFitVideo() {
    if (video)
    {
        QSize max_size(300, 200);
        if ( video->width() / max_size.width() < video->height() / max_size.height() )
            resize( max_size.width(), max_size.width() * video->height() / video->width() );
        else
            resize( max_size.height() * video->width() / video->height(), max_size.height() );
    }
    else
        resize(0,0);
}

void VideoOverlay::updatePosition() {
    if (video)
        move(20, parentWidget()->height() - this->height() - 20);
    else
        move(0,0);
}

