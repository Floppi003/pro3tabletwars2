import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: playerBlue
    entityType: "playerBlue"

    property int life: 3
    property bool activateShield: false // for activating powerUpShield
    property bool activeShield: false // powerUpShield

    Timer {
        id: timerBlue
        interval: 8000; running: true; repeat: true;

        //disable powerUpShield after 5 seconds
        onTriggered: {
            if(activateShield) {
                activeShield = true;
                activateShield = false;
            } else {
                activeShield = false;
            }
        }
    }
}
