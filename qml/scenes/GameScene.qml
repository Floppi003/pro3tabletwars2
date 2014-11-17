import VPlay 2.0
import QtQuick 2.0
import "../common"

SceneBase {
    id:gameScene
    // the filename of the current level gets stored here, it is used for loading the
    property string activeLevelFileName
    // the currently loaded level gets stored here
    property variant activeLevel
    // score

    // set the name of the current level, this will cause the Loader to load the corresponding level
    function setLevel(fileName) {
        activeLevelFileName = fileName
    }

    width: 768
    height: 1024

    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#dd94da"
    }

    // back button to leave scene
    MenuButton {
        text: "Back to menu"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: gameScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: {
            backPressed()
            activeLevel = undefined
            activeLevelFileName = ""
        }
    }

    // name of the current level
    Text {
        anchors.left: gameScene.gameWindowAnchorItem.left
        anchors.leftMargin: 10
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        color: "white"
        font.pixelSize: 20
        text: activeLevel !== undefined ? activeLevel.levelName : ""
    }

    // load levels at runtime
    Loader {
        id: loader
        source: activeLevelFileName != "" ? "../levels/" + activeLevelFileName : ""
        onLoaded: {
            // reset the score
            score = 0

            // store the loaded level as activeLevel for easier access
            activeLevel = item
            // restarts the countdown
            countdown = 3
        }
    }

    // we connect the gameScene to the loaded level
    Connections {
        // only connect if a level is loaded, to prevent errors
        target: activeLevel !== undefined ? activeLevel : null
        // increase the score when the rectangle is clicked
        onRectanglePressed: {
            // only increase score when game is running
            if(gameRunning) {
                score++
            }
        }
    }

    // name of the current level
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 30
        color: "white"
        font.pixelSize: 40
        text: score
    }
}
