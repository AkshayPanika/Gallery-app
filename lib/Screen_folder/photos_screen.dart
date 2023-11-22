import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../Reusable_folder/text_style_widget.dart';

class PhotosScreen extends StatelessWidget {
  const PhotosScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          ///___ headline
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Today",style: titleTextBlack,),
                Text("View all",style: titleTextBlue,),
              ],
            ),
          ),
          ///___ Today galley
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:4.0),
              child: MasonryGridView.builder(
                itemCount: 25,
                //physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  return  Card(
                    color: Colors.grey,
                    child: SizedBox(
                        height: 150,
                        child: Image.network('https://source.unsplash.com/random?sig=$index')
                    ),
                  );
                },),
            ),
          ),
        ],
      ),
    );
  }
}
