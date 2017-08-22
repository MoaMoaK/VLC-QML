#ifndef SOURCECAT_HPP
#define SOURCECAT_HPP


class SourceCat
{
    Q_OBJECT
    Q_PROPERTY(QString name READ getName WRITE setName)

private:


public:
    SourceCat();
};

#endif // SOURCECAT_HPP
