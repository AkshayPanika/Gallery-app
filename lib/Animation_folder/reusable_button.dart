import 'package:flutter/material.dart';
import 'package:gallery_app/Reusable_folder/text_style_widget.dart';

class ReusableButton extends StatelessWidget {
  final String title;
  const ReusableButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.black,
      ),
      child: Center(child: Text(title,style: tranParentText,),),
    );
  }
}
