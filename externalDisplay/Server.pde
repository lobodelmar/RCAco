import oscP5.*;
import netP5.*;

class Server {
  OscP5 oscP5;
  NetAddress myRemoteLocation;
  OscMessage packet;
  String oldScene="";
  String sceneName="";
  String wavName="";
  
  Server (PApplet parent) {
    oscP5 = new OscP5(parent, 12000); //listen on port 12k 
  }
  
  void setData(String _sceneName, String _wavName) {
    sceneName = _sceneName;
    wavName = _wavName;
  }
  
  boolean hasNewData() {
    if (oldScene!=sceneName)
    {
      oldScene = sceneName;
      println(sceneName);
      return true;
    }
    else return false;
  }
}

void oscEvent(OscMessage theOscMessage)
{
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());

  String sceneName = theOscMessage.get(0).stringValue();  // get the first osc argument
  String wavName = theOscMessage.get(1).stringValue(); // get the second osc argument
  
  server.setData(sceneName, wavName);
}
