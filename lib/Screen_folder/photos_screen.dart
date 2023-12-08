import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gallery_app/Animation_folder/height_width.dart';
import '../Reusable_folder/text_style_widget.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen ({super.key});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {


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

          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("users").snapshots(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.active){
                  if(snapshot.hasData && snapshot.data != null){
                    return   Expanded(
                      child: MasonryGridView.builder(
                        itemCount:snapshot.data!.docs.length,
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, index) {
                          Map<String,dynamic> userMap = snapshot.data!.docs[index].data() as Map<String,dynamic>;

                          return Padding(
                            padding:  const EdgeInsets.all(5.0),
                            child:  InkWell(
                              child: Image.network(userMap["imageUrl"]),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPhotos(
                                  image:userMap["imageUrl"],
                                )));
                              },
                            ),
                          );
                        },),
                    );
                  }
                  else{
                    return const Center(child: Text("No data!"));
                  }
                }
                else{
                  return const Center(child: CircularProgressIndicator(color: Colors.black,),);
                }
              },),

        ],
      ),
    );
  }
}
class ViewPhotos extends StatelessWidget {
  final String image;
  const ViewPhotos({super.key, required this.image,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: PageView.builder(
        itemCount:2,
        itemBuilder: (context, index) {
        return Container(
          height: double.infinity,width: 500,
            margin: const EdgeInsets.all(5),
            child: Image.network(image,fit: BoxFit.fill,));
      },),
    );
  }
}
