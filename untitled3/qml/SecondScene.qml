import QtQuick 2.0
import VPlay 2.0

Scene {
    width: 100
    height: 62

    Text {
        z:1
        //anchors.: parent.horizontalCenter
        //anchors.top: gameScene.gameWindowAnchorItem.top
        //anchors.ce
        //anchors.topMargin: 80
        color: "black"
        font.pixelSize: 40
        text: "GameOver"

        anchors {
            horizontalCenter: scene.horizontalCenter
            //right: parent.right
            top: scene.top
            topMargin: 30
        }
    }
}
