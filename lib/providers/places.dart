import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(
      String setTitle, File takenImage, PlaceLocation pickedLocation) async {
    final pickedAddress = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude!, pickedLocation.longitude!);
    final finalLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: pickedAddress);
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: setTitle,
      image: takenImage,
      location: finalLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    //DBHelper is the static class created in helper folder. Being static allows for usage without the need to instanciate
    DBHelper.insert('places', {
      'id': newPlace.id!,
      'title': newPlace.title!,
      'image': newPlace.image!.path,
      'loc_lat': newPlace.location!.latitude!,
      'loc_lng': newPlace.location!.longitude!,
      'address': newPlace.location!.address!,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dbPlaceList = await DBHelper.fetchData('places');
    _items = dbPlaceList
        .map((place) => Place(
              id: place['id'],
              title: place['title'],
              image: File(place['image']),
              location: PlaceLocation(
                latitude: place['loc_lat'],
                longitude: place['loc_lng'],
                address: place['address'],
              ),
            ))
        .toList();
    notifyListeners();
  }
}
