
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey='35998d09bef7112d8322ae3cfe756a4e';
String weatherUrl='https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async{
    var url = '$weatherUrl?q=$cityName&appid=$apiKey';
    Network network = new Network(url);

    var weatherData=await network.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async{
    Location location = new Location();
    await location.getCurrenttLocation();
    Network network = new Network(
      '$weatherUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey');
    var weatherData = await network.getData();
   return weatherData;

   }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return 'Thunderstorm';
    } else if (condition < 400) {
      return 'Drizzle';
    } else if (condition < 600) {
      return 'Rainy';
    } else if (condition < 700) {
      return 'Snow';
    } else if (condition < 800) {
      return 'Haze';
    } else if (condition == 800) {
      return 'Clear';
    } else if (condition <= 804) {
      return 'Cloudy';
    } else {
      return 'Cloudy‍';
    }
  }

}
