import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/places.dart';
import 'maps_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail-screen';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final filterId = ModalRoute.of(context)!.settings.arguments;
    final selectedPlace = Provider.of<Places>(context, listen: false)
        .findById(filterId.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title!),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(80),
              bottomRight: Radius.circular(80),
            ),
            child: Container(
              height: deviceSize.height * .65,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20),
              child: Image.file(
                selectedPlace.image!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Text(selectedPlace.location!.address!, textAlign: TextAlign.center),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: Text('Other places like this'),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  elevation: 10,
                  enableFeedback: true,
                ),
              ),
              OutlinedButton(
                child: Text('View on Map'),
                style: OutlinedButton.styleFrom(
                  shape: StadiumBorder(),
                  elevation: 10,
                  enableFeedback: true,
                ),
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
        ],
      ),
    );
  }
}
