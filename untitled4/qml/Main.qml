import QtQuick 2.0
import VPlay 2.0

GameWindow {
    id: window
    width: 960
    height: 640

    // you get free licenseKeys as a V-Play customer or in your V-Play Trial
    // with a licenseKey, you get the best development experience:
    //  * No watermark shown
    //  * No license reminder every couple of minutes
    //  * No fading V-Play logo
    // you can generate one from http://v-play.net/license/trial, then enter it below:
    //licenseKey: "<generate one from http://v-play.net/license/trial>"

    // for creating and destroying entities at runtime (rockets)
    EntityManager {
        id: entityManager
        entityContainer: level
    }

    Scene {
        id: scene
        width: 640
        height: 640

        // background image
        Image {
            id: background
            source: "../assets/img/asphalt_background.png"
            // since we are using a simple Image element to define our background, we stretch it to avoid any kind of black borders on any device
            width: parent.width*1.8
            height: parent.height*1.8
            anchors.centerIn: parent
        }

        // use a physics world because we need collision detection
        PhysicsWorld {
            id: world
            updatesPerSecondForPhysics: 60
        }

        Level {
            // this gets accessed by its id from JoystickControllerHUD below
            id: level

        }

        focus: true
        // forward the input keys to both players
        Keys.forwardTo: [level.player_red.controller, level.player_blue.controller]
    }


    JoystickControllerHUD {
        anchors.bottom: parent.bottom

        // the joystick width is the space from the left to the start of the logical scene, so the radius is its half
        joystickRadius: scene.x/2


        // this allows setting custom images for the JoystickControllerHUD component
        source: "../assets/img/joystick_background.png"
        thumbSource: "../assets/img/joystick_thumb.png"


        // this is the mapping between the output of the JoystickControllerHUD to the input of the player's TwoAxisController
        // this is a performance improvement, to not have to bind every time the position changes
        property variant playerTwoxisController: level.player_red.getComponent("TwoAxisController")
        onControllerXPositionChanged: playerTwoxisController.xAxis = controllerXPosition;
        onControllerYPositionChanged: playerTwoxisController.yAxis = controllerYPosition;
    }
}


