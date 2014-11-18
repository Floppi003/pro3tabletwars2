import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: obstacle
    entityType: "obstacle"

    property alias obstacleBody: obstacleBody
    property alias boxCollider: boxCollider

    Image {
        id: obstacleBody
        width: 40
        height: 40
        //rotation: 0
        anchors.centerIn: parent
    }

    BoxCollider {
        id: boxCollider

        // the image and the physics will use this size
        width: 40
        height: 40

        anchors.centerIn: parent


        density: 1
        friction: 1
        restitution: 1.0
        body.bullet: true
        body.linearDamping: 1
        body.angularDamping: 1


        // this is applied every physics update tick
        //linearVelocity: Qt.point(twoAxisController.xAxis * 100, twoAxisController.yAxis * (-100))


        //force: Qt.point(twoAxisController.xAxis * 1000, twoAxisController.yAxis * 1000)
        //torque: 1000
    }
}
