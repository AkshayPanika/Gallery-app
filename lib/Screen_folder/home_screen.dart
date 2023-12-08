import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/Animation_folder/height_width.dart';
import 'package:gallery_app/Login_folder/Cubit_auth/auth_cubit.dart';
import 'package:gallery_app/Login_folder/Cubit_auth/auth_state.dart';
import 'package:gallery_app/Login_folder/login_screen.dart';
import 'package:gallery_app/Screen_folder/photos_screen.dart';
import 'package:gallery_app/Screen_folder/video_screen.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import '../Reusable_folder/text_style_widget.dart';
import 'bottom_sheet.dart';

class HomeScree extends StatefulWidget {
  const HomeScree({super.key});

  @override
  State<HomeScree> createState() => _HomeScreeState();
}

class _HomeScreeState extends State<HomeScree> with SingleTickerProviderStateMixin {

  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [

                  ///___ AppBar
                  5.height,
                  ListTile(
                    title:  Text("   Gallery",style: headLineTextBlack2),

                    ///___ PopupMenuButton
                    trailing: PopupMenuButton(
                      icon: const Icon(Icons.more_vert,color: Colors.black,),
                     itemBuilder: (context) => [

                       ///___ LogOut
                       PopupMenuItem(
                         onTap: (){
                           BlocProvider.of<AuthCubit>(context).logOut();
                         },
                           child:  BlocConsumer<AuthCubit,AuthState>(builder: (context, state) {
                         return const Text("LogOut");
                       },
                         listener: (context, state) {
                           if(state is AUthLoggedOutState){
                             Navigator.popUntil(context, (route) => route.isFirst);
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LogInScreen()));
                           }
                         },)),
                     ],
                    )
                  ),

                  5.height,
                  StickyHeader(
                    ///___ TabBar
                    header: Container(
                      color: Colors.white,
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: Colors.black,
                        tabs:  [
                          Tab(child: Text("Photos",style: titleTextBlack,),),
                          Tab(child: Text("Video",style: titleTextBlack,),),
                        ],
                      ),
                    ) ,

                    ///___ List view
                    content: Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: SizedBox(
                        height:MediaQuery.of(context).size.height,
                        child: TabBarView(
                          controller: _tabController,
                          children:const <Widget> [
                            ///___ Photos
                            PhotosScreen(),

                            ///___ Videos
                            VideoScreen(),

                          ],
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),

            const Positioned(
                bottom: 55,
                right: 25,
                child: BottomSheetScreen()
            ),
          ],
        ),
      ),
    );
  }
}
