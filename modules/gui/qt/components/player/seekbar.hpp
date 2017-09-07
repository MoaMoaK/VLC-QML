#ifndef SEEKBAR_HPP
#define SEEKBAR_HPP

#include <QObject>

class SeekBar : public QObject
{
    Q_OBJECT
public:
    explicit SeekBar(QObject *parent = nullptr);

signals:

public slots:
};

#endif // SEEKBAR_HPP