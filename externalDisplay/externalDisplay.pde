import processing.video.*;

Server server;
WavPlayer wavplr;
SceneStack sceneStack;
int scale = 2;
//PImage sceneImg;
Movie sceneMovie;
String commonDataPath = "../../_common_data_/scenes/"; //SEND READY PATH FROM SERVER!!!!!
String audioscapeHistoryFilename = "../_common_data_/audioscapes/audioscapeHistory.json";
PImage waitingImg;
String waitingImgFilename = "../_common_data_/waitingScreen.png";

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
    String pathAndFilename = commonDataPath + server.sceneName + ".mp4";
    sceneStack.add(server.wavName, pathAndFilename);
    loadScene();
  }

  //if (sceneImg!=null) {
  if (sceneMovie!=null) {
    image(sceneMovie, 0, 0, width, height);
    //image(sceneImg, 0, 0, width, height);
    wavplr.drawEqualizer(width-250, height-80, 200, 250);
  } else {
    image(waitingImg, 0, 0, width, height);
    wavplr.stop();
  }
}

void loadScene()
{
  if (!sceneStack.isEmpty()) {
    sceneMovie = new Movie(this, sceneStack.get().getString("image"));
    sceneMovie.loop();
    //sceneImg = loadImage(sceneStack.get().getString("image"));
    wavplr.loadFile(sceneStack.get().getString("audio"));
  }
}

void keyPressed()
{
  if (key == 'r') {
    //sceneImg = null;
    sceneMovie = null;
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

void movieEvent(Movie m) {
  m.read();
}
