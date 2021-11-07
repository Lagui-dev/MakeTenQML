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
    width: 600
    height: 800
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
    RowLayout {
        id: rLayout
        anchors.fill: parent
        Grid {
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            topPadding: 110
            transformOrigin: Item.Center
            Layout.leftMargin: 10
            spacing: 10
            rows: 3
            columns: 3
            Repeater {
                id: nineCards
                model: 9

                Rectangle {
                    property bool cardSelected: false
                    property string imagePath: "" //"qrc" + myGame.getCard(index).imagePath();

                    id: recCardSelected
                    width: 132
                    height: 195
                    radius: 5
                    border.width: 0
                    color: "forestgreen"

                    states: [
                        State {
                            name: "selected"
                            PropertyChanges { target: recCardSelected; color: "transparent" }
                            PropertyChanges { target: recCardSelected; border.width: 4 }
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
                        anchors.margins: 2
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
                                                 parent.visible = false;
                                             }
                                         }
                                     }
                                     if (myGame.draw(index)) {
                                         nineCards.itemAt(index).cardSelected = false;
                                         nineCards.itemAt(index).imagePath = "qrc" + myGame.getCard(index).imagePath();
                                     } else {
                                         parent.visible = false;
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
                                                 parent.visible = false;
                                             }
                                         }
                                     }
                                     if (myGame.draw(index)) {
                                         nineCards.itemAt(index).cardSelected = false;
                                         nineCards.itemAt(index).imagePath = "qrc" + myGame.getCard(index).imagePath();
                                     } else {
                                         parent.visible = false;
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
//                    Rectangle {
//                        id: recCardSelected
//                        anchors.fill: parent
//                        radius: 5
//                        border.color: "deepskyblue"
//                        border.width: 4
//                        color: "transparent"
//                        visible: nineCards.itemAt(index).cardSelected;
//                    }

//                    Rectangle {
//                        id: recCardPlayable
//                        anchors.fill: parent
//                        radius: 5
//                        border.color: "darkgreen"
//                        border.width: 4
//                        color: "forestgreen"
//                        visible: true;
//                    }
                }

            }
        }
        Column {
            Layout.minimumWidth: 150
            topPadding: 110
            Layout.alignment: Qt.AlignRight
            Layout.preferredHeight: parent.height
            spacing: 10
            Rectangle {
                id: cardsLeft
                width: parent.width
                height: 32
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
                width: parent.width
                height: 32
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
                width: parent.width
                height: 32
                color : '#08441e'
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Utildemo.testJSCall("testJSCall")
                        nineCards.itemAt(0).cardSelected = !nineCards.itemAt(0).cardSelected;
                        //console.info(nineCards.itemAt(0).)
                    }
                }
            }
        }
    }
}
