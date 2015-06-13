import pyaudio
import wave
import collections
import time

SECONDS_BEFORE = 15 # secs before button to save
SECONDS_AFTER = 15 # secs after button to save

CHUNK = 1024
FORMAT = pyaudio.paInt16
CHANNELS = 2
RATE = 44100
OUTPUTLOC = "output.wav"
#PATH = ""

buttonPressed = False
savedAlready = False
startTime = ""

def recordToBuffer():
	p = pyaudio.PyAudio()

	frames = []
	bufferSize = int(RATE / CHUNK * (SECONDS_BEFORE+SECONDS_AFTER))
	ring_buffer = collections.deque(maxlen= bufferSize)
	
	stream = p.open(format=FORMAT,
					channels=CHANNELS,
					rate=RATE,
					input=True,
					frames_per_buffer=CHUNK)

	print("recording to ring buffer - bef: " + str(SECONDS_BEFORE) + " // " + "aft: " + str(SECONDS_AFTER))

	while True:
		data = stream.read(CHUNK)
		ring_buffer.append(data)

		global buttonPressed		
		global startTime
		
		if buttonPressed==True:
			buttonPressed=False
			startTime = time.time()
			print "timer has (re)started"
		
		if startTime:
			if time.time()-startTime > SECONDS_AFTER:
				frames = list(collections.deque(ring_buffer))
				try:
					wf = wave.open(OUTPUTLOC, 'wb')
					wf.setnchannels(CHANNELS)
					wf.setsampwidth(p.get_sample_size(FORMAT))
					wf.setframerate(RATE)
					wf.writeframes(b''.join(frames))
					wf.close()
					buttonPressed = False
					timerStarted = False
					startTime = ""
					print "buffer saved to: =======> " + OUTPUTLOC
				except IOError as e:
					"I/O error({0}): {1}".format(e.errno, e.strerror)
					print "Error saving file"
					exit()
				except:
					print "Unexpected error:", sys.exc_info()[0]
					exit()
	#stream.stop_stream()
	#stream.close()
	#p.terminate()
