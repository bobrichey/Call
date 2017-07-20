SndBuf s => Envelope e => NRev r => Pan2 p => dac;
100::ms => dur ramp;
e.duration(ramp);

0.6 => s.gain;//

// llamada
["/llamada Eb.wav"] @=> string llamada[];

test(llamada);

fun void test(string arr[])
{
    for (0 => int i; i < 1; i++) //while true
    {
        Math.random2(0, arr.cap() - 1) => int j;
        //if (j==3) 0 => j;
        me.dir() + "/Guitar Samples" + arr[0] => s.read;
        
        //s.samples() => s.pos;
        //-1 => s.rate;
        Math.random2f(-0.3, 0.3) => p.pan;
        Math.random2f(0.65, 1.5) => float playbackRate => s.rate;
        
        // adjust reverb based on playback rate
        if (playbackRate < 1.0)
        {
            playbackRate * 0.2  => r.mix;
        }
        else
        {
            0 => r.mix;
        }

        //Math.random2(0, s.samples()/2) => s.pos;
        1 => e.keyOn;
        s.length() * 1.5 - ramp => now;
        //Math.random2(500, 2000)::ms => now;
        1 => e.keyOff;
        ramp => now;
    }
}