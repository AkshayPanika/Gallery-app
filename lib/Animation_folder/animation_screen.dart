import 'package:flutter/material.dart';
import 'package:gallery_app/Reusable_folder/text_style_widget.dart';
import 'package:gallery_app/Screen_folder/home_screen.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}
class _AnimationScreenState extends State<AnimationScreen> with TickerProviderStateMixin {
  bool isAnimated = false;
  late  AnimationController animationController;
  late Animation<Offset> slideAnimationLeft;
  late Animation<Offset> slideAnimationRight;
  late Animation<Offset> slideAnimationBottom;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    slideAnimationLeft = Tween(
      begin: const Offset(0,0),
      end: const Offset(-1.5,0),
    ).animate(CurvedAnimation(parent: animationController.view, curve: Curves.linear));
    slideAnimationRight = Tween(
      begin: const Offset(0,0),
      end: const Offset(1.5,0),
    ).animate(CurvedAnimation(parent: animationController.view, curve: Curves.linear));
    slideAnimationBottom = Tween(
      begin: const Offset(0,2),
      end: const Offset(0,0),
    ).animate(CurvedAnimation(parent: animationController.view, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ///___ Main black screen
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black,
                  child:Center(child: Text("Welcome",style:headLineTextWight)),
                ),

                ///___ Dore animation
                InkWell(
                  child: Row(
                    children: [
                      Expanded(
                        child: SlideTransition(
                          position: slideAnimationLeft,
                          child: Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height,
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(""),Text("Gall",style:headLineTextBlack)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SlideTransition(
                          position: slideAnimationRight,
                          child: Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("ery",style:headLineTextBlack),
                                const Text(""),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: (){
                    if(isAnimated){
                      isAnimated = false;
                      animationController.reverse();
                    }
                    else{
                      isAnimated = true;
                      animationController.forward();
                    }
                    setState(() {

                    });
                  },
                ),

                  ///___ Home page
              SlideTransition(
                  position:slideAnimationBottom,
                 child: const HomeScree()
              ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
