import QtQuick 2.15

Rectangle {

    property string text: ""
    property int pointSize: 18

    height: 40
    width: 125
    radius: 4
    color : '#08441e'
    Text {
        text: parent.text
        font.pointSize: parent.pointSize
        color: 'white'
        anchors.centerIn: parent

    }
}
