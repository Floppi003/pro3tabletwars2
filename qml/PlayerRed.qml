import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: playerRed
    entityType: "playerRed"

// signal damageRed

    property int life: 3
    property bool activateShield: false // for activating powerUpShield
    property int activeShieldCounter: 0 // count from 0 to 80 every 100 millisecond for the duration of active powerUps
    property bool activateAccelerator: false // for activating powerUpAccelerator
    property int activeAcceleratorCounter: 0 // count from 0 to 80 every 100 millisecond for the duration of active powerUps
    property bool activatePowershot: false // for activating powerUpPowershot
    property int activePowershotCounter: 0 // count from 0 to 80 every 100 millisecond for the duration of active powerUps

    Timer {
        id: timerRed
        interval: 100; running: true; repeat: true;

        //disable powerUpShield after 5 seconds
        onTriggered: {
            //console.log ("activateShield: " + activateShield + " / " + activeShieldCounter)
            if (activateShield) { activeShieldCounter++; }
            if (activeShieldCounter === 80) { activateShield = false; activeShieldCounter = 0; }

            //console.log ("activateAccelerator: " + activateAccelerator + " / " + activeAcceleratorCounter)
            if (activateAccelerator) { activeAcceleratorCounter++ }
            if (activeAcceleratorCounter === 80) { activateAccelerator = false; activeAcceleratorCounter = 0; }

            //console.log ("activatePowershot: " + activatePowershot + " / " + activePowershotCounter)
            if (activatePowershot) { activePowershotCounter++ }
            if (activePowershotCounter === 80) { activatePowershot = false; activePowershotCounter = 0; }
        }
    }
}


