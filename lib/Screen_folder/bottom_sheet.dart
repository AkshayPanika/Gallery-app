import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/Animation_folder/height_width.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../Animation_folder/reusable_button.dart';
import '../Services_folder/user_model.dart';

class BottomSheetScreen extends StatefulWidget {
  const BottomSheetScreen({super.key});

  @override
  State<BottomSheetScreen> createState() => _BottomSheetScreenState();
}

class _BottomSheetScreenState extends State<BottomSheetScreen> {

  void saveImage()async{
   if(imageUrl != null){

    UploadTask uploadTask =  FirebaseStorage.instance.ref().child("users").child(Uuid().v1()).putFile(imageUrl!);
    TaskSnapshot taskSnapshot = await uploadTask;
   String downloadUrl = await taskSnapshot.ref.getDownloadURL();
     var userData = UserModel(imageUrl:downloadUrl, dateTime: "${DateFormat('jms').format(DateTime.now())},  ${DateFormat('yMMMd').format(DateTime.now())}" ).toMap();
    FirebaseFirestore.instance.collection("users").add(userData);
    log("User created!");

   }
   else{
     print("Not selected");
   }
   setState(() {
     imageUrl = null;
   });
  }
  File? imageUrl;

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
            return  SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  children: [
                    30.height,
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CardWidget(iconData: Icons.image, title: "Photos",
                        image: imageUrl  != null ? DecorationImage(image:FileImage(imageUrl!) ):null,
                        onTap: ()async{
                          XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

                          if(selectedImage != null){
                            File convertedFile = File(selectedImage.path);
                            setState(() {
                              imageUrl = convertedFile;
                            });
                            log("Image selected!");
                          }
                          else{
                            log("Image not selected!");
                          }

                        }
                        ),
                        CardWidget(iconData: Icons.video_collection, title: "Videos",
                          onTap: (){},
                        ),
                        CardWidget(iconData: Icons.audio_file, title: "Audios",
                          onTap: (){},
                        ),
                      ],
                    ),
                    20.height,

                    ///___ Type description...
                    /*const TextField(
                      decoration: InputDecoration(
                        hintText: "Type description...",
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 0.9)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 0.9)),
                      ),
                    ),*/
                    50.height,

                    Align(
                        alignment: Alignment.centerRight,
                      child: InkWell(
                          onTap: (){
                            saveImage();
                            Navigator.pop(context);
                          },
                          child: const ReusableButton(title: "Save")),
                    )
                  ],
                ),
              ),
            );
          },);
      },
    );
  }
}
class CardWidget extends StatelessWidget {
  final IconData iconData;
 final String title;
 DecorationImage? image;
 final VoidCallback onTap;
   CardWidget({super.key, required this.iconData, required this.title,  this.image, required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: 60,width: 60,
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(4),
              image: image,
            ),
            child: Center(child: Icon(iconData,color: Colors.black54,),),
          ),
        ),
        10.height,
        Text(title),
      ],
    );

  }
}

