import threading
import atexit
from flask import Flask, render_template
from flask.ext.bootstrap import Bootstrap
from flask import request
import time
import recorder
from datetime import datetime

# thread handler
yourThread = threading.Thread()

def create_app():
	app = Flask(__name__)

	@app.route('/', methods=['GET'])
	def index():
		dateString = datetime.now()
		if "recorder" in [t.getName() for t in threading.enumerate()]:
			threadOn = True		
		return render_template('index.html', timestamp=str(dateString)[:-7], threadOn=threadOn)
			
	@app.route('/button', methods=['GET'])	
	def button():
		saveLoc = request.args.get('saveloc')
		if saveLoc: recorder.OUTPUTLOC = saveLoc
		else: recorder.PATH = "default.wav"
		recorder.buttonPressed = True
		dateString = datetime.now()
		response = "<h3>Button pressed on: " + str(dateString)[:-7] + "</h3>" 
		return response

	def interrupt():
		global yourThread
		yourThread.cancel()

	global yourThread
	yourThread = threading.Thread(name="recorder", target=recorder.recordToBuffer)
	yourThread.start()

    # When you kill Flask (SIGTERM), clear the trigger for the next thread
	atexit.register(interrupt)
	return app

app = create_app()
bootstrap = Bootstrap(app)
app.run(host='0.0.0.0', port=8080, debug=True, use_reloader=False)
