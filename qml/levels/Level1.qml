import QtQuick 2.0
import VPlay 2.0
import ".."

GameController {
    //levelName: "Level1"
    id: scene

    property alias opponentSnowman: opponentSnowman
    property alias lake: lake

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
/*
        MovementAnimation {
            target: Tank
            property: "x"
            running: true

            // the starting velocity
            velocity: 960

            // this forces the rectangle to move to the left (against the velocity direction), but it doesnt get faster than -20 px/second!
            acceleration: -260
            minVelocity: -20
            // limits the initial velocity set to 960, now to 500
            maxVelocity: 500

            // limits the x property between a border of 10 and 100
            minPropertyValue: 10
            maxPropertyValue: 100

            // never change the x value by more than 50 pixels in one step
            // this is useful for example to limit the rotation from MoveToPointHelper
            maxPropertyValueDifference: 50

            // this is the same as setting running to true, only for demonstration purpose
            Component.onCompleted: movement.start()
          }
*/
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
        x: scene.width / 3
        y: scene.height / 3

        rotation: 0
        obstacleBody.source: "../../assets/img/Ball.png"
    }
/*
    //load controller-elements
    GameController {
        id: gameCtrl
    }
    focus: true
*/
}
