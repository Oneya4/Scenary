import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String setTitle, File takenImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: setTitle,
      image: takenImage,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
    //DBHelper is the static class created in helper folder. Being static allows for usage without the need to instanciate
    DBHelper.insert('places', {
      'id': newPlace.id!,
      'title': newPlace.title!,
      'image': newPlace.image!.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dbPlaceList = await DBHelper.fetchData('places');
    _items = dbPlaceList
        .map((place) => Place(
              id: place['id'],
              title: place['title'],
              image: File(place['image']),
              location: null,
            ))
        .toList();
    notifyListeners();
  }
}
