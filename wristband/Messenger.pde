import oscP5.*;
import netP5.*;

class Messenger {
  OscP5 oscP5;
  NetAddress externalMonitorAddress;
  OscMessage wristbandMsg;

  Messenger(PApplet parent) {
    oscP5 = new OscP5(parent, 11000);
    externalMonitorAddress = new NetAddress("localhost", 12000);
    wristbandMsg = new OscMessage("/wristband result");
  }

  void initialize(String sceneName, String pathAndFilename) {
    wristbandMsg = new OscMessage("/wristband result");
    wristbandMsg.add(sceneName); /* add an int to the osc message */
    wristbandMsg.add(pathAndFilename);
  }

  void send()
  {
    oscP5.send(wristbandMsg, externalMonitorAddress); 
    println("sending");
  }
}
