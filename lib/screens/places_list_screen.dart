import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screens/add_place_screen.dart';
import '/providers/places.dart';
import '/screens/places_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Your Places'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.add),
      //       onPressed: () {
      //         Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
      //       },
      //     ),
      //   ],
      // ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Container(
                height: deviceHeight * .35,
                decoration: BoxDecoration(color: Colors.black87),
              ),
            ),
          ),
          Positioned(
            top: 240,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Container(
                height: deviceHeight * .75,
                decoration: BoxDecoration(color: Colors.grey),
                child: FutureBuilder(
                  future: Provider.of<Places>(context, listen: false)
                      .fetchAndSetPlaces(),
                  builder: (ctx, futureResult) => futureResult
                              .connectionState ==
                          ConnectionState.waiting
                      ? Center(child: CircularProgressIndicator())
                      : Consumer<Places>(
                          child: Center(
                            child: const Text(
                                'You haven\'t added any places yet.'),
                          ),
                          builder: (ctx, placeData, ch) => placeData
                                      .items.length <=
                                  0
                              ? ch!
                              : ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: placeData.items.length,
                                  itemBuilder: (ctx, index) => ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: FileImage(
                                          placeData.items[index].image!),
                                    ),
                                    title: Text(placeData.items[index].title!),
                                    subtitle: Text(placeData
                                        .items[index].location!.address!),
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        PlaceDetailScreen.routeName,
                                        arguments: placeData.items[index].id,
                                      );
                                    },
                                  ),
                                ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
