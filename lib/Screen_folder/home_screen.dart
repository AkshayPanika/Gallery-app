import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gallery_app/Animation_folder/height_width.dart';
import 'package:gallery_app/Screen_folder/photos_screen.dart';
import '../Reusable_folder/text_style_widget.dart';
import 'bottom_sheet.dart';

class HomeScree extends StatefulWidget {
  const HomeScree({super.key});

  @override
  State<HomeScree> createState() => _HomeScreeState();
}

class _HomeScreeState extends State<HomeScree> with SingleTickerProviderStateMixin {

  List myPhotos = ["Akshay","Soniya","Akshat","Akchita","Akshra"];

  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [

                ///___ AppBar
                40.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("   Gallery",style: titleTextBlack),
                    Row(
                      children: [
                        IconButton(onPressed: (){}, icon:const Icon(Icons.search)),
                        IconButton(onPressed: (){}, icon:const Icon(Icons.more_vert)),
                      ],
                    ),
                  ],
                ),

                ///___ TabBar
                TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.black,
                  tabs:  [
                    Tab(child: Text("Photos",style: titleTextBlue,),),
                    Tab(child: Text("Video",style: titleTextBlue,),),
                  ],
                ),

                20.height,
                SizedBox(
                 height:MediaQuery.of(context).size.height,
                  child: TabBarView(
                     controller: _tabController,
                     children:<Widget> [
                  ///___ Photos
                       PhotosScreen(),

                  ///___ Videos
                  Column(
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
                            itemCount: 40,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                            ),
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.grey,
                                child: SizedBox(
                                    height: 150,width: 100,
                                    child: Image.network('https://source.unsplash.com/random?sig=$index')),
                              );
                            },),
                        ),
                      ),

                    ],
                  ),

                     ],
                   ),
                ),
              ],
            ),
          ),

          const Positioned(
              bottom: 15,
              right: 15,
              child: BottomSheetScreen()
          ),
        ],
      ),
    );
  }
}
