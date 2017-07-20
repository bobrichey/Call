public class PercDelay extends PercSounds
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
        (0.6 + i * 0.3)::second => del[i].max => del[i].delay; 
    }
    
    // body percussion hits
    ["/perc1.wav", "/perc2.wav", "/perc3.wav", 
    "/perc4.wav"] @=> string samples[];
    
    // TODO - fix array handling (see super class)
    samples.cap() => arraySize;

    // TODO - improve method of assigning samples to super class array
    for (0 => int i; i < samples.cap(); i++) 
    {
        samples[i] => sampArray[i]; 
    }

    0 => alterPlaybackRate;

    "PercDelay" => className;

    0 => isOn;
}
