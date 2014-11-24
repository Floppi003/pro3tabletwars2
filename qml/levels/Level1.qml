import QtQuick 2.0
import VPlay 2.0
import ".."

GameController {
    id: scene

    property alias opponentSnowman: opponentSnowman
    property alias powShield: powShield
    property alias powAccelerator: powAccelerator
    //property alias lake: lake

    PowerUpShield {
        id: powShield
        x: 205
        y: 700
	}

    PowerUpAccelerator {
        id: powAccelerator
        x: width / 3 * 2
        y: 600
    }

    PowerUpPowershot {
        id: powPowershot
        x: width / 15 * 13
        y: 300
    }

    Iglu {
        id: iglu
        x: scene.width / 3 *2
        y: scene.height / 3 *2

        rotation: 145
        igluBody.source: "../../assets/img/Iglu.png"
    }

    Lake {
        id: lake
        anchors.centerIn: parent

        joystickRed: scene.joystickRed
        joystickBlue: scene.joystickBlue

        rotation: 0
        lakeBody.source: "../../assets/img/Lake.png"
    }

    Opponents {
        id: opponentSnowman
        x: scene.width / 2
        y: scene.height - 520

        rotation: 0
        opponentBody.source: "../../assets/img/opponentSnowman.png"
    }

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
            right: parent.right
            bottom: parent.bottom
            top: parent.top
        }
    }

    Obstacle {
        id: obstacleMiddle
        x: scene.width / 2
        y: scene.height - 700

        rotation: 0
        obstacleBody.source: "../../assets/img/Obstacle.jpg"
    }

    Ball {
        id: ball
        x: scene.width / 4
        y: scene.height / 4

        rotation: 0
        ballBody.source: "../../assets/img/Ball.png"
    }
/*
    //load controller-elements
    GameController {
        id: gameCtrl
    }
    focus: true
*/
}
