import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: button
    implicitWidth: 100
    implicitHeight: 40
    font.pointSize:  18
    background: Rectangle {
        radius: 4
        opacity: enabled ? 1 : 0.3
        border.color: button.down ? "#17a81a" : "#21be2b"
        border.width: 1
    }
    contentItem: Text {
        text: button.text
        font: button.font
        opacity: enabled ? 1.0 : 0.3
        color: button.down ? "#17a81a" : "#21be2b"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
}
