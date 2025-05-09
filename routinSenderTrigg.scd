s.boot;

//globalVariables
(
~sig;
~freq;
~amp;
~lpf;
~hpf;
~a;
~d;
~s;
~r;
~addNoise;
~bpm = 1;
)


(
OSCdef.new(\SynP3Osc, {
	arg msg, time, addr, recvPort;
	[msg, time, addr, recvPort].postln;
	~freq = msg[1];
	~mul = msg[2];
	~amp = msg[3];
	~lpf = msg[4];
	~bpf = msg[5];
	~hpf = msg[6];
	~a = msg[7];
	~d = msg[8];
	~s = msg[10];
	~r = msg[11];
}, "/synthControl/key", nil, 57120);
)

~fxBus = Bus.audio(s, 2); // bus estéreo para efectos

(
SynthDef.new(\SynthP3, {
	arg freq=440, mul=0.3, atk=0.01, dky=0.1, sus=0.3, rel=0.2,
	lp=8000, hp=100, pan=0, amp=0.5, out=0, send=0, sendReverb=0;
	var sig, env, lfo, dist;

	sig = Saw.ar(freq, mul);
	lfo = SinOsc.kr(0.3, 0, 1000, lp);
	sig = LPF.ar(sig, lfo);
	sig = HPF.ar(sig, hp);

	env = EnvGen.ar(
		Env([0, 1, 0.6, 0], [atk, dky, sus, rel], [-4, -2, -4]),
		doneAction:2
	);

	sig = sig * env;
	dist = tanh(sig * 2);

	sig = Pan2.ar(dist, pan, amp);

	Out.ar(out, sig);             // sonido directo
	Out.ar(send, sig * 0.5);      // señal al delay
	Out.ar(sendReverb, sig * 0.3); // señal a reverb
}).add;
)




(
SynthDef(\simpleDelay, {
	arg in=0, out=0, delayTime=0.3, feedback=0.4, mix=0.5;
	var sig, delayed;

	sig = In.ar(in, 2);
	delayed = CombL.ar(sig, 1, delayTime, feedback);

	// Mix señal original y con delay
	Out.ar(out, XFade2.ar(sig, delayed, mix * 2 - 1));
}).add;
)
)

~delaySynth = Synth(\simpleDelay, [\in, ~fxBus, \out, 0]);


(
SynthDef(\reverb, {
	arg in=0, out=0, mix=0.4, room=0.9, damp=0.7;
	var sig, rev;

	sig = In.ar(in, 2);
	rev = FreeVerb.ar(sig, mix, room, damp);
	Out.ar(out, rev);
}).add;
)
)

~revBus = Bus.audio(s, 2);
~reverbSynth = Synth(\reverb, [\in, ~revBus, \out, 0]);





m = NetAddr("127.0.0.1", 12000);
m.sendMsg("/prueba", 1);

(
~scale = Scale.minor.degrees; // usa escala menor
~root = 60.midicps; // nota base en Hz

~roo = Routine({
	inf.do {
		var note, freq, pan, waitTime;

		note = ~scale.choose + [0, 12].choose; // añade octava aleatoria
		freq = ~root * (2 ** (note / 12));
		pan = [-0.8, -0.4, 0, 0.4, 0.8].choose;
		waitTime = [0.25, 0.5, 0.75].choose;

		Synth(\SynthP3, [
			\freq, freq,
			\mul, 0.3,
			\amp, 0.5,
			\lp, rrand(2000, 10000),
			\hp, rrand(50, 200),
			\atk, rrand(0.01, 0.1),
			\dky, rrand(0.05, 0.3),
			\sus, rrand(0.2, 0.5),
			\rel, rrand(0.1, 0.5),
			\pan, pan
		]);

		m.sendMsg("/step1"); // sigue mandando OSC
		waitTime.wait;
	};
});
)

~roo.play;


~roo.play;


~roo.stop;

~roo.reset.play;
~roo.stop;

~delaySynth = Synth(\simpleDelay, [\in, ~fxBus, \out, 0]);
~reverbSynth = Synth(\reverb, [\in, ~revBus, \out, 0]);

~delaySynth.free;
~reverbSynth.free;


