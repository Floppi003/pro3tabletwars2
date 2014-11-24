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
        x: 50
        y: 700
    }

    PowerUpAccelerator {
        id: powAccelerator
        x: 50
        y: 600
    }

    PowerUpPowershot {
        id: powPowershot
        x: 50
        y: 500
    }

    PowerUpLifeUp {
        id: powLifeUp
        x: 50
        y: 400
    }

    Iglu {
        igluCount: 3
        entityId: "iglu1"
        id: iglu1
        x: scene.width / 3 *2
        y: scene.height / 3 *2

        rotation: 145
        igluBody.source: "../../assets/img/Iglu.png"
    }

    Iglu {
        igluCount: 3
        entityId: "iglu2"
        id: iglu2
        x: scene.width / 7 *3
        y: scene.height / 7 *5

        rotation: 180
        igluBody.source: "../../assets/img/Iglu.png"
    }

    Iglu {
        igluCount: 3
        entityId: "iglu3"
        id: iglu3
        x: scene.width / 4*3
        y: scene.height / 2

        rotation: 90
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
}
