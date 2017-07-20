SndBuf harmonic => Gain input => dac; 

Delay del; 

input => del => dac;



[10, 20, 50, 100, 150, 300, 500, 600, 900, 1200] @=> int durs[];
[30, 40, 60, 120, 180, 240, 360, 480, 720, 1080] @=> int durs1[];

// set up delay line
del => del;
0.95 => del.gain;
durs1[0]::ms => del.max => del.delay; 
0.9 => harmonic.gain;

// harmonics
["/harm A3.wav", "/harm A4.wav", "/harm B3.wav", "/harm B4.wav",
"/harm C#3.wav", "/harm C#4.wav", "/harm E4.wav", "/harm E5.wav", 
"/harm F#4.wav"] @=> string harms[];

[1.0, 2.0] @=> float rates[];

me.dir() + "/Guitar Samples" + 
harms[Math.random2(0, harms.cap() - 1)] => harmonic.read;
rates[Math.random2(0, rates.cap() - 1)] => float rate;
rate => harmonic.rate;


20000::ms => now;