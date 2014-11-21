import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: shieldPowerUp
    entityType: "shieldPowerUp"

    property alias shieldPowerUpBody: shieldPowerUpBody
    property alias shieldPowerUpBodyInner: shieldPowerUpBodyInner
    property alias boxCollider: boxCollider

    Rectangle {
        id: shieldPowerUpBody
        width: 50
        height: 50
        rotation: 45
        color: "orange"
        Rectangle {
            id: shieldPowerUpBodyInner
            width: 30
            height: 30
            anchors.centerIn: shieldPowerUpBody
            color: "yellow"
        }
    }

    BoxCollider {
        id: boxCollider
        anchors.fill: shieldPowerUpBody
        anchors.centerIn: parent
        sensor:true

        fixture.onBeginContact: {
            var collidedEntity = other.parent.parent.parent;
            //var collidedEntity = collidedColliderComponent.parent;
            //console.log("onBeginContact: " + collidedEntity.entityId)

            if(tankRed.entityId === collidedEntity.entityId){
                playerRed.activateShield = true
                powerUpShield.destroy()
            } else if(tankBlue.entityId === collidedEntity.entityId){
                playerBlue.activateShield = true
                powerUpShield.destroy()
            }
        }
    }
}
