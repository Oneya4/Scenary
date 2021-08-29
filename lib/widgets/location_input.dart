import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '/screens/maps_screen.dart';
import '/helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double lat, double lng) async {
    final staticMapImage = LocationHelper.generateImageLocation(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _previewImageUrl = staticMapImage;
    });
  }

  Future<void> _getUserCurrentLocation() async {
    try {
      final locData = await Location().getLocation();
      final staticMapImage = LocationHelper.generateImageLocation(
        latitude: locData.latitude,
        longitude: locData.longitude,
      );
      setState(() {
        _previewImageUrl = staticMapImage;
      });
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapsScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
            width: 1,
            color: Colors.grey,
          )),
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          child: _previewImageUrl == null
              ? Text(
                  'No Location Chosen Yet',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              onPressed: _getUserCurrentLocation,
            ),
            TextButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select From Map'),
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}
