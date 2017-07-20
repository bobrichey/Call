/**
 * Plays notes from the A maj pentatonic scale
 */

// TODO - BE AWARE ENVELOPE NOT CURRENTLY PATCHED TO DAC

public class PentatonicTones extends Tones
{
    13 => numVoices;
    
    int voice[numVoices]; 
    SndBuf buffer[numVoices];
    NRev rev[numVoices];
    Envelope env[numVoices];
    Pan2 pan[numVoices];
        
    // A Maj pentatonic pitches
    ["/A2.wav", "/A3.wav", "/A4.wav", "/B1.wav", "/B3.wav",
    "/B4.wav", "/C#1.wav", "/C#2.wav", "/C#3.wav", "/E2.wav", 
    "/F#2.wav", "/F#3.wav", "/F#4.wav"] @=> string sampArray[];
    
    // playback rates
    [1.0, 1.0, 1.0, 0.5, 0.25, 0.125] @=> float rates[];
    
    // set class name, envelope ramp, wait bounds, starting position (on/off)
    "PentatonicTones" => className;
    3000::ms => ramp;
    300 => waitLowerBound;
    3000 => waitUpperBound;
    0 => isOn;

    // sound chain
    for (0 => int i; i < numVoices; i++)
    {
        buffer[i] => rev[i] => pan[i] => dac;
        
        // set gain, envelope, reverb
        0.08 => buffer[i].gain;  
        ramp => env[i].duration;
        0.6 => rev[i].mix;
        
        // set buffers
        me.dir() + "/Guitar Samples" + sampArray[i] => buffer[i].read;
        buffer[i].samples() => buffer[i].pos;
    }
    
    /**
     * select buffer, set panning and rate, play sample, mark buffer
     * as "free"
     */
    fun void playTones()
    {
        getVoice() => int which;
        0 => buffer[which].pos;
        
        Math.random2f(-1, 1) => pan[which].pan;
        
        rates[Math.random2(0, rates.cap() - 1)] => float rate;
        rate => buffer[which].rate;
        
        1 => env[which].keyOn;
        buffer[which].length() + 500::ms => now;
        
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
