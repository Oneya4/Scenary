import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/places.dart';
import 'maps_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail-screen';

  @override
  Widget build(BuildContext context) {
    final filterId = ModalRoute.of(context)!.settings.arguments;
    final selectedPlace = Provider.of<Places>(context, listen: false)
        .findById(filterId.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title!),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image!,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 10),
          Text(selectedPlace.location!.address!, textAlign: TextAlign.center),
          SizedBox(height: 10),
          TextButton(
            child: Text('View on Map'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapsScreen(
                    initialLocation: selectedPlace.location!,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
