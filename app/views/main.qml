import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15

import MakeTen.Game 1.0
import MakeTen.GameStatus 1.0
import MakeTen.Card 1.0

import "util.js" as Utildemo

Window {
    property real dp: mainWindow.height / 832
    id: mainWindow
    width: 411
    height: 832
    visible: true

    Game {
        id: myGame;
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
        Row {
            spacing: 9 * dp

            MTButton {
                id: cardsLeft
                width: 125 * dp
                pointSize: 16 * dp
                text: qsTr("52")
            }

            MTButton {
                id: chronoValue
                width: 125 * dp
                pointSize: 16 * dp
                //text: qsTr("00:00:00")
                text: Number(dp).toLocaleString();
            }

            MTButton {
                id: startButton
                width: 125 * dp
                pointSize: 16 * dp
                text: qsTr("RESTART")
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        myGame.reStart();
                        for (let idx = 0; idx < 9; idx++) {
                            nineCards.itemAt(idx).cardSelected = false;
                            nineCards.itemAt(idx).imagePath = "qrc:/images/cards/back_table.png";
                            cardsLeft.text = myGame.size();
                        }
                    }
                }
            }
        }


        Grid {
            spacing: 9 * dp
            rows: 3
            columns: 3
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
                            PropertyChanges { target: recCardSelected; border.width: 6 }
                        },
                        State {
                            name: "waiting"
                            PropertyChanges { target: recCardSelected; border.width: 0 }
                        }
                    ]

                    state: cardSelected ? "selected" : "waiting";

                    Image {
                        source : imagePath
                        anchors.margins: 3
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
                                     cardsLeft.text = "YOU WIN!";
                                 } else {
                                     cardsLeft.text = myGame.size();
                                 }

                             }
                         }
                    }
                }

            }
        }
    }
}


