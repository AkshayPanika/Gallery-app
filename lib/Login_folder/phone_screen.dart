import 'package:flutter/material.dart';
import 'package:gallery_app/Animation_folder/height_width.dart';
import 'package:gallery_app/Reusable_folder/text_style_widget.dart';

class PhoneScreen extends StatelessWidget {
  const PhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          //gradient: LinearGradient(colors:Colors )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Card(
                elevation: 3,
                shape:  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                color: Colors.grey[300],
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal:40.0,vertical:50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome",style: headLineTextBlack,),
                      80.height,

                       ///___ Enter your number
                       TextField(
                        style: titleTextBlack,
                         decoration: InputDecoration(
                           label: const Text("Enter your number"),
                           labelStyle: titleTextBlack,
                           focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                           enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                         ),
                      ),
                      35.height,

                      ///___ Submit button
                      Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(onPressed: (){}, child: const Text("Submit"))
                      ),
                      35.height,


                      ///___ Otp text
                      SizedBox(
                        //color: Colors.red,
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,itemBuilder: (context, index) {
                          return Card(child: SizedBox(
                            width: 30,
                              child: Center(child: Text("0",style: titleTextBlack,))));
                        },),
                      ),
                      10.height,
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
