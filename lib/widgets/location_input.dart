import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          child: _previewImageUrl != null
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
          children: [
            TextButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              onPressed: () {},
            ),
            TextButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select From Map'),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
