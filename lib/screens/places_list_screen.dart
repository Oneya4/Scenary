import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screens/add_place_screen.dart';
import '/providers/places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: Consumer<Places>(
        child: Center(
          child: const Text('You haven\'t added any places yet.'),
        ),
        builder: (ctx, placeData, ch) => placeData.items.length <= 0
            ? ch!
            : ListView.builder(
                itemCount: placeData.items.length,
                itemBuilder: (ctx, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(placeData.items[index].image!),
                  ),
                  title: Text(placeData.items[index].title!),
                  onTap: () {},
                ),
              ),
      ),
    );
  }
}
