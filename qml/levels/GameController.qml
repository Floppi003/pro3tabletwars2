import QtQuick 2.0
import VPlay 2.0
import "../common" as Common
import ".."

Common.LevelBase {
    id: scene
    state: "0"

    property alias tankRed: tankRed
    property alias tankBlue: tankBlue
    property alias joystickRed: joystickRed
    property alias joystickBlue: joystickBlue
    property alias playerRed: playerRed
    property alias playerBlue: playerBlue

    //signal damage
    //property alias singleBullet: singleBullet
    //property int moveDuration: 250

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
            id: cannonControlArea
            anchors.fill: parent
            color: "#aaaaaa"
            opacity: 0.3
        }

        // delete the default images
        source: ""
        thumbSource: ""

        // Touch Methods
        property var playerTwoAxisController: tankRed.getComponent("TwoAxisController")

        onControllerXPositionChanged: {
            //if (controllerXPosition!=0 || controllerYPosition != 0){
            playerTwoAxisController.xAxis = controllerXPosition
            console.debug("Input:  x: " + controllerXPosition + " / y: " + controllerYPosition)

            var angle = calcAngle(controllerXPosition, controllerYPosition) - 90

            console.debug("Winkel rot: " +angle)
            if (controllerXPosition!=0 && controllerYPosition != 0){
                tankRed.tankBody.rotation = angle
                tankRed.boxCollider.rotation = angle
            }
            //}
        }

        onControllerYPositionChanged: {
            //if (controllerXPosition!=0 || controllerYPosition != 0){
            playerTwoAxisController.yAxis = controllerYPosition
            console.debug("Input:  x: " + controllerXPosition + " / y: " + controllerYPosition)
            var angle = calcAngle(controllerXPosition, controllerYPosition) - 90
            console.debug("Winkel rot: " +angle)
            if (controllerXPosition!=0 && controllerYPosition != 0){
                tankRed.tankBody.rotation = angle
                tankRed.boxCollider.rotation = angle
            }
            //}
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
        source: ""
        thumbSource: ""

        property var playerTwoAxisController: tankRed.getComponent("TwoAxisController")
        onControllerXPositionChanged: {
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            if (controllerXPosition!=0 && controllerYPosition != 0){
                tankRed.tankCannon.rotation = angle
            }
        }

        onControllerYPositionChanged: {
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            if (controllerXPosition!=0 && controllerYPosition != 0){
                tankRed.tankCannon.rotation = angle
            }
        }

        Timer {
            interval: 500; running: true; repeat: true;

            onTriggered: {
                var speed = 250
                var xDirection = Math.cos(tankRed.tankCannon.rotation * Math.PI / 180.0) * speed
                var yDirection = Math.sin(tankRed.tankCannon.rotation * Math.PI / 180.0) * speed


//                        xDirection = xDirection * 20
//                        yDirection = yDirection * 20


                // create and remove entities at runtime
                entityManager.createEntityFromComponentWithProperties(
                            bullet, {
                                start: Qt.point(tankRed.x, tankRed.y),
                                velocity: Qt.point(xDirection, yDirection)
                            });
            }
        }
    }

    // ---------------------------------------------------
    // Joystick Controller tankBlue
    // ---------------------------------------------------
    JoystickControllerHUD {
        rotation: 0
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
        source: ""
        thumbSource: ""

        property var playerTwoAxisController: tankBlue.getComponent("TwoAxisController")

        onControllerXPositionChanged: {
            playerTwoAxisController.xAxis = controllerXPosition
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            if (controllerXPosition!=0 && controllerYPosition != 0){
            tankBlue.tankBody.rotation = angle +90
            tankBlue.boxCollider.rotation = angle +90
            }
        }

        onControllerYPositionChanged: {
            playerTwoAxisController.yAxis = controllerYPosition
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            if (controllerXPosition!=0 && controllerYPosition != 0){
            tankBlue.tankBody.rotation = angle +90
            tankBlue.boxCollider.rotation = angle +90
            }
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
        source: ""
        thumbSource: ""

        property var playerTwoAxisController: tankBlue.getComponent("TwoAxisController")

        onControllerXPositionChanged: {
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            if (controllerXPosition!=0 && controllerYPosition != 0){
            tankBlue.tankCannon.rotation = angle
            }
        }

        onControllerYPositionChanged: {
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            if (controllerXPosition!=0 && controllerYPosition != 0){
            tankBlue.tankCannon.rotation = angle
            }
        }
    }

    PlayerRed {
        id: playerRed
        life: 3
    }

    PlayerBlue {
        id: playerBlue
        life: 3
    }

    Tank {
        id: tankRed
        x: scene.width / 2
        y: 100
        z: 1

        entityId: "tank_0"

        // rotation in degrees clockwise
        rotation: 0
        tankBody.source: "../../assets/img/charRed.png"
    }

    Tank {
        id: tankBlue
        x: scene.width / 2
        y: scene.height - 120
        z: 1

        entityId: "tank_1"

        rotation: 0
        tankBody.source: "../../assets/img/charBlue.png"

    }

    Component {
        id: bullet


        EntityBase {
            id: singleBullet
            entityType: "singleBullet"

            Rectangle {
                width: 10
                height: 10
                //anchors.fill: parent
                color: "#000000"
            }

            property point start
            property point velocity

            x: start.x
            y: start.y


            BoxCollider {
                id: boxCollider

                width: 10
                height: 10
                anchors.fill: parent
                collisionTestingOnlyMode: true

                density: 0
                friction: 0
                restitution: 0
                body.bullet: true
                body.fixedRotation: false // if set to true the physics engine will NOT apply rotation to it

                fixture.onBeginContact: {
                    // handle the collision

                    var collidedColliderComponent = other.parent.parent;
                    var collidedEntity = collidedColliderComponent.parent;
                    console.log("bullet collides with tank or something else:" + singleBullet.entityId + " / " + collidedEntity.entityId)

                    if(tankRed.entityId !== collidedEntity.entityId &&
                       tankBlue.entityId !== collidedEntity.entityId &&
                       collidedEntity.entityId !== "lake"){
                        console.log("bullet collides with another object:" + singleBullet.entityId + " / " + collidedEntity.entityId)
                        singleBullet.removeEntity()
                        singleBullet.destroy()
                        singleBullet.destroy()
                    }
                }
            }

            MovementAnimation {
                target: singleBullet

                property: "x"
                velocity: singleBullet.velocity.x
                running: true
            }

            MovementAnimation {
                target: singleBullet

                property: "y"
                velocity: singleBullet.velocity.y
                running: true
                onStopped: {
                    singleBullet.destroy()
                }
            }
        }
    }

    // energy tankred
    Text {
        z:1
        //anchors.: parent.horizontalCenter
        //anchors.top: gameScene.gameWindowAnchorItem.top
        //anchors.ce
        //anchors.topMargin: 80
        color: "black"
        font.pixelSize: 40
        text: playerRed.life

        anchors {
            horizontalCenter: scene.horizontalCenter
            //right: parent.right
            top: scene.top
            topMargin: 30
        }
    }

    // energy tankBlue
    Text {
        z:1
        //anchors.left: parent.horizontalCenter
        //anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        //anchors.topMargin: 80
        color: "black"
        font.pixelSize: 40
        text: playerBlue.life

        anchors {
            horizontalCenter: scene.horizontalCenter
            //right: parent.right
            bottom: scene.bottom
            bottomMargin: 30
        }
    }

    Text {
        z :1
        anchors.centerIn: parent
        color: "green"
        font.pixelSize: 50
        text: playerRed.life<=0 || playerBlue.life<=0 ? "Game Over" : ""
    }

    function calcAngle(touchX, touchY) {
        console.log("calcAngle: " + (-180 / Math.PI * Math.atan2(touchY, touchX)))
        return -180 / Math.PI * Math.atan2(touchY, touchX)
    }

    Loader { id: baseLoader }

    onDamage: {
        console.log("DamageSignal!!!!!!!!!!!!!!!!!!!!!!")
        if (playerRed.life<=0 || playerBlue.life<=0){
            //window.state = "credits"
            //gameOver()
            baseLoader.source = "../scenes/GameOverScene.qml"
        }
    }
}
