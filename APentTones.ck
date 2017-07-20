public class APentTones
{
    13 => int numVoices;
    
    int voice[numVoices]; 
    SndBuf s[numVoices];
    NRev r[numVoices];
    Envelope e[numVoices];
    Pan2 p[numVoices];
    
    3000::ms => dur ramp;
    
    // A Maj pent pitches
    ["/A2.wav", "/A3.wav", "/A4.wav", "/B1.wav", "/B3.wav",
    "/B4.wav", "/C#1.wav", "/C#2.wav", "/C#3.wav", "/E2.wav", 
    "/F#2.wav", "/F#3.wav", "/F#4.wav"] @=> string aPent[];
    
    
    for (0 => int i; i < numVoices; i++)
    {
        s[i] => r[i] => p[i] => dac;
        0.08 => s[i].gain;  
        ramp => e[i].duration;
        0.6 => r[i].mix;
        me.dir() + "/Guitar Samples" + aPent[i] => s[i].read;
        s[i].samples() => s[i].pos;
    }
    
    
    [1.0, 1.0, 1.0, 0.5, 0.25, 0.125] @=> float rates[];
    
    
    0 => int isOn;
    
    "APentTones" => string className;
    
    fun void play()
    { 
        while (true)
        {
            if (isOn % 2 == 0)
            { 
                break;
            }
            spork ~ playTones();
            Math.random2(300, 3000)::ms => now;
        }
    }
    
    fun void playTones()
    {
        getVoice() => int which;
        if (which > -1)
        {
            0 => s[which].pos;
            Math.random2f(-1, 1) => p[which].pan;
            rates[Math.random2(0, rates.cap() - 1)] => float rate;
            rate => s[which].rate;
            1 => e[which].keyOn;
            s[which].length() + 500::ms => now;
            //1 => e[which].keyOff;
            //ramp => now;
            0 => voice[which];
        }
    }

    
    fun int getVoice()
    {
        while (true)
        {
            Math.random2(0, numVoices - 1) => int i;
            5::ms => now;
            if (voice[i] == 0)
            {            
                1 => voice[i];
                return i;
            }
        }
        //return -1;
    }
    
    fun void turnOn()
    {
        isOn++;
        if (isOn % 2 == 1)
        {
            <<< className+": ON", "" >>>;
            spork ~ play();
        }
        else
        {
            <<< className+": OFF", "" >>>;   
        }
    }
    
    fun string getClassName()
    {
        return className;
    }
}
