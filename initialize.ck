//*****************************************************************//
// NAME: Bob Richey                                                //
//                                                                 //
// CLASS: MTC 512                                                  //
//                                                                 //
// ASSIGNMENT: Call                                                //
//                                                                 //
// FILE NAME: gtr initialize.ck                                    //
//                                                                 //
// DATE: April 2015, revised 2016                                  //
//                                                                 //
// DESCRIPTION: launches necessary classes and HID files for       //
// laptop performer                                                //              //
//*****************************************************************//

// superclasses
Machine.add(me.dir() + "/PercSounds.ck");
Machine.add(me.dir() + "/Tones.ck");

// subclasses
Machine.add(me.dir() + "/OctatonicTones.ck");
Machine.add(me.dir() + "/PentatonicTones.ck");
Machine.add(me.dir() + "/TamboraTones.ck");
Machine.add(me.dir() + "/PercDelay.ck");
Machine.add(me.dir() + "/PizzDelay.ck");
Machine.add(me.dir() + "/SnapDelay.ck");

1000::ms => now;

// HID file
Machine.add(me.dir() + "/keyboard map.ck");
