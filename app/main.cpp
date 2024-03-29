#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "maketenglobal.h"
#include "models/game.h"
#include "models/card.h"


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    app.setApplicationName("Tens Solitaire");

    qmlRegisterType<Game>("MakeTen.Game", 1, 0, "Game");
    qmlRegisterType<Card>("MakeTen.Card", 1, 0, "Card");
    qRegisterMetaType<GameState>("GameState");
    qmlRegisterUncreatableType<GameStatusClass>("MakeTen.GameStatus", 1, 0, "GameState", "");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/views/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    return app.exec();
}
