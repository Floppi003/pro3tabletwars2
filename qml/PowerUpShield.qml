import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: powShield
    entityType: "powShield"
    z: 1

//    property alias powShieldBody: powShieldBody
//    property alias powShieldBodyInner: powShieldBodyInner
//    property alias boxCollider: boxCollider

    Rectangle {
        id: powShieldBody
        width: 50
        height: 50
        rotation: 45
        color: "orange"
        Rectangle {
            id: powShieldBodyInner
            width: 30
            height: 30
            anchors.centerIn: powShieldBody
            color: "yellow"
        }
    }

    BoxCollider {
        id: boxCollider
        anchors.fill: powShieldBody
        anchors.centerIn: parent
        sensor:true

        fixture.onBeginContact: {

            var collidedEntity = other.parent.parent.parent;

            console.log("onBeginContact: " + collidedEntity.entityId)

            if(tankRed.entityId === collidedEntity.entityId){
                playerRed.activateShield = true
                powShield.destroy()
            } else if(tankBlue.entityId === collidedEntity.entityId){
                playerBlue.activateShield = true
                powShield.destroy()
            }
        }
    }
}
