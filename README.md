## Installation

#### MacOSx installation
* I assume that you have python installed. Run `python` on a terminal and check that the version is > 2.7
* Download the [latest version](https://github.com/lobodelmar/RCAco/archive/master.zip) of the code and extract it on the desktop 
* Open a terminal. You can open one by pressing the command key and then typing "terminal" (without the quotes)
* run these 2 commands which install two packages that you need:
  * sudo easy_install pip
  * sudo pip install Flask
  * sudo pip install flask-bootstrap
* [download](https://people.csail.mit.edu/hubert/pyaudio/#downloads) and install the pyAudio library (for MacOSx) which is for playing with audio in Python 
* Finally, open Processing, go the the *Menu->Sketch->Import library->Add library* and search for *oscP5*. Only one result should come back. Install that.

That should be it :), with regards to installation.

#### Ubuntu installation
* Flask:
  * `sudo apt-get install pip`
  * `sudo pip install Flask`
  * `sudo pip install flask-bootstrap`
* pyAudio:
  * `sudo apt-get install python-pyaudio`
* Finally, open Processing, go the the *Menu->Sketch->Import library->Add library* and search for *oscP5*. Only one result should come back. Install that.

## Running (MacOSX / Linux)
* open a new terminal and navigate to the directory of the `pyRecServer`. On MacOSX an easy way to do it is open the terminal and type `cd ` (and a space), but and drag and drop the `pyRecServer` folder (inside the `code` folder of the extracted zip file in the first step) onto the terminal. The path of that folder should now appear on the command line. Press enter. When you type: `ls` you should see files ending with `.py`
* on the command line run the command that starts up the server `python pyRecServer.py`. You can see that the audio recording server is running by clicking [here](http://localhost:8080/).
* run the two processing sketches on the folder one level up. It's the `wristband` and the `externalMonitor`. On the wristband press `r` whenever you wish to start recording and sending the image composite to the `externalMonitor`. **IMPORTANT**: remember to use headphones as otherwise you'll be getting a feedback loop. Things recorded and played back will be re-recorded and played back ad infinitum. On final version I'll send video audio to a different audio card than the one for the headphones. Also, if you want to use the usb audio card I gave you remember to set the `mixerIndex` value on line 10 to `4`. Default is `0`.
* On the `externalMonitor` you can click `r` to reset the image to the default screen. If there are more scenes in history you can click the left/right arrow to browse through them.
