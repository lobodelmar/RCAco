class AudioRecorder
{
  float startMillis;
  float recordMillis=0;
  int pastMillis;
  int futureMillis;
  boolean recording=false;
  int recDotAlpha = 255;
  int alphaStep = -7;
  String pathAndFilename = "defaultFilename.wav";

  AudioRecorder(int _pastSec, int _futureSec) {
    pastMillis = _pastSec*1000;
    futureMillis = _futureSec*1000;
//    pathAndFilename = _pathAndFilename;
  }

  void record()
  {
    String lines[] = loadStrings("http://localhost:8080/button?saveloc=" + pathAndFilename);
    if (lines==null) println("**** Audio server is not responding/running ****");
    else {
      startMillis = millis();
      recording = true;      
      println(lines);
    }
  }

  void setFilename(String _filename) {
    pathAndFilename = _filename;
  }

  void draw() {
    if (recording)
    {
      recordMillis = millis() - startMillis;
      drawStats(15, 15);
      if (recordMillis>=futureMillis) recording = false;
    }
  }

  void drawStats(int x, int y) {
    textSize(15);
    stroke(255);
    fill(255);
    int seconds = int(recordMillis/1000);
    String deci = nf(int((recordMillis/1000 - seconds)*60), 2);
    text(str(int(pastMillis/1000)) + "''" + " +  " + nf(seconds, 2) + ":" + deci, x+13, y+5);
    recDotAlpha+=alphaStep;
    if (recDotAlpha<0 || recDotAlpha>255) alphaStep*=-1;
    fill(255, recDotAlpha);
    noStroke();
    ellipse(x, y, 12, 12);
  }
}

