import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: playerBlue
    entityType: "playerBlue"

    property int life: 3
    property bool activateShield: false // for activating powerUpShield
    property int activeShieldCounter: 0 // count from 0 to 80 every 100 millisecond for the duration of active powerUps
    property bool activateAccelerator: false // for activating powerUpAccelerator
    property int activeAcceleratorCounter: 0 // count from 0 to 80 every 100 millisecond for the duration of active powerUps

    Timer {
        id: timerBlue
        interval: 100; running: true; repeat: true;

        //enable or disable powerUps for 5 seconds
        onTriggered: {
            //console.log ("activateShield: " + activateShield + " / " + activeShieldCounter)
            if (activateShield) { activeShieldCounter++; }
            if (activeShieldCounter === 80) { activateShield = false; activeShieldCounter = 0; }

            //console.log ("activateAccelerator: " + activateAccelerator + " / " + activeAcceleratorCounter)
            if (activateAccelerator) { activeAcceleratorCounter++ }
            if (activeAcceleratorCounter === 80) { activateAccelerator = false; activeAcceleratorCounter = 0; }
        }
    }
}
