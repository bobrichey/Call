/*
Program:
Name: Bob Richey
Date: 1/4/2015
*/

Hid hid;

HidMsg msg;

0 => int device;

if (hid.openKeyboard(device) == false) me.exit();

<<< "msg.asciiboard:", hid.name(), "ready!" >>>;

// CLASSES

// superclasses
// PercSounds percSounds;
// Tones tones;

OctatonicTones octatonic;
PentatonicTones pentatonic;
TamboraTones tambora;
PizzDelay pizzDelay;
SnapDelay snapDelay;
PercDelay percDelay;

string editUGen;

// MAIN LOOP

while (true)
{
    hid => now;
    
    while (hid.recv(msg))
    {
        if (msg.isButtonDown()) 
        {   
            if (msg.ascii == 67) // C
            {
                octatonic.turnOn();
            }
            else if (msg.ascii == 83) // S
            {
                Machine.add(me.dir() + "/2 - LiSa2.ck");
            }
            else if (msg.ascii == 88) // X
            {
                Machine.add(me.dir() + "/2 - LiSa.ck");
            }
            else if (msg.ascii == 90) // Z
            {
                Machine.add(me.dir() + "/llamada2.ck");
            }
            else if (msg.ascii == 65) // A
            {
                Machine.add(me.dir() + "/llamada 1.ck");
            }
            else if (msg.ascii == 91) // [
            {
                Machine.add(me.dir() + "/1 - LiSa.ck");
            }
            else if (msg.ascii == 39) // APOSTROPHE(')
            {
                Machine.add(me.dir() + "/1 - llamada.ck");
            }
            else if (msg.ascii == 93) // ]
            {
                pentatonic.turnOn();
            }
            else if (msg.ascii == 92) // BACK SLASH(\)
            {
                tambora.turnOn();
            }
            else if (msg.ascii == 45) // DASH(-)
            {
                Machine.add(me.dir() + "/4 - LiSa1.ck");
            }
            else if (msg.ascii == 61) // EQUALS(=)
            {
                Machine.add(me.dir() + "/4 - LiSa2.ck");
            }
            else if (msg.ascii == 86) // V
            {
                pizzDelay.turnOn();
            }
            else if (msg.ascii == 66) // B
            {
                snapDelay.turnOn();
            }
            else if (msg.ascii == 78) // N
            {
                percDelay.turnOn();
            }
            else if (msg.ascii == 32) // SPACE
            {
                Machine.add(me.dir() + "/coda.ck");
            }
            else if (msg.ascii == 70) // F
            {
                setUGen(pizzDelay.getClassName());
            }
            else if (msg.ascii == 68) // D
            {
                setUGen(octatonic.getClassName());
            }        
            else if (msg.ascii == 71) // G
            {
                setUGen(snapDelay.getClassName());
            }     
            else if (msg.ascii == 72) // H
            {
                setUGen(percDelay.getClassName());
            } 
            else if (msg.ascii == 75) // K
            {
                if (editUGen == pizzDelay.getClassName())
                {
                    pizzDelay.increaseGain();
                }
                else if (editUGen == snapDelay.getClassName())
                {
                    snapDelay.increaseGain();
                }
                else if (editUGen == percDelay.getClassName())
                {
                    percDelay.increaseGain();
                }
                else if (editUGen == octatonic.getClassName())
                {
                    octatonic.increaseGain();
                }
                else
                {
                    errorMessage(1);
                }
            }
            else if (msg.ascii == 44) // COMMA(,)
            {
                if (editUGen == pizzDelay.getClassName())
                {
                    pizzDelay.decreaseGain();
                }
                else if (editUGen == snapDelay.getClassName())
                {
                    snapDelay.decreaseGain();
                }
                else if (editUGen == percDelay.getClassName())
                {
                    percDelay.decreaseGain();
                }
                else if (editUGen == octatonic.getClassName())
                {
                    octatonic.decreaseGain();
                }                
                else
                {
                    errorMessage(1);
                }
            }
            else if (msg.ascii == 76) // L
            {
                if (editUGen == pizzDelay.getClassName())
                {
                    pizzDelay.increaseTempo();
                }
                else if (editUGen == snapDelay.getClassName())
                {
                    snapDelay.increaseTempo();
                }
                else if (editUGen == percDelay.getClassName())
                {
                    percDelay.increaseTempo();
                }
                else
                {
                    errorMessage(1);
                }
            }
            else if (msg.ascii == 46) // PERIOD(.)
            {
                if (editUGen == pizzDelay.getClassName())
                {
                    pizzDelay.decreaseTempo();
                }
                else if (editUGen == snapDelay.getClassName())
                {
                    snapDelay.decreaseTempo();
                }
                else if (editUGen == percDelay.getClassName())
                {
                    percDelay.decreaseTempo();
                }
                else
                {
                    errorMessage(1);
                }
            }
            else
            {
                errorMessage(0);
            }
        }
    }
}

fun void setUGen(string uGen)
{
    uGen => editUGen;
    <<< "EDITING:", editUGen, "" >>>;
}

fun void errorMessage(int errorNumber)
{
    if (errorNumber == 1)
    {
        <<< "ERROR: NO UGEN SELECTED", "" >>>;
    }
    else
    {
        <<< "ERROR: INVALID INPUT", msg.ascii >>>;
    }
}