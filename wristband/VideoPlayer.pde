import processing.video.*;

//void movieEvent(Movie m) {
//  m.read();
//}

class VideoPlayer
{
  JSONArray values;  
  String sceneName = null;
  String dataPath = sketchPath+"/data/";
  boolean stayInScene=false;
  int currSceneStart;
  int currSceneEnd;

  Movie movie;

  VideoPlayer(PApplet parent, String _s)
  {
    values = loadJSONArray("../_common_data_/videoSegments.json");
    movie = new Movie(parent, _s);
    movie.loop();
  }

  void draw()
  {
    if (stayInScene==true)
    {
      if (getVideoTime()>=currSceneEnd-1000) //1000 is safety margin for scene change. Millisecond accuracy for segments is provided, then not needed
      {
        movie.jump(currSceneStart/1000.0);
      }
    }

    if (movie.available()) movie.read();
    image(movie, 0, 0, width, height);
    //saveit();
  }

  int getVideoTime()
  {
    return int(movie.time()*1000);
  }

  void saveit()
  {
    if (movie.duration()>movie.time())
    {
      image(movie, 0, 0, width, height);
      saveFrame(nf(movie.time(), 2, 3) + ".png");
    }
  }

  String chooseScene()
  {
    int millis = getVideoTime();
    for (int i = 0; i < values.size (); i++)
    {
      JSONObject scene = values.getJSONObject(i); 
      int from = scene.getInt("from");
      int to = scene.getInt("to");
      //println(id + ", " + species + ", " + name);
      if (millis>=from && millis<=to)
      {
        sceneName = scene.getString("name");
        currSceneStart = from;
        currSceneEnd = to;
      }
    }
    println(sceneName);
    return sceneName;
  }
}

