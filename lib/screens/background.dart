
class Background{

  String back(){
    var now = new DateTime.now();
    if(now.hour>=7 && now.hour<17)
      {
        return 'images/07_09_2020-weather_20718098.jpg';
      }
    else if(now.hour>=6 && now.hour<7)
      {
        return 'images/istockphoto-531253600-612x612.jpg';
      }
    else if(now.hour>=17 && now.hour<19)
      {
        return 'images/red-evening-sun-1.jpg';
      }
    else
      {
        return 'images/pexels-james-wheeler-414612.jpg';
      }
  }
}