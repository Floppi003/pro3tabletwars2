import QtQuick 2.0
import VPlay 2.0
import "levels"

EntityBase {
    z: 1
    id: iglu
    entityId: "iglu"
    entityType: "iglu"

    property int igluCount
    property alias igluBody: igluBody
    property alias porter: porter
    property alias rectColliderLeft: rectColliderLeft
    property alias rectColliderRight: rectColliderRight
    // property alias rectColliderBottom: rectColliderBottom
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


        vertices: [
            Qt.point(igluBody.x + igluBody.width/5*4, igluBody.y),
            Qt.point(igluBody.x + igluBody.width, igluBody.y + igluBody.height/2),
            Qt.point(igluBody.x + igluBody.width/7*6, igluBody.y + igluBody.height/7*6),
            Qt.point(igluBody.x+igluBody.width/2, igluBody.y+igluBody.height)
        ]

        anchors.centerIn: parent
    }

    PolygonCollider {
        bodyType: Body.Static
        //density: 100000000
        id: rectColliderBottom

        vertices: [
            Qt.point(igluBody.x + igluBody.width/5, igluBody.y + igluBody.height/5*2),
            Qt.point(igluBody.x + igluBody.width/5*4, igluBody.y + igluBody.height/5*2),
            Qt.point(igluBody.x+igluBody.width/2, igluBody.y+igluBody.height)
        ]

        anchors.centerIn: parent
    }

    BoxCollider {
        density: 100000000
        id: porter

        //anchors.fill: igluBody
        width: igluBody.width/2
        height: igluBody.height/2

        anchors.centerIn: parent
        //anchors.top: igluBody.top+igluBody.height/3*2
        //anchors.horizontalCenter: igluBody.horizontalCenter

        //sensor:true

        collisionTestingOnlyMode: true

        fixture.onBeginContact: {
            var collidedColliderComponent = other.parent.parent;
            var collidedEntity = collidedColliderComponent.parent;

            var random = Math.ceil(Math.random() * igluCount);
            console.debug("Random: " + random)
            var igluX
            var igluY
            var igluR



            if (random == 1){
                igluX = iglu1.x + (iglu1.width/2)
                igluY = iglu1.y
                igluR = iglu1.rotation
            }else if (random == 2){
                igluX = iglu2.x + (iglu2.width/2)
                igluY = iglu2.y
                igluR = iglu2.rotation
            }else{
                igluX = iglu3.x + (iglu3.width/2)
                igluY = iglu3.y
                igluR = iglu3.rotation
            }

            if(tankRed.entityId === collidedEntity.entityId){
                tankRed.x = igluX
                tankRed.y = igluY
                tankRed.rotation = igluR
            }

            if(tankBlue.entityId === collidedEntity.entityId){
                tankBlue.x = igluX
                tankBlue.y = igluY
                tankBlue.rotation = igluR
            }
        }
    }
}
