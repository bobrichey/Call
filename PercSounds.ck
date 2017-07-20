public class PercSounds
{
    SndBuf buffer => Gain input => Envelope env => dac; 
    
    Delay del[3]; 
    
    input => del[0] => dac.left; 
    input => del[1] => dac;
    input => del[2] => dac.right; 
    
    // set up delay lines 
    for (0 => int i; i < 3; i++) 
    {
        del[i] => del[i]; 
    }
    
    float inputGain;
    float gainIncrement;
    
    int tempo;   
    int tempoIncrement;
    int maxTempo;
    
    // determines if playback rate of samples is altered
    int alterPlaybackRate;
    
    dur ramp;
    env.duration(ramp);
    
    // TODO - fix array size, method of allocation and choosing sample playback (line 50)
    int arraySize;
    string sampArray[50];
    
    string className;

    int isOn;
    
    /**
     * plays samples stored sampArray through buffer
     */
    fun void play()
    { 
        while (true)
        {
            if (isOn == 0)
            { 
                break;
            }
            inputGain => input.gain;
            
            me.dir() + "/Guitar Samples" + 
            sampArray[Math.random2(0, arraySize - 1)] => buffer.read;
            
            if (alterPlaybackRate == 1) 
            {
                Math.random2f(0.5, 2) => buffer.rate;
            }
            
            1 => env.keyOn; 
            tempo::ms => now;   
            1 => env.keyOff;
        }
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
    
    /**
     * increase and print current gain to console
     */
    fun void increaseGain()
    {
        gainIncrement +=> inputGain;
        
        // prevent gain from going above 1.0
        if (inputGain >= 1.0)
        {
            1.0 => inputGain;
        }
        <<< "Increase", className, "gain to:", Std.ftoa(inputGain, 1) >>>;
    }
    
    /**
     * decrease and print current gain to console
     */
    fun void decreaseGain()
    {
        gainIncrement -=> inputGain;
        
        // prevent gain from going below 0.0
        if (inputGain <= 0.0)
        {
            0.0 => inputGain;
        }
        <<< "Decrease", className, "gain to:", Std.ftoa(inputGain, 1) >>>;
    }
    
    /**
     * increase and print current tempo to console
     */
    fun void increaseTempo()
    {
        tempoIncrement -=> tempo;
        if (tempo <= maxTempo)
        {
            maxTempo => tempo;
        }
        <<< "Increase", className, "tempo to:", tempo, "ms" >>>;
    }
    
    /**
     * decrease and print current tempo to console
     */
    fun void decreaseTempo()
    {
        tempoIncrement +=> tempo;
        <<< "Decrease", className, "tempo to:", tempo, "ms" >>>;
    }
}
