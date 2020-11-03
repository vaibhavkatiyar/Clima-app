import 'package:geolocator/geolocator.dart';

class Location{
  double latitude;
  double longitude;

  Future<void> getCurrenttLocation() async{
    try{
      Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      latitude=position.latitude;
      longitude=position.longitude;
    }
    catch(e){
      print(e);
    }

  }
}
