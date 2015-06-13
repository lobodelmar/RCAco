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
    //println(mixerInfo);
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
      //println(filename);
      player = minim.loadFile(filename);
      player.loop();
    } else {
      player.close();
      player=null;
      player = minim.loadFile(filename);
      player.loop();
    }
  }
}
