# RCAco

## introduction
From initial research it seems that we can probably run the whole thing within one processing sketch which is running 2 embedded sketches (Macs can easily send separate feeds to different screens). This way we can direct one sketch to one screen (projector) and the other sketch to the external monitor, eliminating the need to use a raspberry pi and thus complicate things with messaging between applications/PCs. I Haven't tried it before, but there seems to be [a way](http://www.gicentre.net/utils/multiwindow/) to do it and that would be the first way I would attempt to solve it. It also makes it easy to run the software in the future without relying on setting up more than 1 machine/process.

## progamming components

#### projector (8 hrs)
* initial research
* video along with audio stream is played in a loop in a Processing window
* when user presses a real or painted button
  * audio from the past 15 seconds + next 15 secods (?) is saved on disk
  * timestamp on loop is saved
  
#### external monitor (12 hrs)
* initial research
* timestamp on loop is used to find corresponding images
* images are meshed together into one composite image
* composite image is displayed on screen
* recorded soundscape is played back on 2nd pair of speakers or (probably) headphones
* result submitted on twitter

#### touchboard / arduino (5 hrs)
* initial research
* programming in Wiring so that on touching a real/painted button it sends a signal to Processing to save recording

## software used
* Wiring
* Processing
* [Multiwindow](http://www.gicentre.net/utils/multiwindow/) library. Downloaded from [here](http://www.gicentre.net/software/#/utils/)
* Minim sound library
* Twitter4j library

## hardware used
* laptop
* mic
* headphones
* [touchboard](http://www.bareconductive.com/shop/touch-board/) (cost: £55) / arduino
* [conductive paint](http://www.bareconductive.com/shop/electric-paint-50ml/) (cost: £18)
* [usb sound card](http://www.amazon.co.uk/USB2-0-External-Quality-Channel-Adapter/dp/B003ZM0XIY/ref=sr_1_1?ie=UTF8&qid=1433022900&sr=8-1&keywords=usb+sound+card) in order to achieve [multiple audio output](http://forum.processing.org/two/discussion/3109/how-to-get-multiple-audio-outputs-with-minim). The latter example is based on [this](http://code.compartmental.net/minim/examples/Minim/setOutputMixer/) Minim original (cost: £2)
* posted [here](http://forum.processing.org/two/discussion/11155/record-past-15-seconds-of-microphone-with-minim) to ask about buffer

## still to do
* make arduino optional 
* add arduino instructions
* ask mac installer
* add in notes to look at list of ports if 2nd sound source does not work
* make executable

## done
* add data folder in wristband, externalDisplay
* landing image instead of "waiting for..."
* double-click functionality
* touchboard programming
* visualization of audio on `externalMonitor`
* pressing 'r' on externalDisplay resets to "waiting..." screen
* loads history though JSON file and makes it available from boot
* ability to go and play back old scenes through left and right arrow (<- / ->)
* loop through same segment when user presses R until we get 15+15''
* setup imgs from common folder
* settings file centrally located
* playback from usb audio card

## posibilities
* [saving as MP3](http://sourceforge.net/p/lame/mailman/message/11484009/)
* [a better way to thread?](http://w3facility.org/question/running-a-scrapy-spider-in-the-background-in-a-flask-app/)
* [even better thread?](http://blog.miguelgrinberg.com/post/the-flask-mega-tutorial-part-xi-email-support)
* thinner externalDisplayClient on rpi (only if we have trouble with setup)
* AJAX call on a button on the index.html page with JQuery so that it can be a web app too. make sure it sends something like "web000.wav" as an input to avoid conflicts with concurrent desktop processes
* list all scenes through server + json reading
* show progress bar of where we are in history on externalDisplay and show it move as we go back in time. Give timestamp feedback too as scenes change.

## cleanup
* remove java 7 & 8
* remove processing 3
