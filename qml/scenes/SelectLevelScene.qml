import VPlay 2.0
import QtQuick 2.0
import "../common"

SceneBase {
    id: selectLevelScene

    //property int levelSelected: 0

    // signal indicating that a level has been selected
    signal levelPressed(string selectedLevel)

    // background
    Rectangle {
        anchors.fill: parent
        color: "#ece468"
    }

    // back button to leave scene
    MenuButton {
        text: "Back"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: selectLevelScene.right
        anchors.rightMargin: 10
        anchors.top: selectLevelScene.top
        anchors.topMargin: 10
        onClicked: backPressed()
    }

    // levels to be selected
    Grid {
        anchors.centerIn: parent
        spacing: 10
        columns: 5
        MenuButton {
            text: "1"
            width: 50
            height: 50
            onClicked: {
                levelPressed("Level1.qml")
            }
        }
        MenuButton {
            text: "2"
            width: 50
            height: 50
            onClicked: {
                levelPressed("Level2.qml")
            }
        }
/*
        MenuButton {
            text: "3"
            width: 50
            height: 50
            onClicked: {
                levelPressed("GameController.qml") // Level 3
            }
        }
        Repeater {
            model: 10
            MenuButton {
                text: " "
                width: 50
                height: 50
            }
        }
 */
    }
}

