public class SnapDelay extends PercSounds
{   
    0.2 => inputGain;
    0.1 => gainIncrement;
    
    3000 => tempo;   
    400 => tempoIncrement;
    250 => maxTempo;
    
    50::ms => ramp;    
    
    // set up delay lines 
    for (0 => int i; i < 3; i++) 
    {
        0.6 => del[i].gain;
        (0.7 + i * 0.4)::second => del[i].max => del[i].delay; 
    }
    
    // snap samples
    ["/snap A1.wav", "/snap A2.wav", "/snap A3.wav", "/snap A4.wav", 
    "/snap B1.wav", "/snap B2.wav", "/snap B3.wav", "/snap B4.wav",
    "/snap Bb1.wav", "/snap Bb2.wav", "/snap Bb3.wav", "/snap Bb4.wav",
    "/snap E1.wav", "/snap E2.wav", "/snap E3.wav", "/snap E4.wav",
    "/snap F1.wav", "/snap F2.wav", "/snap F3.wav", "/snap F4.wav",
    "/snap F#1.wav", "/snap F#2.wav", "/snap F#3.wav", "/snap F#4.wav"
    ] @=> string samples[];
    
    // TODO - fix array handling (see super class)
    samples.cap() => arraySize;

    // TODO - improve method of assigning samples to super class array
    for (0 => int i; i < samples.cap(); i++) 
    {
        samples[i] => sampArray[i]; 
    }
    
    0 => alterPlaybackRate;
    
    "SnapDelay" => className;

    0 => isOn;
}
