pragma Singleton
import QtQuick 2.0
import VPlay 2.0


Item {
    id: gameInfo
    property string winner
    property bool winnerRed: false
    property int redVictory: 0
    property int blueVictory: 0
    property int maxGames: 3

    //don't work..
    property bool victory: false
    signal victory
    //signal redOnLake
}
