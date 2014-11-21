import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: opponent
    entityType: "opponent"

    // make the twoAxisController acessible from outside
    property alias opponent: opponent
    property alias controller: twoAxisController
    property alias opponentBody: opponentBody
    property alias opponentCannon: opponentCannon
    property alias boxCollider: boxCollider
    property bool targetTankRed: true

    // this is used as input for the BoxCollider force & torque properties
    TwoAxisController {
        id: twoAxisController
    }

    Image {
        id: opponentBody
        width: 40
        height: 40
        //rotation: 0
        anchors.centerIn: parent
    }

    Rectangle {
        id: opponentCannon
        x: opponentBody.x + opponentBody.width / 2
        y: opponentBody.y + opponentBody.height / 2 - 2
        width: 26
        height: 4
        transformOrigin: Item.Left
        //transformOriginPoint: Qt.point(13, 2)
        color: "#000000"
    }

    BoxCollider {
        id: boxCollider

        // the image and the physics will use this size
        width: 40
        height: 40

        anchors.centerIn: parent

        friction: 0
        restitution: 0.0
        body.bullet: true
        body.linearDamping: 0
        body.angularDamping: 0
        density: 100000000

        // this is applied every physics update tick
        linearVelocity: Qt.point(twoAxisController.xAxis * 100, twoAxisController.yAxis * (-100))
        //force: Qt.point(twoAxisController.xAxis * 1000, twoAxisController.yAxis * 1000)
        //torque: 1000
    }

    MoveToPointHelper {
        id: moveToPointHelper
        // the entity to move towards
        targetObject: targetTankRed ? tankRed : tankBlue;

        distanceToTargetThreshold: 100

        Timer {
            interval: 100; running: true; repeat: true;

            onTriggered: {
                //MoveToPointHelper.targetObject = tankBlue;

                var distanceRed = Math.sqrt(Math.pow(tankRed.x - opponent.x, 2) + Math.pow(tankRed.y - opponent.y, 2));
                var distanceBlue = Math.sqrt(Math.pow(tankBlue.x - opponent.x, 2) + Math.pow(tankBlue.y - opponent.y, 2));
                targetTankRed = (distanceRed >= distanceBlue) ? false : true;
            }
        }

        onTargetItemChanged: {
            console.log("Opponent Snowman: onTargetItemChanged")
            var speed = 250
            var xDirection = Math.cos(opponent.opponentCannon.rotation * Math.PI / 180.0) * speed
            var yDirection = Math.sin(opponent.opponentCannon.rotation * Math.PI / 180.0) * speed

            // create and remove entities at runtime
            entityManager.createEntityFromComponentWithProperties(
                        bulletOpponent, {
                            start: Qt.point(opponent.x, opponent.y + 35),
                            velocity: Qt.point(xDirection, yDirection)
                        });
        }
    }

    MovementAnimation {
        target: opponent
        property: "rotation"

        // outputXAxis is +1 if target is to the right, -1 when to the left and 0 when aiming towards it
        velocity: 300*moveToPointHelper.outputXAxis
        // alternatively, also the acceleration could be set, depends on how you want the followerEntity to behave

        // start rotating towards the target immediately
        running: true

        // this avoids over-rotating, so rotating further than allowed
        maxPropertyValueDifference: moveToPointHelper.absoluteRotationDifference
    }

    Component {
        id: bulletOpponent

        EntityBase {
            id: singleBulletOpponent
            entityType: "singleBulletOpponent"

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

                    if(collidedEntity.entityId !== opponent.entityId && collidedEntity.entityId !== lake.entityId){
                        console.log("opponent bullet collides with another object:" + singleBulletOpponent.entityId + " / " + collidedEntity.entityId)
                        singleBulletOpponent.destroy()
                    }

                    if(tankRed.entityId === collidedEntity.entityId){
                        //tankRed.opacity = 0.2
//                        console.log("tankRed hit!")
                        playerRed.life = playerRed.life - 1
                        damage()
                    } else if(tankBlue.entityId === collidedEntity.entityId){
                        //tankBlue.opacity = 0.2
//                        console.log("tankBlue hit!")
                        playerBlue.life = playerBlue.life - 1
                        damage()
                    }
                }
            }

            MovementAnimation {
                target: singleBulletOpponent

                property: "x"
                velocity: singleBulletOpponent.velocity.x
                running: true
            }

            MovementAnimation {
                target: singleBulletOpponent

                property: "y"
                velocity: singleBulletOpponent.velocity.y
                running: true
                onStopped: {
                    singleBulletOpponent.destroy()
                }
            }
        }
    }
}
