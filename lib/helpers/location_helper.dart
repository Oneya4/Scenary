import 'package:http/http.dart' as http;
import 'dart:convert';

// const GOOGLE_API_KEY = 'AIzaSyBg9yn5JtQgKRFbg6FCTy4ewbF24kRuAYI';

class LocationHelper {
  static String generateImageLocation({double? latitude, double? longitude}) {
    return 'https://static-maps.yandex.ru/1.x/?lang=en_US&z=17&size=500,350&l=map&ll=$longitude,$latitude&z=15&pt=$longitude,$latitude,round';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=YOUR_API_KEY';
    final response = await http.;
  }
}
