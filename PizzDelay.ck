public class PizzDelay extends PercSounds
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
        (0.8 + i * 0.3)::second => del[i].max => del[i].delay; 
    }
    
    // pizz samples
    ["/pizz A1.wav", "/pizz A2.wav", "/pizz A3.wav", "/pizz A4.wav", 
    "/pizz B1.wav", "/pizz B2.wav", "/pizz B3.wav", "/pizz B4.wav",
    "/pizz Bb1.wav", "/pizz Bb2.wav", "/pizz Bb3.wav", "/pizz Bb4.wav",
    "/pizz E1.wav", "/pizz E2.wav", "/pizz E3.wav", "/pizz E4.wav",
    "/pizz F1.wav", "/pizz F2.wav", "/pizz F3.wav", "/pizz F4.wav",
    "/pizz F#1.wav", "/pizz F#2.wav", "/pizz F#3.wav", "/pizz F#4.wav"
    ] @=> string samples[];
    
    // TODO - fix array handling (see super class)
    samples.cap() => arraySize;

    // TODO - improve method of assigning samples to super class array
    for (0 => int i; i < samples.cap(); i++) 
    {
        samples[i] => sampArray[i]; 
    }
    
    0 => alterPlaybackRate;
    
    "PizzDelay" => className;

    0 => isOn;
}
