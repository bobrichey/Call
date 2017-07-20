public class Tones
{
    int numVoices;
    
    /* 
    TODO - array handling (constructors?)
    
    int voice[numVoices]; 
    SndBuf buffer[numVoices];
    NRev rev[numVoices];
    Envelope env[numVoices];
    Pan2 pan[numVoices];
    
    string sampArray[50];
    float rates[10];
    */

    string className;
    dur ramp;
    int waitLowerBound;
    int waitUpperBound;
    int isOn;

    /**
     * plays samples stored in buffers via playTones function
     */
    fun void play()
    { 
        while (true)
        {
            if (isOn == 0)
            { 
                break;
            }
            spork ~ playTones();
            
            // wait before adding another shred
            Math.random2(waitLowerBound, waitUpperBound)::ms => now;
        }
    }
    
    /**
     * select buffer, set panning and rate, play sample, mark buffer
     * as "in use"
     */
    fun void playTones()
    {
        // implement in subclass
    }
    
    /**
     * turns play function on/off
     */
    fun void turnOn()
    {
        if (isOn == 0)
        {
            1 => isOn;
            <<< className+": ON", "" >>>;
            spork ~ play();
        }
        else
        {
            0 => isOn;
            <<< className+": OFF", "" >>>;   
        }
    }
    
    /**
     * returns the name of the class
     */
    fun string getClassName()
    {
        return className;
    }
}
