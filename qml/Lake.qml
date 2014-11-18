import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: obstacle
    entityType: "obstacle"

    property alias lakeBody: lakeBody
    property alias boxCollider: boxCollider

    Image {
        id: lakeBody
        width: 500
        height: 500
        //rotation: 0
        anchors.centerIn: parent
    }

    BoxCollider {
        id: boxCollider

        // the image and the physics will use this size
        anchors.fill: lakeBody

        anchors.centerIn: parent

        sensor:true
    }
}
