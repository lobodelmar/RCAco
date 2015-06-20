Server server;
WavPlayer wavplr;
SceneStack sceneStack;
int scale = 2;
PImage sceneImg;
String commonDataPath = "../_common_data_/scenes/"; //SEND READY PATH FROM SERVER!!!!!
//String initMsg = "waiting for audioscapes...";
String audioscapeHistoryFilename = "../_common_data_/audioscapes/audioscapeHistory.json";
PImage waitingImg;
String waitingImgFilename = "../_common_data_/waitingScreen.jpeg";

void setup()
{
  size(displayWidth/scale, displayHeight/scale);
  server = new Server(this);
  wavplr = new WavPlayer(this);
  sceneStack = new SceneStack(audioscapeHistoryFilename);
  waitingImg = loadImage(waitingImgFilename);
}

void draw()
{
  if (server.hasNewData()) {
    String pathAndFilename = commonDataPath + server.sceneName + ".png";
    sceneStack.add(server.wavName, pathAndFilename);
    loadScene();
  }

  if (sceneImg!=null) {
    image(sceneImg, 0, 0, width, height);
    wavplr.drawEqualizer(width-250, height-80, 200, 250);
  } else {
    //background(0);
    //textSize(20);
    //text(initMsg, width/2-textWidth(initMsg)/2, height/2);
    image(waitingImg, 0, 0, width, height);
    wavplr.stop();
  }
}

void loadScene()
{
  if (!sceneStack.isEmpty()) {
    sceneImg = loadImage(sceneStack.get().getString("image"));
    wavplr.loadFile(sceneStack.get().getString("audio"));
  }
}

void keyPressed()
{
  if (key == 'r') {
    sceneImg = null;
    sceneStack.resetIndex();
  } else if (key == CODED) {
    if (keyCode == LEFT) {
      sceneStack.prev();
      loadScene();
    } else if (keyCode == RIGHT) {
      sceneStack.next();
      loadScene();
    }
  }
}

