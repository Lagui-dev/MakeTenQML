import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: splash
    color: "#08441e"
    title: "Tens Solitaire"
    modality: Qt.ApplicationModal
    flags: Qt.SplashScreen
    property int timeoutInterval: 2000
    signal timeout
    width: 411
    height: 832

    Text {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Open Source Project - LAGUI-DEV 2021"
        color: "white"
        font.pointSize: 16
    }

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
    Component.onCompleted: visible = true
}
