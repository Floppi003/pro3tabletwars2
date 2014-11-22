import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: powAccelerator
    entityType: "powAccelerator"
    z: 1

    Rectangle {
        id: powAcceleratorBody
        width: 50
        height: 50
        rotation: 45
        color: "darkBlue"
        Rectangle {
            id: powAcceleratorBodyInner
            width: 30
            height: 30
            anchors.centerIn: powAcceleratorBody
            color: "lightBlue"
        }
    }

    BoxCollider {
        id: boxCollider
        anchors.fill: powAcceleratorBody
        anchors.centerIn: parent
        sensor:true

        fixture.onBeginContact: {
            var collidedEntity = other.parent.parent.parent;

            //console.log("onBeginContact: " + collidedEntity.entityId)

            if(tankRed.entityId === collidedEntity.entityId){
                playerRed.activateAccelerator = true
                powAccelerator.destroy()
            } else if(tankBlue.entityId === collidedEntity.entityId){
                playerBlue.activateAccelerator = true
                powAccelerator.destroy()
            }
        }
    }
}
