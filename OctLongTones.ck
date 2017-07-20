public class OctLongTones
{
    8 => int numVoices;
    
    int voice[numVoices]; 
    SndBuf buff[numVoices];
    Envelope env[numVoices];
    Pan2 pan[numVoices];
    
    0.4 => float inputGain;
    0.1 => float gainIncrement;
    //1500::ms => dur ramp;
    
    ["/long A.wav", "/long Bb.wav", "/long C.wav", "/long C#.wav",
    "/long D#.wav", "/long E.wav", "/long F#.wav", "/long G.wav"
    ] @=> string oct[];
    
    for (int i; i < numVoices; i++)
    {
        buff[i] => env[i] => pan[i] => dac;
        //env[i].duration(ramp);
        me.dir() + "/Guitar Samples" + oct[i] => buff[i].read;
        buff[i].samples() => buff[i].pos;
    }
    
    
    [1.0, 2.0, 4.0, 8.0, 16.0, 16.0] @=> float rates[];
    
        
    0 => int isOn;
    
    "OctLongTones" => string className;
    
    fun void play()
    { 
        while (true)
        {
            if (isOn % 2 == 0)
            { 
                break;
            }
            spork~ playbuff(inputGain);
            Math.random2(1000, 3000)::ms => now; 
        }
    }
    
    fun void playbuff(float gain)
    {
        getVoice() => int which;
        if (which > -1)
        {
            0 => buff[which].pos;
            gain => buff[which].gain;
            Math.random2f(-1.0, 1.0) => pan[which].pan;
            rates[Math.random2(0, rates.cap() - 1)] => float rate => buff[which].rate;
            //(buff[which].length() / rate) / 2 => dur ramp => env[which].duration;
            dur ramp;
            if (rate < 1.5) 
                7500::ms => ramp => env[which].duration;
            else 
                (buff[which].length() / rate) / 2 => ramp => env[which].duration;
            1 => env[which].keyOn;
            ramp => now;
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
    
    fun void increaseGain()
    {
        gainIncrement +=> inputGain;
        if (inputGain >= 1.5)
        {
            1.5 => inputGain;
        }
        <<< "Increase", className, "gain to:", Std.ftoa(inputGain, 1) >>>;
    }
    
    fun void decreaseGain()
    {
        gainIncrement -=> inputGain;
        if (inputGain <= 0)
        {
            0 => inputGain;
        }
        <<< "Decrease", className, "gain to:", Std.ftoa(inputGain, 1) >>>;
    }
}
