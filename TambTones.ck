 public class TambTones
{
    10 => int numVoices;
    
    int voice[numVoices]; 
    SndBuf tamb[numVoices];
    Envelope env[numVoices];
    Pan2 pan[numVoices];
    
    1000::ms => dur ramp;
    
    for (int i; i < numVoices; i++)
    {
        tamb[i] => env[i] => pan[i] => dac;
        env[i].duration(ramp);
    }
    
    [0.5, 0.625, 0.75, 1.0, 1.25, 1.5, 2.0] @=> float rates[];
    
    
    0 => int isOn;
    
    "TambTones" => string className;
    
    fun void play()
    { 
        while (true)
        {
            if (isOn % 2 == 0)
            { 
                break;
            }
            spork~ playTamb();
            Math.random2(1500, 5000)::ms => now;
        }
    }
    
    fun void playTamb()
    {
        getVoice() => int which;
        if (which > -1)
        {
            me.dir() + "/Guitar Samples/tamb.wav" => tamb[which].read;
            Math.random2f(0.3, 0.6) => tamb[which].gain;
            Math.random2f(-0.75, 0.75) => pan[which].pan;
            rates[Math.random2(0, rates.cap() - 1)] => tamb[which].rate;
            //Math.random2f(1, 1.5) => tamb[which].rate;
            1 => env[which].keyOn;
            tamb[which].length() * 1.5 - ramp => now;
            //Math.random2(500, 2000)::ms => now;
            1 => env[which].keyOff;
            ramp => now;
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
