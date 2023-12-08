import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/Login_folder/Cubit_auth/auth_cubit.dart';
import 'package:gallery_app/Login_folder/Cubit_auth/auth_state.dart';
import 'package:gallery_app/Login_folder/login_screen.dart';
import 'package:gallery_app/firebase_options.dart';
import 'Animation_folder/animation_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const GalleryApp());
}

class GalleryApp extends StatelessWidget {
  const GalleryApp({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(create: (context) => AuthCubit(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthCubit,AuthState>(
        buildWhen: (oldState,newState){
          return oldState is AuthInitialState;
        },
        builder: (context, state) {
          if(state is AuthLoggedInState){
            return const AnimationScreen();
          }
          else if(state is AUthLoggedOutState){
            return const LogInScreen();
          }
          else{
            return const Scaffold();
          }
        },
      ),
    ),
    );
  }
}