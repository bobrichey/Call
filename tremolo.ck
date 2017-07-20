//*****************************************************************//
// NAME: Bob Richey                                                //
//                                                                 //
// CLASS: MTC 512                                                  //
//                                                                 //
// ASSIGNMENT: Call                                                //
//                                                                 //
// FILE NAME: tremolo.ck                                           //
//                                                                 //
// DATE: April 2015, revised July, 2015                            //
//                                                                 //
// DESCRIPTION: Used to begin the piecenv. Add several shreds at a //
// time using different samples, gradually increase gain. Continue //
// for approximately 30 seconds.                                   //
//                                                                 //
// Comment out line 34 for use in 4th movement.                    //
//*****************************************************************//

SndBuf buff => Envelope env => Pan2 pan => dac;
0.2 => buff.gain;
0 => int which;

["/trem A3.wav", "/trem A4.wav", "/trem B3.wav",
"/trem E3.wav", "/trem E4.wav", "/trem F#4.wav"] @=> string trem[];

me.dir() + "/Guitar Samples" + trem[which] => buff.read;

for (0 => int i; i < 3; i++)
{
    0 => buff.pos;
    Math.random2f(-1, 1) => pan.pan;
    float rate;
    1.0 => rate;
    Math.random2f(1, 1.125) => rate => buff.rate;
    
    // set envelope so peak volume is reached halfway through sample
    (buff.length() / rate) / 2 => dur ramp => env.duration;
    1 => env.keyOn;
    ramp => now;
    1 => env.keyOff;
    ramp => now;
}