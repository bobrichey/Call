//Bob Richey
//May 3rd, 2014

SndBuf buff => LiSa lisa => Envelope env => NRev rev => Pan2 pan => dac;

1.0 => buff.gain;
1.0 => lisa.gain; //set gain level
0.5 => pan.pan;
0.0 => rev.mix;

// Melodic fragments (whole tone)
["/whole tone1.wav", "/whole tone2.wav"] @=> string wholeTones[];

me.dir() + "/Guitar Samples" + 
wholeTones[0] => buff.read;


30000::ms => dur length;
now + length => time end;


5000::ms => env.duration;


buff.length() => dur bufferLen; //used to set length of LiSa recording
bufferLen => lisa.duration; //how long LiSa will record


3 => lisa.maxVoices; //number of voices that will sound
15000::ms => lisa.recRamp; //ramp for each LiSa voice


[-0.5, -1.0] @=> float rates1[]; //playback rates for LiSa
[0.5, 1.0] @=> float rates[]; //playback rates for LiSa


1 => lisa.record;

spork ~ envelope();

while(now < end)
{
    now + bufferLen => time later; //time variable for playing LiSa
    0 => int count;
    while(now < later)
    {
        rates1[Math.random2(0, rates1.cap()-1)] => float rate; //determines playback rate
        Math.random2(5000, 8000)::ms => dur newDur; //determines playback duration
        spork ~ getGrain(newDur, 50::ms, 50::ms, rate); //spork playback function
        Math.random2f(-0.75, 0.75) => pan.pan;
        5000::ms => now;
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
