import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gallery_app/Animation_folder/height_width.dart';

import '../Reusable_folder/text_style_widget.dart';
import '../Services_folder/my_store.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.only(left:8,right: 8,bottom: 0),
      child: Column(
        children: [

          ///___ headline
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Today",style: titleTextBlack,),
              Text("View all",style: titleTextBlue,),
            ],
          ),

          ///___ Today galley
          10.height,
          Expanded(
            child: MasonryGridView.builder(
              itemCount:myStore.length,
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(child: Image.network(myStore[index].toString()),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPhotos(
                        image:myStore[index].toString(),
                        mIndex:myStore[index].length,
                      )));
                    },
                  ),
                );
                //return  Image.network('https://source.unsplash.com/random?sig=$index');
              },),
          ),
        ],
      ),
    );
  }
}
class ViewPhotos extends StatelessWidget {
  final String image;
  final int mIndex;
  const ViewPhotos({super.key, required this.image, required this.mIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: PageView.builder(
        itemCount: myStore.length,
        itemBuilder: (context, index) {
          return Center(child: Image.network(image));
        },),
    );
  }
}

