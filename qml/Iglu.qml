import QtQuick 2.0
import VPlay 2.0
import "levels"

EntityBase {
    z: 1
    id: iglu
    entityId: "iglu"
    entityType: "iglu"

    property alias igluBody: igluBody
    property alias porter: porter
    property alias rectColliderLeft: rectColliderLeft
    property alias rectColliderRight: rectColliderRight
    /*
    property JoystickControllerHUD joystickRed
    property JoystickControllerHUD joystickBlue
*/
    Image {
        id: igluBody
        width: 150
        height: 180
        //rotation: 0
        anchors.centerIn: parent
    }

    PolygonCollider {
        bodyType: Body.Static
        //density: 100000000
        id: rectColliderLeft

        /*
        vertices: [
            Qt.point(igluBody.x,igluBody.y),
            Qt.point(igluBody.x+igluBody.width, igluBody.y),
            Qt.point(igluBody.x+igluBody.width, igluBody.y+igluBody.height),
            Qt.point(igluBody.x, igluBody.y+igluBody.height)
        ]
        */
        vertices: [
            Qt.point(igluBody.x + igluBody.width/5, igluBody.y),
            Qt.point(igluBody.x, igluBody.y + igluBody.height/2),
            Qt.point(igluBody.x + igluBody.width/7, igluBody.y + igluBody.height/7*6),
            Qt.point(igluBody.x + igluBody.width/2, igluBody.y+igluBody.height)
        ]

        anchors.centerIn: parent
    }

    PolygonCollider {
        bodyType: Body.Static
        //density: 100000000
        id: rectColliderRight

        /*
        vertices: [
            Qt.point(igluBody.x,igluBody.y),
            Qt.point(igluBody.x+igluBody.width, igluBody.y),
            Qt.point(igluBody.x+igluBody.width, igluBody.y+igluBody.height),
            Qt.point(igluBody.x, igluBody.y+igluBody.height)
        ]
        */
        vertices: [
            Qt.point(igluBody.x + igluBody.width/5*4, igluBody.y),
            Qt.point(igluBody.x + igluBody.width, igluBody.y + igluBody.height/2),
            Qt.point(igluBody.x + igluBody.width/7*6, igluBody.y + igluBody.height/7*6),
            Qt.point(igluBody.x+igluBody.width/2, igluBody.y+igluBody.height)
        ]

        anchors.centerIn: parent
    }

    BoxCollider {
        density: 100000000
        id: porter

        //anchors.fill: igluBody
        width: igluBody.width/3
        height: igluBody.height/3

        anchors.centerIn: parent
        //anchors.top: igluBody.top+igluBody.height/3*2
        //anchors.horizontalCenter: igluBody.horizontalCenter

        //sensor:true

        collisionTestingOnlyMode: true

        fixture.onBeginContact: {
            var collidedColliderComponent = other.parent.parent;
            var collidedEntity = collidedColliderComponent.parent;

            if(tankRed.entityId === collidedEntity.entityId){
                tankRed.x = 100
                tankRed.y = 100
            }

            if(tankBlue.entityId === collidedEntity.entityId){
                tankBlue.x = 100
                tankBlue.y = 100
            }
        }
        /*
        fixture.onEndContact: {
            var collidedColliderComponent = other.parent.parent;
            var collidedEntity = collidedColliderComponent.parent;

            if(tankRed.entityId ===collidedEntity.entityId){
                tankRed.opacity = 1
                joystickRed.enabled=true;
            }

            if(tankBlue.entityId ===collidedEntity.entityId){
                tankBlue.opacity = 1
                joystickBlue.enabled=true;
            }
        }
        */
    }
}
