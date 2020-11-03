import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'background.dart';

import 'city_screen.dart';

import '../services/weather.dart';



class LocationScreen extends StatefulWidget {

  LocationScreen({this.locationWeather});

  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}


class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weather=new WeatherModel();
  Background bg=new Background();

  FloatingActionButton btn1;
  FloatingActionButton btn2;

  int temp;
  int feelsLike;
  int tempmax,tempmin;
  int hum;
  String weatherIcon;
  String tempMessage;
  String cityName;
  double windspeed;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData){
    setState(() {
        double temperature=weatherData['main']['temp'];
        double feelslike=weatherData['main']['feels_like'];
        double max=weatherData['main']['temp_max'];
        double min=weatherData['main']['temp_min'];
        hum=weatherData['main']['humidity'];
        windspeed=weatherData['wind']['speed'];
        //print(windspeed);
        tempmax=max.toInt();
        tempmin=min.toInt();
        feelsLike=feelslike.toInt();
        temp=temperature.toInt();

        var condition=weatherData['weather'][0]['id'];
        weatherIcon=weather.getWeatherIcon(condition);
        cityName=weatherData['name'];
        temp=temp-273;
        feelsLike=feelsLike-273;
        tempmax=tempmax-273;
        tempmin=tempmin-273;

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bg.back()),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: btn1,
                    backgroundColor: Colors.blue,
                    onPressed: () async{
                      var weatherData=await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                  FloatingActionButton(
                    heroTag: btn2,
                    backgroundColor: Colors.blue,
                    onPressed: () async{
                      var typedName=await Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if(typedName!=null){
                        var weatherData=await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(

                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTextStyle,
                    ),
                    SizedBox(
                      width: 50.0,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kweatherCondition,
                   ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$cityName",
                  textAlign: TextAlign.right,
                  style: kCityName,
                ),
              ),
              Opacity(
                  opacity: 0.5,
                  child: Container(
                      height: 360.0,
                      width: 170.0,
                      margin: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFF0A0E21),

                      ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Feels Like',
                              style: kweather,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                                'Max Temp.',
                              style: kweather,

                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              '$feelsLike°',
                              style: kCityNameStyle,

                            ),
                            Text(
                              '$tempmax°',
                              style: kCityNameStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Min Temp.',
                              style: kweather,
                            ),
                            Text(
                              'Humidity',
                              style: kweather,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              '$tempmin°',
                              style: kCityNameStyle,
                            ),
                            Text(
                              '$hum',
                              style: kCityNameStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Wind Speed',
                          style: kweather,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                           Text(
                           '$windspeed',
                            style: kCityNameStyle,
                            ),
                            Text(
                              'm/s', 
                                style: TextStyle(
                                  fontSize: 40.0,
                                  fontFamily: 'Raleway',
                                ),
                            ),
                          ],
                        ),
                        
                      ],

                    ),

                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
