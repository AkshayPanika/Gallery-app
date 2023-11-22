import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/Animation_folder/height_width.dart';

import '../Animation_folder/reusable_button.dart';

class BottomSheetScreen extends StatelessWidget {
  const BottomSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Card(
        shape: OutlineInputBorder(),
        child:Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.add,size: 30,),
        ),
      ),
      onTap: (){
        showModalBottomSheet(context: context,
          showDragHandle: true,
          builder: (context) {
            return  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                children: [
                  30.height,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CardWidget(iconData: Icons.image),
                      CardWidget(iconData: Icons.video_collection),
                      CardWidget(iconData: Icons.audio_file),
                    ],
                  ),
                  50.height,

                  ///___ Type description...
                  const TextField(
                    decoration: InputDecoration(
                      hintText: "Type description...",
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 0.9)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 0.9)),
                    ),
                  ),
                  50.height,

                  const Align(
                      alignment: Alignment.centerRight,
                    child: ReusableButton(title: "Save"),
                  )
                ],
              ),
            );
          },);
      },
    );
  }
}
class CardWidget extends StatelessWidget {
  final IconData iconData;
  const CardWidget({super.key, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade700,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Icon(iconData,size: 25,color: Colors.white,),
      ),
    );

  }
}

