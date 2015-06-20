import ddf.minim.*;
import ddf.minim.*;
import javax.sound.sampled.*;

class WavPlayer
{
  Minim minim;
  AudioPlayer player;
  Mixer.Info[] mixerInfo;
  int mixerIndex = 0; // change to appropriate number on a Mac (usually it's 4 - try the TEST example)

  WavPlayer(PApplet parent)
  {
    // we pass this to Minim so that it can load files from the data directory
    minim = new Minim(parent);
    mixerInfo = AudioSystem.getMixerInfo();
    println("**** LIST OF AVAILABLE AUDIO PORTS ****");
    println(mixerInfo);
    println("**************************************");
    Mixer mixer = AudioSystem.getMixer(mixerInfo[mixerIndex]);
    //println(mixer.getMixerInfo().getName());
    minim.setOutputMixer(mixer);
  }
  void stop() {
    if (player!=null) player.close();
  }
  void loadFile(String filename)
  {
    if (player==null)
    {
      player = minim.loadFile(filename);
      player.loop();
    } else {
      player.close();
      player=null;
      player = minim.loadFile(filename);
      player.loop();
    }
  }
  void drawEqualizer(int x, int y, int w, int h)
  {
    pushMatrix();
    pushStyle();
    stroke(0);
    fill(255);
    noStroke();
    translate(x, y);
    int noOfBars = 32;
    int spacingBetweenBars=3;
    int segmentWidth = player.bufferSize()/noOfBars;
    int barWidth = (w/noOfBars)-spacingBetweenBars;
    for (int i = 0; i < noOfBars; i++)
    {
      float x1 = map( i, 0, noOfBars, 0, w );
      float barHeight = abs(player.mix.get(i*segmentWidth)*h);
      rect(x1+spacingBetweenBars, 0, barWidth, barHeight, 20);
      rect(x1+spacingBetweenBars, 0, barWidth, -barHeight, 20);
    }
    popStyle();
    popMatrix();
  }
}

