import QtQuick 2.0
import VPlay 2.0

Item {
    id: levelBaseScene
    width: 768
    height: 1024

    // this will be displayed in the GameScene
    property string levelName
    // this is emitted whenever the rectangle has been tapped successfully, the GameScene will listen to this signal and increase the score
    signal rectanglePressed

    Rectangle {
        id: background
        color: "white"
        anchors.fill: parent
    }
}

