#include "card.h"

Card::Card()
{
    mColor = Color::COLOR_END;
    mValue = Value::VALUE_END;
    mPoint = 0;
    mIsPlayable = false;
    mColorBackground = ColorBackground::BLUE;
    setColorBackground(mColorBackground);


}

Card::Card(Color c, Value v, int p, QObject *parent) : QObject(parent)
{
    mColor = c;
    mValue = v;
    mPoint = p;
    mIsPlayable = true;
    mImage = QString(":/images/cards/%1%2.png").arg(v,2,10,QLatin1Char('0')).arg(c);

}

QPixmap Card::image() const
{
    QPixmap pix;
    pix.load (mImage);
    return pix;
}

QString Card::imagePath() const
{
    return mImage;
}

QString Card::print()
{
    QString colorOfCard;
    switch (mColor) {
    case Color::BLACK_CLUBS:
        colorOfCard = "BLACK CLUBS";
        break;
    case Color::BLACK_SPADE:
        colorOfCard = "BLACK SPADE";
        break;
    case Color::RED_HEART:
        colorOfCard = "RED HEART";
        break;
    case Color::RED_DIAMOND:
        colorOfCard = "RED DIAMOND";
        break;
    default:
        colorOfCard = "UNKNOW";
    }
    return QString("Detail of the card. Color %1 | Value %2").arg(colorOfCard).arg(mValue);
}

Color Card::color() const
{
    return mColor;
}

void Card::setColor(Color newColor)
{
    mColor = newColor;
}

Value Card::value() const
{
    return mValue;
}

void Card::setValue(Value newValue)
{
    mValue = newValue;
}

int Card::point() const
{
    return mPoint;
}

void Card::setPoint(int newPoint)
{
    mPoint = newPoint;
}

bool Card::isPlayable() const
{
    return mIsPlayable;
}

void Card::setIsPlayable(bool newIsPlayable)
{
    mIsPlayable = newIsPlayable;
}

void Card::setColorBackground(ColorBackground newColorBackground)
{
    mColorBackground = newColorBackground;
    switch (mColorBackground) {
    case ColorBackground::BLUE:
        mImage = ":/images/cards/back_blue.png";
        break;
    case ColorBackground::GRAY:
        mImage = ":/images/cards/back_gray.png";
        break;
    case ColorBackground::GREEN:
        mImage = ":/images/cards/back_green.png";
        break;
    case ColorBackground::PURPLE:
        mImage = ":/images/cards/back_purple.png";
        break;
    case ColorBackground::RED:
        mImage = ":/images/cards/back_red.png";
        break;
    case ColorBackground::YELLOW:
        mImage = ":/images/cards/back_yellow.png";
        break;
    }


}
