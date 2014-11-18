//![0]

/*
  In this demo you play a ninja and throw stars against invading monsters. It is a very simple game containing of only a single QML file with 150 lines of code.

  It features multi-resolution images, switching between 2 scenes, physics for collision detection, audio and animations for movement of the monsters and stars.

  This game idea and its image and audio resources are from the excellent cocos2d tutorial on Ray Wenderlich's site  http://www.raywenderlich.com/25736/how-to-make-a-simple-iphone-game-with-cocos2d-2-x-tutorial. The tutorial is written for the cocos2d-iphone version. In the cocos2d-x branch the same game is written in C++, which is added to the sources in the folder Demos/SimpleGameCocosNinja/cocos2d-x-Comparison folder.

  The very same game functionality as described in the tutorial is done with V-Play in this demo, to show how much code can be saved by using QML and the V-Play Gaming Components. In fact, the same game is implemented with less than 60% of the original source code in C++! From 369 lines of code only 150 remain with with V-Play.
*/
import VPlay 2.0
import QtQuick 2.0

GameWindow {
    // the size of the Window can be changed at runtime by pressing the number keys 1-7
    // the content of the logical scene size (480x320 by default) gets scaled to the window size based on the scaleMode
    width: 960
    height: 640

    // you get free licenseKeys as a V-Play customer or in your V-Play Trial
    // with a licenseKey, you get the best development experience:
    //  * No watermark shown
    //  * No license reminder every couple of minutes
    //  * No fading V-Play logo
    // you can generate one from http://v-play.net/license/trial, then enter it below:
    //licenseKey: "<generate one from http://v-play.net/license/trial>"

    // create a licenseKey to hide the splash screen
    property bool splashFinished: false
    onSplashScreenFinished: { splashFinished = true}


    // this gets set from Monster, after it reached the player and is read by the GameOverScene to display if the player has won or lost
    property bool gameWon

    property int monstersDestroyed
    onMonstersDestroyedChanged: {
        if(monstersDestroyed > 5) {
            // you won the game, shot at 5 monsters
            changeToGameOverScene(true)
        }
    }

    // for creating entities (monsters and projectiles) at runtime dynamically
    EntityManager {
        id: entityManager
        entityContainer: scene
    }

    BackgroundMusic {
        source: "../assets/snd/background-music-aac.wav" // will start playing automatically after loading
    }

    Rectangle {
        anchors.fill: parent
        color: "white" // make a white background for the window
    }

    Scene {
        id: scene
        // the "logical size" - the scene content is auto-scaled to match the GameWindow size
        width: 480
        height: 320

        PhysicsWorld {debugDrawVisible: false} // put it anywhere in the Scene, so the collision detection between monsters and projectiles can be done

        MultiResolutionImage {
            id: player
            anchors.verticalCenter: parent.verticalCenter
            source: "../assets/img/Player.png" // the correct image version is used, based on the GameWindow size
        }

        // the elements of a component don't get created immediately, but in addTarget()
        // the EntityBase could also be put into an own qml file (e.g. Monster.qml)
        Component {
            id: monster

            EntityBase {
                entityType: "monster" // required for removing all of these entities when the game is lost

                MultiResolutionImage {
                    id: monsterImage
                    source: "../assets/img/Target.png"
                }

                y: utils.generateRandomValueBetween(0, scene.height)

                NumberAnimation on x {
                    from: scene.width // start at the right side
                    to: -monsterImage.width // move the monster to the left side of the screen
                    duration: utils.generateRandomValueBetween(2000, 4000) // vary animation duration between 2-4 seconds for the 480 px scene width
                    onStopped: {
                        console.debug("monster reached base - change to gameover scene because the player lost")
                        changeToGameOverScene(false)
                    }
                }

                BoxCollider {
                    anchors.fill: monsterImage // make the collider as big as the image
                    collisionTestingOnlyMode: true // use Box2D only for collision detection, move the entity with the NumberAnimation above
                    fixture.onBeginContact: {

                        // if the collided type was a projectile, both can be destroyed and the player gets a point
                        var collidedEntity = other.parent.parent.parent
                        console.debug("collided with entity", collidedEntity.entityType)
                        // monsters could also collide with other monsters because they have a random speed - alternatively, collider categories could be used
                        if(collidedEntity.entityType === "projectile") {
                            monstersDestroyed++
                            // remove the projectile entity
                            collidedEntity.removeEntity()
                            // remove the monster
                            removeEntity()
                        }
                    }
                }// BoxCollider
            }// EntityBase
        }// Component

        Component {
            id: projectile

            EntityBase {
                entityType: "projectile"

                MultiResolutionImage {
                    id: monsterImage
                    source: "../assets/img/Projectile.png"
                }

                // these values can then be set when a new projectile is created in the MouseArea below
                property point destination
                property int moveDuration

                PropertyAnimation on x {
                    from: player.x
                    to: destination.x
                    duration: moveDuration
                }

                PropertyAnimation on y {
                    from: player.y
                    to: destination.y
                    duration: moveDuration
                }

                BoxCollider {
                    anchors.fill: monsterImage
                    collisionTestingOnlyMode: true
                }
            }// EntityBase
        }// Component

        SoundEffectVPlay {
            id: projectileCreationSound
            source: "../assets/snd/pew-pew-lei.wav" // gets played when a projectile is created below
        }

        MouseArea {
            anchors.fill: parent
            onReleased: {

                // see here for an explanation of this code: http://www.raywenderlich.com/25736/how-to-make-a-simple-iphone-game-with-cocos2d-2-x-tutorial

                // Determinie offset of player to touch location
                var offset = Qt.point(
                            mouseX - player.x,
                            mouseY - player.y
                            );

                // Bail out if we are shooting down or backwards
                if(offset.x <= 0)
                    return;

                // Determine where we wish to shoot the projectile to
                var realX = scene.gameWindowAnchorItem.width
                var ratio = offset.y / offset.x
                var realY = (realX * ratio) + player.y
                var destination = Qt.point(realX, realY)

                // Determine the length of how far we're shooting
                var offReal = Qt.point(realX - player.x, realY - player.y)
                var length = Math.sqrt(offReal.x*offReal.x + offReal.y*offReal.y)
                var velocity = 480 // speed of the projectile should be 480pt per second
                var realMoveDuration = length / velocity * 1000 // multiply by 1000 because duration of projectile is in milliseconds

                entityManager.createEntityFromComponentWithProperties(projectile, {"destination": destination, "moveDuration": realMoveDuration})

                projectileCreationSound.play()
            }
        }// onReleased
    }// MouseArea

    // switch to this scene, after the game was lost or won and it switches back to the gameScene after 3 seconds
    Scene {
        id: gameOverScene
        visible: false
        Text {
            anchors.centerIn: parent
            text: gameWon ? "You won :)" : "You lost"
        }

        onVisibleChanged: {
            if(visible) {
                returnToGameSceneTimer.start()  // make the scene invisible after 3 seconds, after it got visible
            }
        }

        Timer {
            id: returnToGameSceneTimer
            interval: 3000
            onTriggered: {
                scene.visible = true
                gameOverScene.visible = false
            }
        }
    }// GameOverScene

    Timer {
        running: scene.visible == true && splashFinished // only enable the creation timer, when the gameScene is visible
        repeat: true
        interval: 1000 // a new target(=monster) is spawned every second
        onTriggered: addTarget()
    }

    function addTarget() {
        console.debug("create a new monster")
        entityManager.createEntityFromComponent(monster)
    }

    function changeToGameOverScene(won) {

        gameWon = won

        gameOverScene.visible = true
        scene.visible = false

        // reset the game variables and remove all projectiles and monsters
        monstersDestroyed = 0
        entityManager.removeEntitiesByFilter(["projectile", "monster"])
    }
}
//![0]

