import VPlay 2.0
import QtQuick 2.0
import "../common"
import ".."
import "."

SceneBase {
    id:resultScene
    z: 1

    property string winner: GameInfo.winnerRed ? "Rot" : "Blau" ;

    // background
    Rectangle {
        anchors.fill: parent
        color: "violet"
    }

    // back button to leave scene
    MenuButton {
        text: "Back"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        //anchors.right: gameOverScene.right
        anchors.rightMargin: 10
        //anchors.top: gameOverScene.top
        anchors.topMargin: 10
        onClicked: {
            backPressed()
            GameInfo.redVictory=0;
            GameInfo.blueVictory=0;
        }
    }

    // credits
    Text {
        text: "Statistik: \n" //+ GameInfo.winnerRed
        color: "red"
        anchors.centerIn: parent
    }
}
