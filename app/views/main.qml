import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

import MakeTen.Game 1.0
import MakeTen.GameStatus 1.0
import MakeTen.Card 1.0

import "util.js" as Utildemo

Window {
    property real dp: mainWindow.height / 832

    property var splashWindow: Splash {
       onTimeout: mainWindow.visible = true
    }

    id: mainWindow
    width: 411
    height: 832
    visible: false

    Game {
        id: myGame;
        onChronoUpdated: {
            btnChrono.text = chronoHMS;
        }
    }

    Image {
        id: imgbackground
        source: "qrc:/images/background_table.png"
        fillMode: Image.Tile
        horizontalAlignment: Image.AlignLeft
        verticalAlignment: Image.AlignTop
        anchors.fill: parent
    }


    Column {
        id: cLayout
        anchors.fill: parent
        topPadding: 9 * dp
        leftPadding: 9 * dp
        spacing: 9 * dp

        Row {
            spacing: 9 * dp

            MTLabel {
                id: btnCardsLeft
                width: 125 * dp
                pointSize: 18 * dp
                text: qsTr("52")
            }

            MTLabel {
                id: btnChrono
                width: 125 * dp
                pointSize: 18 * dp
                text: qsTr("00:00:00")
            }

            MTButton {
                text: qsTr("RESTART")
                font.pointSize: 18 * dp
                width: 125 * dp
                height: 40
                onClicked: {
                    enabled = false;
                    myGame.reStart();
                    txtCounter.text = "Played : " + myGame.counter()
                    for (let idx = 0; idx < 9; idx++) {
                        nineCards.itemAt(idx).cardSelected = false;
                        nineCards.itemAt(idx).imagePath = "qrc:/images/cards/back_table.png";
                        btnCardsLeft.text = myGame.size();
                    }
                    youWin.visible = false;
                    enabled = true;
                }
            }
        }


        Grid {
            spacing: 9 * dp
            rows: 3
            columns: 3
            id: gridCards

            Repeater {
                id: nineCards
                model: 9

                Rectangle {
                    id: recCardSelected
                    property bool cardSelected: false
                    property string imagePath: "qrc:/images/cards/back_table.png"
                    width: 125 * dp
                    height: 191 * dp

                    radius: 6
                    border.width: 0
                    border.color : "#36e073"
                    color: "transparent"

                    states: [
                        State {
                            name: "selected"
                            PropertyChanges { target: recCardSelected; border.width: 0 }
                            PropertyChanges { target: imgSelected; visible: true }
                        },
                        State {
                            name: "waiting"
                            PropertyChanges { target: recCardSelected; border.width: 0 }
                            PropertyChanges { target: imgSelected; visible: false }
                        }
                    ]

                    state: cardSelected ? "selected" : "waiting";

                    Image {
                        source : parent.imagePath
                        anchors.margins: 4
                        anchors.fill: parent

                        MouseArea {
                             anchors.fill: parent
                             onClicked: {

                                 switch (myGame.check(index)) {

                                 case GameState.NOTHING: {
                                     console.info("Nothing");
                                     if (myGame.draw(index)) {
                                         nineCards.itemAt(index).cardSelected = false;
                                         nineCards.itemAt(index).imagePath = "qrc" + myGame.getCard(index).imagePath();
                                     }

                                     break;
                                 }

                                 case GameState.WAITING: {
                                     console.info("Waiting");
                                     nineCards.itemAt(index).cardSelected = true;
                                     break;
                                 }

                                 case GameState.CANCEL: {
                                     console.info("Cancel");
                                     for (let idxCancel = 0; idxCancel < 9; idxCancel++) {
                                         nineCards.itemAt(idxCancel).cardSelected = false;
                                     }
                                     break;
                                 }

                                 case GameState.WINNING1CARD: {
                                     console.info("Win1");
                                     if (myGame.draw(index)) {
                                         nineCards.itemAt(index).cardSelected = false;
                                         nineCards.itemAt(index).imagePath = "qrc" + myGame.getCard(index).imagePath();
                                     } else {
                                         nineCards.itemAt(index).imagePath = "";
                                     }

                                     break;
                                 }

                                 case GameState.WINNING2CARDS: {
                                     console.info("Win2");
                                     for (let idxWin2 = 0; idxWin2 < 9; idxWin2++) {
                                         if (nineCards.itemAt(idxWin2).cardSelected) {
                                             nineCards.itemAt(idxWin2).cardSelected = false;
                                             if (myGame.draw(idxWin2)) {
                                                 nineCards.itemAt(idxWin2).imagePath = "qrc" + myGame.getCard(idxWin2).imagePath();
                                             } else {
                                                 nineCards.itemAt(idxWin2).imagePath = "";
                                             }
                                         }
                                     }
                                     if (myGame.draw(index)) {
                                         nineCards.itemAt(index).cardSelected = false;
                                         nineCards.itemAt(index).imagePath = "qrc" + myGame.getCard(index).imagePath();
                                     } else {
                                         nineCards.itemAt(index).imagePath = "";
                                     }
                                     break;
                                 }

                                 case GameState.WINNING3CARDS: {
                                     console.info("Win3");
                                     for (let idxWin3 = 0; idxWin3 < 9; idxWin3++) {
                                         if (nineCards.itemAt(idxWin3).cardSelected) {
                                             nineCards.itemAt(idxWin3).cardSelected = false;
                                             if (myGame.draw(idxWin3)) {
                                                 nineCards.itemAt(idxWin3).imagePath = "qrc" + myGame.getCard(idxWin3).imagePath();
                                             } else {
                                                 nineCards.itemAt(idxWin3).imagePath = "";
                                             }
                                         }
                                     }
                                     if (myGame.draw(index)) {
                                         nineCards.itemAt(index).cardSelected = false;
                                         nineCards.itemAt(index).imagePath = "qrc" + myGame.getCard(index).imagePath();
                                     } else {
                                         nineCards.itemAt(index).imagePath = "";
                                     }
                                     break;
                                 }

                                 default: {
                                     console.info("Err " + myGame.check(index));
                                 }
                                 }

                                 if (myGame.areYouWin()) {
                                     console.info("You win");
                                     txtBestTime.text = "Best time : " + btnChrono.text;
                                     youWin.visible = true;
                                     youWin.pos = 0;

                                 } else {
                                     btnCardsLeft.text = myGame.size();
                                 }

                             }
                         }
                    }

                    Image {
                        id : imgSelected
                        source: "qrc:/images/card_selected.png"
                        width: 63 * dp
                        height: 55 * dp
                        anchors.bottom: parent.bottom
                        visible: false

                    }
                }
            }
        }
        Rectangle {
            width: gridCards.width
            height: 28
            color: "black"
            opacity: 0.5
            Text {
                id: txtBestTime
                anchors.centerIn: parent
                color: "white"
                font.pointSize: 16 * dp
                text:  "Best time : 23:59:59"
            }
        }
        Rectangle {
            width: gridCards.width
            height: 28
            color: "black"
            opacity: 0.5
            Text {
                id: txtCounter
                anchors.centerIn: parent
                color: "white"
                font.pointSize: 16 * dp
                text:  "Played : " + myGame.counter()
            }
        }
    }


    Rectangle {
        property int pos: 400
        id: youWin
        anchors.horizontalCenter: parent.horizontalCenter
        y: pos
        visible: false
        width: 223 * dp
        height: 190 * dp
        color: "transparent"
        Image {
            anchors.fill: parent
            source: "qrc:/images/youwin.png"
        }

        Behavior on pos {
            NumberAnimation {
                id: animation
                from: 0
                to: mainWindow.height /2
                duration: 1000
                easing.type : Easing.InOutBack
            }
        }
    }
}


