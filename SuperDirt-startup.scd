
//setup  the audio out

ServerOptions.devices

(
o = Server.local.options;
o = ServerOptions.new;
o.outDevice ="USB Audio CODEC";
)

o.inDevice;


(
o = ServerOptions.new;
o.memSize_(8192*32);
o.memSize;
)


//Launch superdirt
SuperDirt.start;

//Midi sync

MIDIClient.init;

//add ur midiiis

(
~midiOut =MIDIOut.newByName("IAC Driver", "Tidal 1");
~midiOut2 = MIDIOut.newByName("IAC Driver", "Tidal 2");
~midiOut3 = MIDIOut.newByName("IAC Driver", "Tidal 3");
~midiOut4 = MIDIOut.newByName("IAC Driver", "Tidal 4");
~dirt.soundLibrary.addMIDI(\midi1, ~midiOut);
~dirt.soundLibrary.addMIDI(\midi2, ~midiOut2);
~dirt.soundLibrary.addMIDI(\midi3, ~midiOut3);
~dirt.soundLibrary.addMIDI(\midi4, ~midiOut4);
)

//Update midi latency where necessary.
~midiOut.latency = 0.12;



//SuperDirt with only one channel..
~dirt = SuperDirt(1, s);


//Tempo control ?? what it do??

TempoClock.default.tempo = 60/60;


/*MIDIClockOut.new("SQ-1", "CTRL", 60)*/

~midiOut = MIDIOut.newByName("SQ-1", "CTRL");

~midiOut.connect

~dirt.soundLibrary.addMIDI(\midi, ~midiOut);

~midiOut.midiClock;


//Server commands etc..

Server.killAll;

s.reboot

s.quit


s.latency_(0.12)



// Built-in Output Supercollider..
(
// configure the sound server: here you could add hardware specific options
// see http://doc.sccode.org/Classes/ServerOptions.html
s.options.numBuffers = 1024 * 256; // increase this if you need to load more samples
s.options.memSize = 8192 * 126; // increase this if you get "alloc failed" messages
s.options.maxNodes = 1024 * 64; // increase this if you are getting drop outs and the message "too many nodes"
s.options.numOutputBusChannels = 2; // set this to your hardware output channel size, if necessary
s.options.numInputBusChannels = 2; // set this to your hardware output channel size, if necessary
// boot the server and start SuperDirt
s.waitForBoot {
	~dirt = SuperDirt(2, s); // two output channels, increase if you want to pan across more channels
	~dirt.loadSoundFiles;   // load samples (path containing a wildcard can be passed in)
	// for example: ~dirt.loadSoundFiles("/Users/myUserName/Dirt/samples/*");
	// s.sync; // optionally: wait for samples to be read
	~dirt.start(57120, 0!12);   // start listening on port 57120, create two busses each sending audio to channel 0

	// optional, needed for convenient access from sclang:
	(
		~d1 = ~dirt.orbits[0]; ~d2 = ~dirt.orbits[1]; ~d3 = ~dirt.orbits[2];
		~d4 = ~dirt.orbits[3]; ~d5 = ~dirt.orbits[4]; ~d6 = ~dirt.orbits[5];
		~d7 = ~dirt.orbits[6]; ~d8 = ~dirt.orbits[7]; ~d9 = ~dirt.orbits[8];
		~d10 = ~dirt.orbits[9]; ~d11 = ~dirt.orbits[10]; ~d12 = ~dirt.orbits[11];
	);
};

s.latency = 0.15; // increase this if you get "late" messages
);


// Multi-channel version of Superdirt start-up, Use with Blackhole audio..
(
// configure the sound server: here you could add hardware specific options
// see http://doc.sccode.org/Classes/ServerOptions.html
s.options.numBuffers = 1024 * 256; // increase this if you need to load more samples
s.options.memSize = 8192 * 126; // increase this if you get "alloc failed" messages
s.options.maxNodes = 1024 * 64; // increase this if you are getting drop outs and the message "too many nodes"
s.options.numOutputBusChannels = 16; // set this to your hardware output channel size, if necessary
s.options.numInputBusChannels = 16; // set this to your hardware output channel size, if necessary
// boot the server and start SuperDirt
s.waitForBoot {
	~dirt = SuperDirt(16, s); // two output channels, increase if you want to pan across more channels
	~dirt.loadSoundFiles;   // load samples (path containing a wildcard can be passed in)
	// for example: ~dirt.loadSoundFiles("/Users/myUserName/Dirt/samples/*");
	// s.sync; // optionally: wait for samples to be read
	~dirt.start(57120, [0,2,4,6,8,10,12,14]);   // start listening on port 57120, create two busses each sending audio to channel 0

	// optional, needed for convenient access from sclang:
	/*(
		~d1 = ~dirt.orbits[0]; ~d2 = ~dirt.orbits[1]; ~d3 = ~dirt.orbits[2];
		~d4 = ~dirt.orbits[3]; ~d5 = ~dirt.orbits[4]; ~d6 = ~dirt.orbits[5];
		~d7 = ~dirt.orbits[6]; ~d8 = ~dirt.orbits[7]; ~d9 = ~dirt.orbits[8];
		~d10 = ~dirt.orbits[9]; ~d11 = ~dirt.orbits[10]; ~d12 = ~dirt.orbits[11];
	);*/
};

s.latency = 0.45; // increase this if you get "late" messages
);


// Test startup file

/*
This is an example startup file. You can load it from your startup file
(to be found in Platform.userAppSupportDir +/+ "startup.scd")
*/


(
// configure the sound server: here you could add hardware specific options
// see http://doc.sccode.org/Classes/ServerOptions.html
s.options.numBuffers = 1024 * 256; // increase this if you need to load more samples
s.options.memSize = 8192 * 126; // increase this if you get "alloc failed" messages
s.options.maxNodes = 1024 * 64; // increase this if you are getting drop outs and the message "too many nodes"
s.options.numOutputBusChannels = 2; // set this to your hardware output channel size, if necessary
s.options.numInputBusChannels = 2; // set this to your hardware output channel size, if necessary
// boot the server and start SuperDirt
s.waitForBoot {
	~dirt = SuperDirt(2, s); // two output channels, increase if you want to pan across more channels
	~dirt.loadSoundFiles;   // load samples (path containing a wildcard can be passed in)
	// for example: ~dirt.loadSoundFiles("/Users/myUserName/Dirt/samples/*");
	// s.sync; // optionally: wait for samples to be read
	~dirt.start(57120, 0 ! 12);   // start listening on port 57120, create two busses each sending audio to channel 0

	// optional, needed for convenient access from sclang:
	(
		~d1 = ~dirt.orbits[0]; ~d2 = ~dirt.orbits[1]; ~d3 = ~dirt.orbits[2];
		~d4 = ~dirt.orbits[3]; ~d5 = ~dirt.orbits[4]; ~d6 = ~dirt.orbits[5];
		~d7 = ~dirt.orbits[6]; ~d8 = ~dirt.orbits[7]; ~d9 = ~dirt.orbits[8];
		~d10 = ~dirt.orbits[9]; ~d11 = ~dirt.orbits[10]; ~d12 = ~dirt.orbits[11];
	);
};

s.latency = 0.45; // increase this if you get "late" messages
);

s.latency_(3.85)

s.quit

Server.killAll


//Set to drop when cpu limit is exceeded

~dirt.dropWhen = { ~dirt.server.statusWatcher.peakCPU > 3.3 }; // limit to 3.3 % cpu

// var <numUGens=0, <numSynths=0, <numGroups=0, <numSynthDefs=0;
// var <avgCPU, <peakCPU;



//Recompile when updates are needed.
Quarks.checkForUpdates({Quarks.install("SuperDirt", "v1.1.1"); thisProcess.recompile()});



/// Sidechain d1 & d2//

(
~bus = Bus.audio(s, numChannels:2); // First, create a bus
~dirt.orbits[0].outBus = ~bus; // Then, link a track to this bus
(
Ndef(\x, {
var control = InBus.ar(~dirt.orbits[1].dryBus, 2).sum;
var dirt = InBus.ar(~bus, 2);
Compander.ar(dirt, control, thresh:0.05, slopeBelow:1.0, slopeAbove: 0.651, clampTime:0.05, relaxTime:0.1)
//dirt * (1 - (Amplitude.kr(control) > 0.007).poll.lag(0.01));
}).play;
)
)


// clean
(
~dirt.orbits[0].outBus = 0;
~bus.free;
)


