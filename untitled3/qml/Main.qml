import VPlay 2.0
import QtQuick 2.0

GameWindow {
    id: gameWindow

    // you get free licenseKeys as a V-Play customer or in your V-Play Trial
    // with a licenseKey, you get the best development experience:
    //  * No watermark shown
    //  * No license reminder every couple of minutes
    //  * No fading V-Play logo
    // you can generate one from http://v-play.net/license/trial, then enter it below:
    //licenseKey: "<generate one from http://v-play.net/license/trial>"

    activeScene: scene

    // the size of the Window can be changed at runtime by pressing Ctrl (or Cmd on Mac) + the number keys 1-8
    // the content of the logical scene size (480x320 for landscape mode by default) gets scaled to the window size based on the scaleMode
    // you can set this size to any resolution you would like your project to start with, most of the times the one of your main target device
    // this resolution is for iPhone 4 & iPhone 4S
    width: 960
    height: 640

    Scene {
        id: scene

        // the "logical size" - the scene content is auto-scaled to match the GameWindow size
        width: 480
        height: 320

        // background rectangle matching the logical scene size (= safe zone available on all devices)
        // see the tutorial "How to create mobile games for different screen sizes and resolutions" in the V-Play doc for more details on content scaling and safe zone
        Rectangle {
            id: rectangle
            anchors.fill: parent
            color: "grey"

            Text {
                id: textElement
                // qsTr() uses the internationalization feature for multi-language support
                text: qsTr("Hello World")
                color: "#ffffff"
                anchors.centerIn: parent
            }

            Loader { id: baseLoader }

            MouseArea {
                anchors.fill: parent

                // when the rectangle that fits the whole scene is pressed, change the background color and the text
                onPressed: {
                    textElement.text = qsTr("Scene-Rectangle is pressed at position " + mouse.x + "," + mouse.y)
                    rectangle.color = "black"
                    console.debug("pressed position:", mouse.x, mouse.y)
                    baseLoader.source = "SecondScene.qml"
                }

                onPositionChanged: {
                    textElement.text = qsTr("Scene-Rectangle is moved at position " + mouse.x + "," + mouse.y)
                    console.debug("mouseMoved or touchDragged position:", mouse.x, mouse.y)
                }

                // revert the text & color after the touch/mouse button was released
                // also States could be used for that - search for "QML States" in the doc
                onReleased: {
                    textElement.text = qsTr("Hello World")
                    rectangle.color = "grey"
                    console.debug("released position:", mouse.x, mouse.y)
                }
            }
        }// Rectangle with size of logical scene

        Image {
            id: vplayLogo
            source: "../assets/vplay-logo.png"

            // 50px is the "logical size" of the image, based on the scene size 480x320
            // on hd or hd2 displays, it will be shown at 100px (hd) or 200px (hd2)
            // thus this image should be at least 200px big to look crisp on all resolutions
            // for more details, look at the tutorial "How to create mobile games for different screen sizes and resolutions" in the V-Play doc
            width: 50
            height: 50

            // this positions it absolute right and bottom of the GameWindow
            // change resolutions with Ctrl (or Cmd on Mac) + the number keys 1-8 to see the effect
            anchors.right: scene.gameWindowAnchorItem.right
            anchors.bottom: scene.gameWindowAnchorItem.bottom

            // this animation sequence fades the V-Play logo in and out infinitely (by modifying its opacity property)
            SequentialAnimation on opacity {
                loops: Animation.Infinite
                PropertyAnimation {
                    to: 0
                    duration: 2000 // 2 seconds for fade out
                }
                PropertyAnimation {
                    to: 1
                    duration: 2000 // 2 seconds for fade in
                }
            }
        }

    }
}
