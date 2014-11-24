import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: powLifeUp
    entityType: "powLifeUp"
    z: 1

    Rectangle {
        id: powLifeUpBody
        width: 50
        height: 50
        rotation: 45
        color: "darkRed"
        Rectangle {
            id: powLifeUpBodyInner
            width: 30
            height: 30
            anchors.centerIn: powLifeUpBody
            color: "red"
        }
    }

    BoxCollider {
        id: boxCollider
        anchors.fill: powLifeUpBody
        anchors.centerIn: parent
        sensor:true

        fixture.onBeginContact: {
            var collidedEntity = other.parent.parent.parent;

            //console.log("onBeginContact: " + collidedEntity.entityId)

            if(tankRed.entityId === collidedEntity.entityId){
                playerRed.life++
                powLifeUp.destroy()
            } else if(tankBlue.entityId === collidedEntity.entityId){
                playerBlue.life++
                powLifeUp.destroy()
            }
        }
    }
}
