import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: powPowershot
    entityType: "powPowershot"
    z: 1

    Rectangle {
        id: powPowershotBody
        width: 50
        height: 50
        rotation: 45
        color: "darkGreen"
        Rectangle {
            id: powPowershotBodyInner
            width: 30
            height: 30
            anchors.centerIn: powPowershotBody
            color: "lightGreen"
        }
    }

    BoxCollider {
        id: boxCollider
        anchors.fill: powPowershotBody
        anchors.centerIn: parent
        sensor:true

        fixture.onBeginContact: {
            var collidedEntity = other.parent.parent.parent;

            //console.log("onBeginContact: " + collidedEntity.entityId)

            if(tankRed.entityId === collidedEntity.entityId){
                playerRed.activatePowershot = true
                powPowershot.destroy()
            } else if(tankBlue.entityId === collidedEntity.entityId){
                playerBlue.activatePowershot = true
                powPowershot.destroy()
            }
        }
    }
}
