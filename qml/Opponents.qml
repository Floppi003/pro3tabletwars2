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
}
