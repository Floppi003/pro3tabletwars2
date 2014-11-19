import VPlay 2.0
import QtQuick 2.0
GameWindow {

  PhysicsWorld {
    // set no gravity, the collider is not physics-based
  }

  Scene {

     EntityBase {

       entityId: "box1"
       entityType: "box"

       Image {
           id: boxImage
           source: "../assets/img/box.png"
       }

       BoxCollider {
         // the BoxCollider will not be affected by gravity or other applied physics forces
         collisionTestingOnlyMode: true

         // make the same size as the Image
         anchors.fill: boxImage

         fixture.onBeginContact: {
            // handle the collision and make the image semi-transparent
            boxImage.opacity = 0.5
         }
       }

       // moves the entity to x position 100 within 2 seconds
       NumberAnimation on x {
         to: 100
         duration: 2000
       }
     }
   }
}
