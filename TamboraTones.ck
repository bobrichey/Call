/**
 * Plays sonorities from a tambora sample
 */
public class TamboraTones extends Tones
{
    10 => numVoices;

    int voice[numVoices]; 
    SndBuf buffer[numVoices];
    Envelope env[numVoices];
    Pan2 pan[numVoices];
    
    // playback rates
    [0.5, 0.625, 0.75, 1.0, 1.25, 1.5, 2.0] @=> float rates[];
    
    // set class, envelope ramp, wait bounds, starting position (on/off)
    "TamboraTones" => className;
    1000::ms => ramp;
    1500 => waitLowerBound;
    5000 => waitUpperBound;
    0 => isOn;
    
    // sound chain
    for (int i; i < numVoices; i++)
    {
        buffer[i] => env[i] => pan[i] => dac;
        env[i].duration(ramp);
        
        // set buffers
        me.dir() + "/Guitar Samples/tamb.wav" => buffer[i].read;
        buffer[i].samples() => buffer[i].pos;
    }  
    
    /**
    * select buffer, set gain/pan/rate, play sample, mark buffer
    * as "free"
    */
    fun void playTones()
    {
        getVoice() => int which;
        0 => buffer[which].pos;
        
        Math.random2f(0.3, 0.6) => buffer[which].gain;
        Math.random2f(-0.75, 0.75) => pan[which].pan;
        rates[Math.random2(0, rates.cap() - 1)] => float rate;
        rate => buffer[which].rate;
        
        // play, allowing slower rates to sound before fading out
        1 => env[which].keyOn;
        buffer[which].length() * 1.5 - ramp => now;
        1 => env[which].keyOff;
        ramp => now;
        
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
}