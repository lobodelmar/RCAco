class SceneStack {
  int index;
  String audioscapeLocation; 
  JSONArray scenesJ;
  String historyFilename; //default name, overwritten in constructor

  SceneStack(String _filename) {
    scenesJ = new JSONArray();
    index = 0;
    historyFilename = _filename;
    try {
      scenesJ = loadJSONArray(historyFilename);
      index = scenesJ.size();
      println(scenesJ.size() + " scene(s) found in history");
    }
    catch (Exception e){
      scenesJ = new JSONArray();
      println("*** Starting a new Scene History file ***");
    }
  }

  void add(String audioFilename, String imageFilename) {
    JSONObject newScene = new JSONObject();
    newScene.setString("audio", audioFilename);
    newScene.setString("image", imageFilename);
    String timestamp = day() + "/" + month() + "/" + year() + " @ " + hour() + ":" + minute() + "." + second();
    newScene.setString("timestamp", timestamp);
    scenesJ.setJSONObject(scenesJ.size(), newScene);
    saveJSONArray(scenesJ, historyFilename);
    println("saving file here: " + historyFilename);
    index = scenesJ.size()-1;
    //newScene = null;
    //SAVE TO DISK
  }

  JSONObject get() {
    return scenesJ.getJSONObject(index);
  }
  void next() {
    index++;
    if (index>scenesJ.size()-1) index=scenesJ.size()-1; //stay in last one
  }
  void prev() {
    index--;
    if (index<0) index=0;
  }
  void resetIndex() {
    index=scenesJ.size()-1;
  }
  void loadSoundScapeHistory(String filename) {
    JSONArray values = loadJSONArray(filename);
  }
}

