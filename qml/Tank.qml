import QtQuick 2.0
import VPlay 2.0

EntityBase {
    entityType: "tank"
    id: tank

    // make the twoAxisController acessible from outside
    property alias controller: twoAxisController
    property alias tankBody: tankBody
    property alias tankCannon: tankCannon
    property alias boxCollider: boxCollider

    property int life: 3
        // flag indicating if dead
     property bool gameRunning: life == 0


    // this is used as input for the BoxCollider force & torque properties
    TwoAxisController {
        id: twoAxisController
    }

    Image {
        id: tankBody
        width: 40
        height: 40
        //rotation: 0
        anchors.centerIn: parent
    }

    Rectangle {
        id: tankCannon

        x: tankBody.x + tankBody.width / 2
        y: tankBody.y + tankBody.height / 2 - 2
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

        density: 1
        friction: 1
        restitution: 1.0
        body.bullet: true
        body.linearDamping: 0
        body.angularDamping: 1

        // this is applied every physics update tick
        linearVelocity: Qt.point(twoAxisController.xAxis * 100, twoAxisController.yAxis * (-100))
        //force: Qt.point(twoAxisController.xAxis * 1000, twoAxisController.yAxis * 1000)
        //torque: 1000
    }
}

