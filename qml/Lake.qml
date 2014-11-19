import QtQuick 2.0
import VPlay 2.0
import "levels"

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
        //anchors.fill: lakeBody
        width: lakeBody.width-140
        height: lakeBody.height-140

        anchors.centerIn: parent

        //sensor:true

        collisionTestingOnlyMode: true


        fixture.onBeginContact: {
            // handle the collision and make the image semi-transparent

            var collidedColliderComponent = other.parent.parent;
            var collidedEntity = collidedColliderComponent.parent;
            console.log("object collides with lake:" + collidedEntity.entityId)

            if("tank_1"===collidedEntity.entityId){
                tankRed.opacity = 0.5
                console.log("tankRed is inside the lake!")
                joystickRed.enabled=false;
            }

            if("tank_0"===collidedEntity.entityId){
                tankBlue.opacity = 0.5
                console.log("tankBlue is inside the lake!")
                joystickBlue.enabled=false;
            }

            console.log("contact!")
        }

        fixture.onEndContact: {
            // handle the collision and make the image visible

            var collidedColliderComponent = other.parent.parent;
            var collidedEntity = collidedColliderComponent.parent;
            console.log(collidedEntity.entityId)

            if("tank_1"===collidedEntity.entityId){
                tankRed.opacity = 1
                console.log("tankRed is outside the lake!")
                                joystickRed.enabled=true;
            }

            if("tank_0"===collidedEntity.entityId){
                tankBlue.opacity = 1
                console.log("tankBlue is outside the lake!")
                                joystickBlue.enabled=true;
            }

            console.log("contact!")
        }
    }
}
