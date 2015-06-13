VideoPlayer videoPlr;
AudioRecorder audioRec;
Messenger messenger;
Timer timer;
int scale = 2;
int secondsBefore = 15;
int secondsAfter = 15;
String commonDataPath = "../_common_data_/";
String outputPath = commonDataPath + "audioscapes/";
String videoFile =  "../" + commonDataPath + "reality.mov";
String filenameStem = "audioscape";
int fileCounter = 0;

void setup()
{
  println(videoFile);
  size(displayWidth/scale, displayHeight/scale);
  background(0);
  videoPlr = new VideoPlayer(this, videoFile);
  audioRec = new AudioRecorder(secondsBefore, secondsAfter);
  messenger = new Messenger(this);
}

void draw()
{
  videoPlr.draw();
  audioRec.draw();

  if (timer!=null) {
    if (timer.isFinished()) {
      messenger.send();
      videoPlr.stayInScene = false;      
      timer = null;
    }
  }
}

void keyPressed()
{
  if (key=='r')
  {
    String compositeFilename = outputPath + filenameStem + "_" + nf(fileCounter, 5) + ".wav";
    messenger.initialize(videoPlr.chooseScene(), compositeFilename);
    audioRec.setFilename(compositeFilename);
    audioRec.record();
    videoPlr.stayInScene = true;
    timer = new Timer(secondsAfter*1000 + 1000); //added 1'' delay for safety
    timer.start();
    fileCounter++;
  }
}

