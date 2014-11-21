import VPlay 2.0
import QtQuick 2.0
import "../common"

SceneBase {
    id:gameOverScene
    z: 1

    // background
    Rectangle {
        anchors.fill: parent
        color: "turquoise"
    }

    // back button to leave scene
    MenuButton {
        text: "Back"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: creditsScene.right
        anchors.rightMargin: 10
        anchors.top: creditsScene.top
        anchors.topMargin: 10
        onClicked: backPressed()
    }

    // credits
    Text {
        text: "Game Over, Loser!"
        color: "red"
        anchors.centerIn: parent
    }
}
