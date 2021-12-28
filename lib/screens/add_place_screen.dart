import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/widgets/image_input.dart';
import '/providers/places.dart';
import '/widgets/location_input.dart';
import '/models/place.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place-screen';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();

  File _pickedImage = File('');

  PlaceLocation? _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedLocation == null) {
      return;
    }
    Provider.of<Places>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage, _pickedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Zabe'),
        centerTitle: true,
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ImageInput(_selectImage),
                    SizedBox(
                      height: 20,
                    ),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              fixedSize: Size(190, 45),
              primary: Theme.of(context).colorScheme.secondary,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: _savePlace,
          ),
        ],
      ),
    );
  }
}
