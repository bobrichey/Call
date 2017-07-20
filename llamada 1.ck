SndBuf s => Envelope e => NRev r => Pan2 p => dac;
100::ms => dur ramp;
e.duration(ramp);
0. => r.mix;
0.65 => s.gain;


// llamada
["/llamada.wav", "/llamada Eb.wav", "/llamada choked.wav"] @=> string llamada[];

[1.25, 1.0] @=> float rates[];

test(llamada);

fun void test(string arr[])
{
    for (0 => int i; i < 1; i++) //while true
    {
        Math.random2(0, arr.cap() - 1) => int j;
        //if (j==3) 0 => j;
        me.dir() + "/Guitar Samples" + arr[1] => s.read;
        
        //s.samples() => s.pos;
        //-1 => s.rate;
        Math.random2f(-0.75, 0.75) => p.pan;
        rates[Math.random2(0, rates.cap() - 1)] => float rate => s.rate;
        //Math.random2(0, s.samples()/2) => s.pos;
        1 => e.keyOn;
        s.length() / rate - ramp => now;
        //Math.random2(500, 2000)::ms => now;
        1 => e.keyOff;
        ramp => now;
    }
}