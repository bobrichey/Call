/**
 * Plays guitar samples from the octatonic scale
 */

public class OctatonicTones extends Tones
{
    8 => numVoices;
    
    int voice[numVoices]; 
    SndBuf buffer[numVoices];
    NRev rev[numVoices];
    Envelope env[numVoices];
    Pan2 pan[numVoices];
    
    // octatonic samples
    ["/long A.wav", "/long Bb.wav", "/long C.wav", "/long C#.wav",
    "/long D#.wav", "/long E.wav", "/long F#.wav", "/long G.wav"
    ] @=> string sampArray[];
    
    // playback rates
    [1.0, 2.0, 4.0, 8.0, 16.0, 16.0] @=> float rates[];
    
    0.4 => float inputGain;
    0.1 => float gainIncrement;
    
    "OctatonicTones" => className;
    1000 => waitLowerBound;
    3000 => waitUpperBound;
    800::ms => dur envDuration;
    0 => isOn;
    
    // sound chain
    for (0 => int i; i < numVoices; i++)
    {
        buffer[i] => rev[i] => env[i] => pan[i] => dac;
        
        0.15 => rev[i].mix;
        envDuration => env[i].duration;
        
        // set up buffers
        me.dir() + "Guitar Samples" + sampArray[i] => buffer[i].read;
        buffer[i].samples() => buffer[i].pos;
    }
    
    /**
     * select buffer, set gain/panning/rate, set env ramp based on rate,
     * mark buffer as "free"
     */
    fun void playTones()
    {
        getVoice() => int which;
        0 => buffer[which].pos;
        
        inputGain => buffer[which].gain;
        
        Math.random2f(-1.0, 1.0) => pan[which].pan;
        
        rates[Math.random2(0, rates.cap() - 1)] => float rate;
        rate => buffer[which].rate;
        
        5000::ms => dur ringTime;
        
        1 => env[which].keyOn;
        if (rate < 2.0)
        {
            ringTime => now;
        }
        else
        {
            // divide sample length by rate so it rings for the modified sample duration
            (buffer[which].length() / rate - envDuration) => now;
        }
        1 => env[which].keyOff;
        envDuration => now;
        
        0 => voice[which];
    }
    
    /**
     * select which buffer is going to be used for sample playback
     */
    fun int getVoice()
    {
        while (true)
        {
            Math.random2(0, numVoices - 1) => int n;
            5::ms => now;
            if (voice[n] == 0)
            {            
                1 => voice[n];
                return n;
            }
        }
    }
    
    /**
     * increase and print current gain to console
     */
    fun void increaseGain()
    {
        gainIncrement +=> inputGain;
        
        // prevent gain from going above 1.5
        if (inputGain >= 1.5)
        {
            1.5 => inputGain;
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
}
