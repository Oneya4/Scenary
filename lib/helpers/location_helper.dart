import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_API_KEY = '';

class LocationHelper {
  static String generateImageLocation({double? latitude, longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=17&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=YOUR_API_KEY');
    final response = await http.get(url);
    return jsonDecode(response.body)['result'][0]['formatted_address'];
  }
}

//You can also use this to display a static yandex map
// static String generateImageLocation({double? latitude, longitude}) {
//     return 'https://static-maps.yandex.ru/1.x/?lang=en_US&z=17&size=500,350&l=map&ll=$longitude,$latitude&z=15&pt=$longitude,$latitude,round';
//   }
