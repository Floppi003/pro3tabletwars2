import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: powerUpShield
    entityType: "powerUpShield"

    property alias powerUpShieldBody: powerUpShieldBody
    property alias boxCollider: boxCollider

    Rectangle {
        id: powerUpShieldBody
        width: 50
        height: 50
        rotation: 45
        color: "orange"

        Rectangle {
            id: powerUpShieldBodyInner
            width: 30
            height: 30
            anchors.centerIn: parent
            color: "yellow"
        }
    }

    BoxCollider {
        id: boxCollider
        anchors.fill: powerUpShieldBody
        anchors.centerIn: parent
        sensor:true

        fixture.onBeginContact: {
            var collidedColliderComponent = other.parent.parent;
            var collidedEntity = collidedColliderComponent.parent;
            console.log("onBeginContact: " + collidedEntity.entityId)

            if(tankRed.entityId === collidedEntity.entityId){
                playerRed.activateShield = true
            } else if(tankBlue.entityId === collidedEntity.entityId){
                playerBlue.activateShield = true
            }
            powerUpShield.destroy()
        }
    }
}
