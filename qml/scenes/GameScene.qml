import VPlay 2.0
import QtQuick 2.0
import "../common"

SceneBase {
    id:gameScene
    // the filename of the current level gets stored here, it is used for loading the
    property string activeLevelFileName
    // the currently loaded level gets stored here
    property var activeLevel

    signal damage

    // set the name of the current level, this will cause the Loader to load the corresponding level
    function setLevel(fileName) {
        activeLevelFileName = fileName
    }


    // back button to leave scene
    MenuButton {
        z: 1
        text: "Back to menu"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: gameScene.right
        anchors.rightMargin: 10
        anchors.top: gameScene.top
        anchors.topMargin: 10
        onClicked: {
            backPressed()
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

    /*
    // physics world for collision detection
    PhysicsWorld {
        id: world
        debugDrawVisible: false
        updatesPerSecondForPhysics: 10
    }
*/

    // load levels at runtime
    Loader {
        id: loader
        source: activeLevelFileName != "" ? "../levels/" + activeLevelFileName : ""
        onLoaded: {
            // store the loaded level as activeLevel for easier access
            activeLevel = item
        }
    }
}
