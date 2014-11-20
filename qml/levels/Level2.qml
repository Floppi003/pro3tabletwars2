import QtQuick 2.0
import VPlay 2.0
import "../common" as Common
import ".."

Common.LevelBase {
    //levelName: "Level2"
    id: scene
    state: "2"

    property alias opponentSnowman: opponentSnowman

    Rectangle {
        id: backgroundRectangle
        anchors.fill: parent
        color: "#eeeeee"
        width: parent.width
        height: parent.height
    }

    //load controller-elements
    GameController {
        id: gameCtrl
    }
    focus: true


    Wall {
        id: wallBottom
        height: 20
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }

    Wall {
        id: wallTop
        height: 20
        anchors {
            left: parent.left
            right: parent.right
            top:parent.top
        }
    }

    Wall {
        id: wallLeft
        width: 20
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
    }

    Wall {
        id: wallRight
        width: 20
        anchors {
            left: parent.right
            bottom: parent.bottom
            top: parent.top
        }
    }

    Lake {
        id: lake
        x: 200
        y: 400

        rotation: 0
        lakeBody.source: "../../assets/img/Lake.png"
    }

    Opponents {
        id: opponentSnowman
        x: scene.width / 4 * 3
        y: scene.height / 7 * 6

        rotation: 0
        opponentBody.source: "../../assets/img/opponentSnowman.png"
    }

    Obstacle {
        id: obstacleMiddle
        x: scene.width / 3 * 2
        y: scene.height - 300

        rotation: 0
        obstacleBody.source: "../../assets/img/Obstacle.jpg"
    }

    Ball {
        id: ball
        x: scene.width / 7 * 5
        y: scene.height / 5 * 4

        rotation: 0
        obstacleBody.source: "../../assets/img/Ball.png"
    }
}
