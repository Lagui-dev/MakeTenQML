import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.12

import MakeTen.Game 1.0
import MakeTen.GameStatus 1.0
import MakeTen.Card 1.0
import "util.js" as Utildemo

Window {
    id: root
    width: 800
    height: 600
    visible: true
    title: qsTr("Tens Solitaire - QML")



//    header: ToolBar {
//        ToolButton {

//        }
//    }
//    footer: Text {
//        text: "Tens Solitaire QML v0.1.00.beta1 - MIT Licence - 2021 - Lagui-dev"

//    }
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
    ColumnLayout {
        id: cLayout
        anchors.fill: parent

        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 100
            Layout.preferredWidth: 150
            Layout.minimumHeight: 32
            Layout.preferredHeight: 50
            spacing: 10

            Rectangle {
                id: cardsLeft
                height: 32
                width: 125
                color : '#08441e'
                Text {
                    id: cardLeftValue
                    text: qsTr("YOU WIN!")
                    font.pointSize: 20
                    color: 'white'
                    anchors.horizontalCenter: parent.horizontalCenter

                }
            }
            Rectangle {
                id: chrono
                height: 32
                width: 125
                color : '#08441e'
                Text {
                    id : chronoValue
                    text: qsTr("00:00:00")
                    font.pointSize: 20
                    color : 'white'
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Rectangle {
                id: testCall
                height: 32
                width: 125
                color : '#08441e'
                Text {
                    id : infoText
                    text: "RESTART"
                    font.pointSize: 20
                    color : 'white'
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        myGame.reStart();
                        for (let idx = 0; idx < 9; idx++) {
                            nineCards.itemAt(idx).cardSelected = false;
                            nineCards.itemAt(idx).imagePath = "";
                            cardLeftValue.text = myGame.size();
                        }
                    }
                }
            }
        }


        GridLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.minimumWidth: 300
            Layout.preferredWidth: 600
            Layout.leftMargin: 10
            transformOrigin: Item.Center
            rows: 3
            columns: 3
            Repeater {
                id: nineCards
                model: 9

                Rectangle {
                    property bool cardSelected: false
                    property string imagePath: ""
                    width: 125
                    height: 175

                    id: recCardSelected


//                    width: 132
//                    height: 195
                    radius: 5
                    border.width: 0
                    color: "forestgreen"

                    states: [
                        State {
                            name: "selected"
                            PropertyChanges { target: recCardSelected; color: "transparent" }
                            PropertyChanges { target: recCardSelected; border.width: 6 }
                            PropertyChanges { target: recCardSelected; border.color : "black" }
                        },
                        State {
                            name: "waiting"
                            PropertyChanges { target: recCardSelected; color: "#1f9d4c" }
                            PropertyChanges { target: recCardSelected; border.width: 0 }
                        }
                    ]

                    state: cardSelected ? "selected" : "waiting";

                    Image {
                        anchors.margins: 3
                        anchors.fill: parent
                        source : imagePath
                        anchors.centerIn: parent

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
                                     cardLeftValue.text = "YOU WIN!";
                                 } else {
                                     cardLeftValue.text = myGame.size();
                                 }

                             }
                         }
                    }
                }

            }
        }
    }
}


