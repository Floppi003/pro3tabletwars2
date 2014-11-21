import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: obstacle
    entityType: "obstacle"

    property alias obstacleBody: obstacleBody
    property alias boxCollider: boxCollider

    Image {
        id: obstacleBody
        width: 40
        height: 40
        //rotation: 0
        anchors.centerIn: parent
    }

    BoxCollider {
        id: boxCollider

        // the image and the physics will use this size
        anchors.fill: obstacleBody

        anchors.centerIn: parent

        density: 100000000


        fixture.onBeginContact: {
            // handle the collision and make the image semi-transparent

            var collidedColliderComponent = other.parent.parent;
            var collidedEntity = collidedColliderComponent.parent;
            console.log("bullet collides with something:" + collidedEntity.entityId)


            if(tankRed.entityId===collidedEntity.entityId){
                tankRed.opacity = 0.2
                console.log("tankRed is inside the lake!")
                playerRed.life=playerRed.life-1

            }

            if(tankBlue.entityId===collidedEntity.entityId){
                tankBlue.opacity = 0.2
                console.log("tankRed is inside the lake!")
                playerBlue.life=playerBlue.life-1
            }
            damage()
            //window.state=""
        }

        fixture.onEndContact: {
            // handle the collision and make the image visible

            var collidedColliderComponent = other.parent.parent;
            var collidedEntity = collidedColliderComponent.parent;
            console.log(collidedEntity.entityId)

            if(tankRed.entityId===collidedEntity.entityId){
                tankRed.opacity = 1
                console.log("tankRed is free!")
            }

            if(tankBlue.entityId===collidedEntity.entityId){
                tankBlue.opacity = 1
                console.log("tankBlue is free!")
            }
            damage()
            console.log("bullet is gone!")
        }
    }
}
