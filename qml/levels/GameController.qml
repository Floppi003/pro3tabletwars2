import QtQuick 2.0
import VPlay 2.0
import "../common" as Common
import ".."

Common.LevelBase {
    id: scene
    state: "0"

    property alias tankRed: tankRed
    property alias tankBlue: tankBlue
    property alias playerMovementControlAreaRed: playerMovementControlAreaRed
    property alias playerMovementControlAreaBlue: playerMovementControlAreaBlue
    property alias playerRed: playerRed
    property alias playerBlue: playerBlue


    focus: true

    // ---------------------------------------------------
    // Controller tankRed
    // ---------------------------------------------------
    Rectangle {
        // Object properties
        id: playerMovementControlAreaRed
        width: 180
        height: 180
        x: 50
        y: 50
        z: 5
        opacity: 0.2
        color: "#000000"
        border.width: 4
        border.color: "#ffaa00"

        MultiPointTouchArea {
            anchors.fill: parent
            property variant playerTwoAxisController: tankRed.getComponent("TwoAxisController")     // Touch Methods
            property real newPosX: 0.0
            property real newPosY: 0.0

            property real oldPosX: 0.0
            property real oldPosY: 0.0

            touchPoints: [
                TouchPoint {id: pointCtrlRed}
            ]

            onTouchUpdated: {
                newPosX = (pointCtrlRed.x / (parent.width / 2) - 1)
                newPosY = (pointCtrlRed.y / (parent.height / 2) - 1)

                newPosY = newPosY * -1

                if (newPosX > 1) newPosX = 1
                if (newPosY > 1) newPosY = 1
                if (newPosX < -1) newPosX = -1
                if (newPosY < -1) newPosY = -1

                if(GameInfo.redOnLake){
                    console.log("X old: " + oldPosX + " | new: " + newPosX)
                    console.log("Y old: " + oldPosY + " | new: " + newPosY)
                    newPosX = oldPosX+(newPosX*0.03)
                    newPosY = oldPosY+(newPosY*0.03)

                    if (newPosX > 1) newPosX = 1
                    if (newPosY > 1) newPosY = 1
                    if (newPosX < -1) newPosX = -1
                    if (newPosY < -1) newPosY = -1
                }
                updateMovement()
            }

            function updateMovement(){
                playerTwoAxisController.xAxis = newPosX
                playerTwoAxisController.yAxis = newPosY
                oldPosX=newPosX
                oldPosY=newPosY

                var angle = calcAngle(newPosX, newPosY) - 90

                if (newPosX!=0 && newPosY != 0){
                    tankRed.tankBody.rotation = angle
                    tankRed.circleCollider.rotation = angle
                }
            }
        }
    }




    // ---------------------------------------------------
    // Joystick Controller tankRed
    // ---------------------------------------------------
//    JoystickControllerHUD {
//        id: joystickRed
//        width: 180
//        height: 180
//        x: 50
//        y: 50
//        z: 5

//        Rectangle {
//            id: cannonControlArea
//            anchors.fill: parent
//            color: "#aaaaaa"
//            opacity: 0.3
//            z: 5
//        }

//        // delete the default images
//        source: ""
//        thumbSource: ""

//        // Touch Methods
//        property var playerTwoAxisController: tankRed.getComponent("TwoAxisController")

//        onControllerXPositionChanged: {
//            playerTwoAxisController.xAxis = controllerXPosition
//            var angle = calcAngle(controllerXPosition, controllerYPosition) - 90
//            if (controllerXPosition!=0 && controllerYPosition != 0){
//                tankRed.tankBody.rotation = angle
//                tankRed.circleCollider.rotation = angle
//            }
//        }

//        onControllerYPositionChanged: {
//            playerTwoAxisController.yAxis = controllerYPosition
//            var angle = calcAngle(controllerXPosition, controllerYPosition) - 90
//            if (controllerXPosition!=0 && controllerYPosition != 0){
//                tankRed.tankBody.rotation = angle
//                tankRed.circleCollider.rotation = angle
//            }
//        }
//    }

    // ---------------------------------------------------
    // Controller redTankCannon
    // ---------------------------------------------------
    /*
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

                    // create and remove entities at runtime
                    entityManager.createEntityFromComponentWithProperties(
                                bullet, {
                                    start: Qt.point(tankRed.x, tankRed.y + 35),
                                    velocity: Qt.point(xDirection, yDirection)
                                });
                }
            }
        }
*/
    Rectangle {
        // Object properties
        id: playerBulletControlAreaRed

        opacity: 0.2
        color: "#000000"
        border.width: 4
        border.color: "#ffaa00"
        width: 180
        height: 180
        x: scene.width - 230
        y: 50
        z: 5

        MultiPointTouchArea {
            anchors.fill: parent

            property bool rotateOnce: true
            property bool pressBool: false
            property var lastTime: 0
            property variant playerTwoAxisController: tankRed.getComponent("TwoAxisController")

            touchPoints: [
                TouchPoint {id: point1}
            ]

            onTouchUpdated: upDateCannon()

            onPressed: {
                upDateCannon()
                pressBool= true
            }

            onReleased: {
                upDateCannon()
                var currentTime = new Date().getTime()
                var timeDiff = currentTime - lastTime
                if (pressBool && timeDiff > playerRed.minTimeDistanceBullet) {
                    lastTime = currentTime

                    console.debug("Shoot Cannon")


                    var speed = (playerRed.activateAccelerator) ? 500 : 250

                    var xDirection = Math.cos(tankRed.tankCannon.rotation * Math.PI / 180.0) * speed
                    var yDirection = Math.sin(tankRed.tankCannon.rotation * Math.PI / 180.0) * speed

                    var startX= (45*Math.cos((tankRed.tankCannon.rotation)*Math.PI/180)) + tankRed.x + tankRed.width/2
                    var startY= (45*Math.sin((tankRed.tankCannon.rotation)*Math.PI/180)) + tankRed.y + tankRed.height/2

                    // create and remove entities at runtime
                    entityManager.createEntityFromComponentWithProperties(
                                bullet, {
                                    start: Qt.point(startX, startY),
                                    velocity: Qt.point(xDirection, yDirection)
                                });
                }
                pressBool= false
            }

            function upDateCannon(){
                var x = point1.x
                var y = point1.y
                x = x - (playerBulletControlAreaRed.width / 2)
                y = (y - (playerBulletControlAreaRed.height / 2)) * (-1)
                var angle = calcAngle(x, y)
                tankRed.tankCannon.rotation = angle
            }

            onEnabledChanged: {
                if(rotateOnce){
                tankRed.tankCannon.rotation = 90
                rotateOnce = false
                }
            }
        }
    }

    // ---------------------------------------------------
    // Controller tankBlue
    // ---------------------------------------------------
    Rectangle {
        // Object properties
        id: playerMovementControlAreaBlue
        width: 180
        height: 180
        x: scene.width - 230
        y: scene.height - 230
        z: 5
        opacity: 0.2
        color: "#000000"
        border.width: 4
        border.color: "#ffaa00"

        MultiPointTouchArea {
            anchors.fill: parent
            property variant playerTwoAxisController: tankBlue.getComponent("TwoAxisController")     // Touch Methods
            property real newPosX: 0.0
            property real newPosY: 0.0
            property bool rotateOnce: true

            touchPoints: [
                TouchPoint {id: pointCtrlBlue}
            ]

            onEnabledChanged: {
                if(rotateOnce){
                tankBlue.tankBody.rotation = 180
                tankBlue.circleCollider.rotation = 180
                rotateOnce = false
                }
            }

            onTouchUpdated: {
                newPosX = (pointCtrlBlue.x / (parent.width / 2) - 1)
                newPosY = (pointCtrlBlue.y / (parent.height / 2) - 1)

                newPosY = newPosY * -1

                if (newPosX > 1) newPosX = 1
                if (newPosY > 1) newPosY = 1
                if (newPosX < -1) newPosX = -1
                if (newPosY < -1) newPosY = -1

                updateMovement()
            }

            function updateMovement(){
                updateMovementX()
                updateMovementY()
            }

            function updateMovementX(){
                //console.debug("pointCtrlRed.x = " + pointCtrlRed.x)
                playerTwoAxisController.xAxis = newPosX
                var angle = calcAngle(newPosX, newPosY) - 90
                if (newPosX!=0 && newPosY != 0){
                    tankBlue.tankBody.rotation = angle
                    tankBlue.circleCollider.rotation = angle
                }
            }

            function updateMovementY(){
                //console.debug("pointCtrlRed.y = " + pointCtrlRed.y)
                playerTwoAxisController.yAxis = newPosY
                var angle = calcAngle(newPosX, newPosY) - 90
                if (newPosX!=0 && newPosY != 0){
                    tankBlue.tankBody.rotation = angle
                    tankBlue.circleCollider.rotation = angle
                }
            }
        }
    }

//    JoystickControllerHUD {
//        rotation: 0
//        id: joystickBlue
//        width: 180
//        height: 180
//        x: scene.width - 230
//        y: scene.height - 230
//        z: 5

//        Rectangle {
//            anchors.fill: parent
//            color: "#aaaaaa"
//            opacity: 0.3
//            z: 5
//        }

//        // delete the default images
//        source: ""
//        thumbSource: ""

//        property var playerTwoAxisController: tankBlue.getComponent("TwoAxisController")

//        onControllerXPositionChanged: {
//            console.debug("controllerXPosition-Blue = " + controllerXPosition)
//            playerTwoAxisController.xAxis = controllerXPosition
//            var angle = calcAngle(controllerXPosition, controllerYPosition)
//            if (controllerXPosition!=0 && controllerYPosition != 0){
//                tankBlue.tankBody.rotation = angle +90
//                tankBlue.circleCollider.rotation = angle +90
//            }
//        }

//        onControllerYPositionChanged: {
//            console.debug("controllerYPosition-Blue = " + controllerYPosition)
//            playerTwoAxisController.yAxis = controllerYPosition
//            var angle = calcAngle(controllerXPosition, controllerYPosition)
//            if (controllerXPosition!=0 && controllerYPosition != 0){
//                tankBlue.tankBody.rotation = angle +90
//                tankBlue.circleCollider.rotation = angle +90
//            }
//        }

//    }

    // ---------------------------------------------------
    // Controller blueTankCannon
    // ---------------------------------------------------
    Rectangle {
        // Object properties
        id: playerBulletControlAreaBlue

        opacity: 0.2
        color: "#000000"
        border.width: 4
        border.color: "#ffaa00"
        width: 180
        height: 180
        x: 50
        y: scene.height - 230
        z: 5

        MultiPointTouchArea {
            anchors.fill: parent

            property bool rotateOnce: true
            property bool pressBool: true
            property var lastTime: 0
            property var playerTwoAxisController: tankBlue.getComponent("TwoAxisController")

            touchPoints: [
                TouchPoint {id: point2}
            ]

/*onPressed: {
                upDateCannon()
                pressBool= true
            }

            onReleased: {
                upDateCannon()
                var currentTime = new Date().getTime()
                var timeDiff = currentTime - lastTime
                if (pressBool && timeDiff > playerRed.minTimeDistanceBullet) {
                    lastTime = currentTime

                    console.debug("Shoot Cannon")


                    var speed = (playerRed.activateAccelerator) ? 500 : 250

                    var xDirection = Math.cos(tankRed.tankCannon.rotation * Math.PI / 180.0) * speed
                    var yDirection = Math.sin(tankRed.tankCannon.rotation * Math.PI / 180.0) * speed

                    var startX= (45*Math.cos((tankRed.tankCannon.rotation)*Math.PI/180)) + tankRed.x + tankRed.width/2
                    var startY= (45*Math.sin((tankRed.tankCannon.rotation)*Math.PI/180)) + tankRed.y + tankRed.height/2

                    // create and remove entities at runtime
                    entityManager.createEntityFromComponentWithProperties(
                                bullet, {
                                    start: Qt.point(startX, startY),
                                    velocity: Qt.point(xDirection, yDirection)
                                });
                }
                pressBool= false
            }*/

            onPressed: {
                upDateCannon()
                pressBool= true
            }

            onReleased: {
                upDateCannon()
                var currentTime = new Date().getTime()
                var timeDiff = currentTime - lastTime

                if (pressBool && timeDiff > playerBlue.minTimeDistanceBullet) {

                    lastTime = currentTime

                    console.debug("Shoot Cannon")

                    var speed = (playerBlue.activateAccelerator) ? 500 : 250

                    var xDirection = Math.cos(tankBlue.tankCannon.rotation * Math.PI / 180.0) * speed
                    var yDirection = Math.sin(tankBlue.tankCannon.rotation * Math.PI / 180.0) * speed

                    var startX= (45*Math.cos((tankBlue.tankCannon.rotation)*Math.PI/180)) + tankBlue.x + tankBlue.width / 2
                    var startY= (45*Math.sin((tankBlue.tankCannon.rotation)*Math.PI/180)) + tankBlue.y + tankBlue.height / 2

                    // create and remove entities at runtime
                    entityManager.createEntityFromComponentWithProperties(
                                bullet, {
                                    start: Qt.point(startX, startY),
                                    velocity: Qt.point(xDirection, yDirection)
                                });
                }
                pressBool= false
            }

            function upDateCannon(){
                var x = point2.x
                var y = point2.y
                x = x - (playerBulletControlAreaBlue.width / 2)
                y = (y - (playerBulletControlAreaBlue.height / 2)) * (-1)

                var angle = calcAngle(x, y)
                tankBlue.tankCannon.rotation = angle
            }

            onEnabledChanged: {
                if(rotateOnce){
                tankBlue.tankCannon.rotation = 270
                rotateOnce = false
                }
            }
        }
    }

    onRedOnLake: {
        //GameInfo.redOnLake=true
        //playerMovementControlAreaRed.enabled=false;
    }
    onRedOffLake: {
        //GameInfo.redOnLake=false
        //playerMovementControlAreaRed.enabled=true;
    }

    onBlueOnLake: {
        playerMovementControlAreaBlue.enabled=false;
    }
    onBlueOffLake: {
        playerMovementControlAreaBlue.enabled=true;
    }



    PlayerRed {
        id: playerRed
    }

    PlayerBlue {
        id: playerBlue
    }

    Tank {
        id: tankRed
        x: scene.width / 2
        y: 100 + height/2
        z: 1
        entityId: "tank_0"
        rotation: 0
        //tankBody.source: "../../assets/img/charRed.png"
        tankBody.source: "../../assets/img/redBody.png"
        tankHead.source: "../../assets/img/redHead.png"
    }

    Tank {
        id: tankBlue
        x: scene.width / 2
        y: scene.height - 100 - height/2
        z: 1
        entityId: "tank_1"
        rotation: 0
        tankBody.source: "../../assets/img/blueBody.png"
        tankHead.source: "../../assets/img/blueHead.png"
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

                // handle the collision
                fixture.onBeginContact: {
                    var collidedEntity = other.parent.parent.parent;
                    //                    console.log("bullet collides with tank or something else:" + singleBullet.entityId + " / " + collidedEntity.entityId)

                    //   if(tankRed.entityId !== collidedEntity.entityId &&
                    //   tankBlue.entityId !== collidedEntity.entityId &&
                    //   collidedEntity.entityId !== "lake"){

                    var str = collidedEntity.entityId;
                    var resId = str.substring(0, 3);
                    // destroy bullet on collision with any component except lake and powerUpIcons
                    if(resId !== "lak" && resId !== "pow"){
                        console.log("bullet collides with:" + singleBullet.entityId + " / " + collidedEntity.entityId + " / " + resId)
                        singleBullet.destroy()
                    }

                    if(tankRed.entityId===collidedEntity.entityId){
                        if(!playerRed.activateShield && !playerRed.activateHitShield) {
                            playerRed.life = playerRed.life - ((playerBlue.activatePowershot) ? 2 : 1)
                            playerRed.activateHitShield = true
                            damage()
                        }
                    } else if(tankBlue.entityId===collidedEntity.entityId){
                        if(!playerBlue.activateShield && !playerBlue.activateHitShield) {
                            playerBlue.life = playerBlue.life - ((playerRed.activatePowershot) ? 2 : 1)
                            playerBlue.activateHitShield = true
                            damage()
                        }
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

    /*
    Text {
        z :1
        anchors.centerIn: parent
        color: "green"
        font.pixelSize: 50
        text: playerRed.life<=0 || playerBlue.life<=0 ? "Game Over" : ""
    }
    */

    function calcAngle(touchX, touchY) {
        //console.log("calcAngle: " + (-180 / Math.PI * Math.atan2(touchY, touchX)))
        return -180 / Math.PI * Math.atan2(touchY, touchX)
    }

    onDamage: {
        if (playerRed.life<=0){
            GameInfo.winnerRed=false
            GameInfo.redVictory+=1
        }

        if (playerBlue.life<=0){
            GameInfo.winnerRed=true
            GameInfo.blueVictory+=1
        }

        if (playerRed.life<=0||playerBlue.life<=0){
            gameOver()
        }

        if (GameInfo.blueVictory+GameInfo.redVictory>=GameInfo.maxGames){
            result()
        }
    }
}
