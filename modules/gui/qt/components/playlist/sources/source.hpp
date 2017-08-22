#ifndef SOURCES_HPP
#define SOURCES_HPP


class Source
{
    Q_OBJECT
    Q_PROPERTY( QString name READ getName WRITE setName )

private:

public:
    Source( QString name );

};

#endif // SOURCES_HPP
