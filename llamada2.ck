//Bob Richey
//May 3rd, 2014

SndBuf buff => LiSa lisa => Envelope env => Pan2 pan => dac;

0.55 => buff.gain;
0.55 => lisa.gain; //set gain level
Math.random2f(-1.0, 1.0) => pan.pan;

// octatonic pitches
["/llamada Eb.wav"] @=> string oct[];
me.dir() + "/Guitar Samples" + 
oct[Math.random2(0, oct.cap() - 1)] => buff.read;


8000::ms => dur length;
now + length => time end;


500::ms => env.duration;


2000::ms => dur bufferLen; //used to set length of LiSa recording
bufferLen => lisa.duration; //how long LiSa will record


1 => lisa.maxVoices; //number of voices that will sound
50::ms => lisa.recRamp; //ramp for each LiSa voice


[-0.5, -1.0, -2.0] @=> float rates[]; //playback rates for LiSa
[1.0, 0.714] @=> float rates1[]; //playback rates for LiSa


1 => lisa.record;

spork ~ envelope();

while(now < end)
{
    now + bufferLen => time later; //time variable for playing LiSa
    
    while(now < later)
    {
        rates[Math.random2(0, rates.cap()-1)] => float rate; //determines playback rate
        Math.random2(100, 1000)::ms => dur newDur; //determines playback duration
        
        spork ~ getGrain(newDur, 20::ms, 20::ms, rate); //spork playback function
        
        300::ms => now;
    }
    
    0 => lisa.record;
}


//determine parameters of LiSa voices: takes which LiSa (playBuf), length of playback, ramp durations, playback rate
fun void getGrain(dur grainLen, dur rampUp, dur rampDown, float rate)
{
    lisa.getVoice() => int newVoice; //pick an available LiSa voice
    
    if(newVoice > -1) //-1 means no voice is free
    {
        lisa.rate(newVoice, rate); //assign the rate
        lisa.playPos(newVoice, Math.random2f(0, 1) * bufferLen); //assign where in the playback will begin in the sample
        lisa.rampUp(newVoice, rampUp); //fade in LiSa voice
        (grainLen - (rampUp + rampDown)) => now; //voice sounds for "grainlen" including rampUp and rampDown time
        lisa.rampDown(newVoice, rampDown); //fade out
        rampDown => now;
    }
}

fun void envelope()
{
    1 => env.keyOn;
    length - env.duration() => now;
    1 => env.keyOff;
}
