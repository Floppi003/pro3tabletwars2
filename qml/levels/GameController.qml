import QtQuick 2.0
import VPlay 2.0
import "../common" as Common
import ".."

Common.LevelBase {
    //levelName: "Level1"
    id:scene
    state: "1"

    property alias tankRed: tankRed
    property alias tankBlue: tankBlue

    // physics world for collision detection
    PhysicsWorld {
        id: world
        updatesPerSecondForPhysics: 60
    }



    /*
    states: [
        State {
            name: "1"
            Level1 {
                id: level1
            }
        },
        State {
            name: "2"
            Level2 {
                id: level2
            }
        }
    ]
*/

    Level1 {
        id: level1
    }


    focus: true



    // ---------------------------------------------------
    // Joystick Controller tankRed
    // ---------------------------------------------------
    JoystickControllerHUD {
        id: joystickRed
        width: 180
        height: 180
        x: 50
        y: 50

        Rectangle {
            anchors.fill: parent
            color: "#aaaaaa"
            opacity: 0.3
        }

        // delete the default images
        source: "../assets/img/null"
        thumbSource: "../assets/img/null"


        // Touch Methods
        property variant playerTwoAxisController: tankRed.getComponent("TwoAxisController")

        onControllerXPositionChanged: {
            playerTwoAxisController.xAxis = controllerXPosition
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            tankRed.tankBody.rotation = angle
            tankRed.boxCollider.rotation = angle
        }

        onControllerYPositionChanged: {
            playerTwoAxisController.yAxis = controllerYPosition
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            tankRed.tankBody.rotation = angle
            tankRed.boxCollider.rotation = angle
        }




        // Custom Javascript Functions
        function calcAngle(touchX, touchY) {

            console.log("touchX: " + touchX + ", touchY: " + touchY)

            // Avoid division by zero!
            if (touchX == 0) {
                return tankRed.boxCollider.rotation
            }

            var angle = Math.atan(touchY / touchX)

            // find out in which quadrant this happened.
            if (touchX < 0 && touchY >= 0) {
                // upper left quadrant
                angle = Math.PI - (Math.abs(angle))

            } else if (touchX < 0 && touchY < 0) {
                // lower left quadrant
                angle = Math.PI + (Math.abs(angle))

            } else if (touchX >= 0 && touchY < 0) {
                // lower right quadrant
                angle = (Math.PI * 2) - (Math.abs(angle))
            }

            angle = (angle * 180 / Math.PI)
            angle = 360 - angle
            console.log("angle: " + angle + ", (x: " + touchX + ", y: " + touchY + ")")

            return angle - 90
        }
    }





    // ---------------------------------------------------
    // Joystick Controller red tankCannon
    // ---------------------------------------------------
    JoystickControllerHUD {
        width: 180
        height: 180
        x: scene.width - 230
        y: 50

        Rectangle {
            anchors.fill: parent
            color: "#aaaaaa"
            opacity: 0.3
        }

        // delete the default images
        source: "../assets/img/null"
        thumbSource: "../assets/img/null"

        property variant playerTwoAxisController: tankRed.getComponent("TwoAxisController")
        onControllerXPositionChanged: {
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            tankRed.tankCannon.rotation = angle
        }

        onControllerYPositionChanged: {
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            tankRed.tankCannon.rotation = angle
        }

        function calcAngle(touchX, touchY) {

            console.log("touchX: " + touchX + ", touchY: " + touchY)

            // Avoid division by zero!
            if (touchX == 0) {
                return tankRed.tankCannon.rotation
            }

            var angle = Math.atan(touchY / touchX)

            // find out in which quadrant this happened.
            if (touchX < 0 && touchY >= 0) {
                // upper left quadrant
                angle = Math.PI - (Math.abs(angle))

            } else if (touchX < 0 && touchY < 0) {
                // lower left quadrant
                angle = Math.PI + (Math.abs(angle))

            } else if (touchX >= 0 && touchY < 0) {
                // lower right quadrant
                angle = (Math.PI * 2) - (Math.abs(angle))
            }

            angle = (angle * 180 / Math.PI)
            angle = 360 - angle
            console.log("angle: " + angle + ", (x: " + touchX + ", y: " + touchY + ")")

            return angle
        }
    }







    // ---------------------------------------------------
    // Joystick Controller tankBlue
    // ---------------------------------------------------
    JoystickControllerHUD {
        id: joystickBlue
        width: 180
        height: 180
        x: scene.width - 230
        y: scene.height - 230

        Rectangle {
            anchors.fill: parent
            color: "#aaaaaa"
            opacity: 0.3
        }

        // delete the default images
        source: "../assets/img/null"
        thumbSource: "../assets/img/null"

        property variant playerTwoAxisController: tankBlue.getComponent("TwoAxisController")

        onControllerXPositionChanged: {
            playerTwoAxisController.xAxis = controllerXPosition
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            tankBlue.tankBody.rotation = angle
            tankBlue.boxCollider.rotation = angle
        }

        onControllerYPositionChanged: {
            playerTwoAxisController.yAxis = controllerYPosition
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            tankBlue.tankBody.rotation = angle
            tankBlue.boxCollider.rotation = angle
        }


        function calcAngle(touchX, touchY) {

            console.log("touchX: " + touchX + ", touchY: " + touchY)

            // Avoid division by zero!
            if (touchX == 0) {
                return tankBlue.boxCollider.rotation
            }

            var angle = Math.atan(touchY / touchX)

            // find out in which quadrant this happened.
            if (touchX < 0 && touchY >= 0) {
                // upper left quadrant
                angle = Math.PI - (Math.abs(angle))

            } else if (touchX < 0 && touchY < 0) {
                // lower left quadrant
                angle = Math.PI + (Math.abs(angle))

            } else if (touchX >= 0 && touchY < 0) {
                // lower right quadrant
                angle = (Math.PI * 2) - (Math.abs(angle))
            }

            angle = (angle * 180 / Math.PI)
            angle = 360 - angle
            console.log("angle: " + angle + ", (x: " + touchX + ", y: " + touchY + ")")

            return angle - 90
        }
    }



    // ---------------------------------------------------
    // Joystick Controller blue tankCannon
    // ---------------------------------------------------
    JoystickControllerHUD {
        width: 180
        height: 180
        x: 50
        y: scene.height - 230

        Rectangle {
            anchors.fill: parent
            color: "#aaaaaa"
            opacity: 0.3
        }

        // delete the default images
        source: "../assets/img/null"
        thumbSource: "../assets/img/null"

        property variant playerTwoAxisController: tankBlue.getComponent("TwoAxisController")

        onControllerXPositionChanged: {
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            tankBlue.tankCannon.rotation = angle
        }

        onControllerYPositionChanged: {
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            tankBlue.tankCannon.rotation = angle
        }


        function calcAngle(touchX, touchY) {

            console.log("touchX: " + touchX + ", touchY: " + touchY)

            // Avoid division by zero!
            if (touchX == 0) {
                return tankBlue.tankCannon.rotation
            }

            var angle = Math.atan(touchY / touchX)

            // find out in which quadrant this happened.
            if (touchX < 0 && touchY >= 0) {
                // upper left quadrant
                angle = Math.PI - (Math.abs(angle))

            } else if (touchX < 0 && touchY < 0) {
                // lower left quadrant
                angle = Math.PI + (Math.abs(angle))

            } else if (touchX >= 0 && touchY < 0) {
                // lower right quadrant
                angle = (Math.PI * 2) - (Math.abs(angle))
            }

            angle = (angle * 180 / Math.PI)
            angle = 360 - angle
            console.log("angle: " + angle + ", (x: " + touchX + ", y: " + touchY + ")")

            return angle
        }
    }

    Tank {
        id: tankRed
        x: scene.width / 2
        y: 100

        // rotation in degrees clockwise
        rotation: 0
        tankBody.source: "../../assets/img/charRed.png"
    }

    Tank {
        id: tankBlue
        x: scene.width / 2
        y: scene.height - 120

        rotation: 0
        tankBody.source: "../../assets/img/charBlue.png"
    }
}
