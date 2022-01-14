import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
      //   centerTitle: true,
      //   backgroundColor: Colors.transparent,
      // ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: deviceHeight * .32,
              child: CachedNetworkImage(
                imageUrl:
                    'https://media-magazine.trivago.com/wp-content/uploads/2017/05/28132442/cook-islands-resorts.jpg',
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: LinearProgressIndicator(value: progress.progress),
                ),
              ),
            ),
          ),
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Container(
                height: deviceHeight * .71,
                // padding: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary),
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
                                  itemBuilder: (ctx, index) => Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(8, 0, 8, 5),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.teal,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage: FileImage(
                                                placeData.items[index].image!),
                                          ),
                                          title: Text(
                                              placeData.items[index].title!),
                                          subtitle: Text(placeData
                                              .items[index].location!.address!),
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                              PlaceDetailScreen.routeName,
                                              arguments:
                                                  placeData.items[index].id,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
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
