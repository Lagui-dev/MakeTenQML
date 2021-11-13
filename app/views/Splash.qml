import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: splash
    color: "transparent"
    title: "Tens Solitaire"
    modality: Qt.ApplicationModal
    flags: Qt.SplashScreen
    property int timeoutInterval: 2000
    signal timeout
    //visible: false
    x: (Screen.width - splashImage.width) / 2
    y: (Screen.height - splashImage.height) / 2
    width: splashImage.width
    height: splashImage.height

    Image {
        id: splashImage
        source: "qrc:/images/logo.png"
        anchors.centerIn: parent
        MouseArea {
            anchors.fill: parent
            onClicked: Qt.quit()
        }
    }

    Timer {
        interval: timeoutInterval; running: true; repeat: false
        onTriggered: {
            visible = false
            splash.timeout()
        }
    }

    Component.onCompleted: {
        if (Qt.platform.os != "android") {
            visible = true
        }
    }
}
