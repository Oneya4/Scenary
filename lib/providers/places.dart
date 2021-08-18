import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../models/place.dart';

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
  }
}
