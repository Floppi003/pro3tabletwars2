import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: opponent
    entityType: "opponent"

    // make the twoAxisController acessible from outside
    property alias controller: twoAxisController
    property alias opponentBody: opponentBody
    property alias opponentCannon: opponentCannon
    property alias boxCollider: boxCollider

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
        targetObject: tankRed

        distanceToTargetThreshold: 100


        onTargetReached: {
            targetObject = tankBlue
        }
    }

    /*
    Timer {
        interval: 100; running: true; repeat: true;

        onTriggered: MoveToPointHelper.targetObject= tankBlue;


            var distanceRed = sqrt(pow(tankRed.x-opponent.x, 2) + pow(tankRed.y-opponent.y, 2));
            var distanceBlue = sqrt(pow(tankBlue.x-opponent.x, 2) + pow(tankBlue.y-opponent.y, 2));

            MoveToPointHelper.targetObject= (distanceRed >= distanceBlue) ? tankBlue : tankBlue;


    }
    */

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
}
