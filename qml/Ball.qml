import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: ball
    entityType: "ball"

    property alias obstacleBody: ballBody
    property alias boxCollider: boxCollider

    Image {
        id: ballBody
        width: 50
        height: 50
        //rotation: 0
        anchors.centerIn: parent
    }

    BoxCollider {
        id: boxCollider
        // the image and the physics will use this size
        anchors.fill: ballBody

        anchors.centerIn: parent
        friction: 1
        restitution: 1
        body.bullet: true
        body.linearDamping: 0.5
        body.angularDamping: 0
        density: 1

        // this is applied every physics update tick
        //linearVelocity: Qt.point(twoAxisController.xAxis * 100, twoAxisController.yAxis * (-100))
        //force: Qt.point(twoAxisController.xAxis * 1000, twoAxisController.yAxis * 1000)
        //torque: 1000
    }
}
