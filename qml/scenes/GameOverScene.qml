import VPlay 2.0
import QtQuick 2.0
import "../common"
import ".."

SceneBase {
    id:gameOverScene
    z: 1

    property string winner: GameInfo.winnerRed ? "Rot" : "Blau" ;

    // background
    Rectangle {
        anchors.fill: parent
        color: "turquoise"
    }

    // back button to leave scene
    MenuButton {
        text: "Back"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: gameOverScene.right
        anchors.rightMargin: 10
        anchors.top: gameOverScene.top
        anchors.topMargin: 10
        onClicked: {
            backPressed()
        }
    }

    // game over
    Text {
        text: "Game Over, der Gewinner ist " + winner //GameInfo.winnerRed
        color: "red"
        anchors.centerIn: parent
    }
}
