import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/Animation_folder/height_width.dart';
import 'package:gallery_app/Login_folder/Cubit_auth/auth_state.dart';
import 'package:gallery_app/Reusable_folder/text_style_widget.dart';
import '../Animation_folder/animation_screen.dart';
import 'Cubit_auth/auth_cubit.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen>  {

  bool isAnimated = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  padding: const EdgeInsets.symmetric(horizontal:40.0,vertical:40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome",style: headLineTextBlack,),
                      50.height,

                       ///___ Enter your number
                       TextField(
                         controller: phoneController,
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
                          child: BlocConsumer<AuthCubit,AuthState>(
                            builder: (context, state) {
                              if(state is AuthLoadingState){
                                return const SizedBox(height:25,width:25,child: CircularProgressIndicator(color: Colors.black,));
                              }
                              return ElevatedButton(onPressed: (){

                                String phoneNumber = "+91"+phoneController.text;
                                BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);

                              }, child:  isAnimated ? const Icon(Icons.check_circle_outline,color: Colors.white,):const Text("Submit"));

                            },
                            listener:(context, state) {
                              if(state is AuthCodeSendState){
                                setState(() {
                                  isAnimated = !isAnimated;
                                });
                              }

                            },
                          )
                      ),
                      5.height,

                      ///___ Verify otp
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        //margin: MediaQuery.of(context).viewInsets.bottom.toDouble(),
                        height:isAnimated ? 150:0 ,
                        //color: Colors.grey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [

                              ///___ Verify otp
                              TextField(
                                controller: otpController,
                                style: titleTextBlack,
                                decoration: InputDecoration(
                                  label: const Text("Verify otp"),
                                  labelStyle: titleTextBlack,
                                  focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                  enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                ),
                              ),

                              35.height,
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child:BlocConsumer<AuthCubit,AuthState>(
                                    builder: (context, state) {
                                      if(state is AuthLoadingOtpState){
                                        return const SizedBox(height:25,width:25,child: CircularProgressIndicator(color: Colors.black,));
                                      }
                                      return isAnimated ? ElevatedButton(onPressed: (){
                                        BlocProvider.of<AuthCubit>(context).verifyOTP(otpController.text);
                                      }, child: const Text("Verify")):const SizedBox();
                                    },

                                    listener: (context, state) {
                                      if(state is AuthLoggedInState){
                                        Navigator.popUntil(context, (route) => route.isFirst);
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const AnimationScreen()));
                                      }

                                      else if(state is AuthErrorState){
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(state.error)),);
                                      }
                                    },
                                  )

                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
