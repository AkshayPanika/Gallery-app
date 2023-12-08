
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_cubit.dart';

class AuthCubit extends Cubit<AuthState>{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthCubit() : super(AuthInitialState()){
    User? currentUser = _auth.currentUser;
    if(currentUser != null){
      // login
      emit(AuthLoggedInState(currentUser));
    }
    else{
      // logout
      emit(AUthLoggedOutState());
    }
  }

  String? _verificationId;
  ///___ sendOTP
  void sendOTP(String phoneNumber)async{
    emit(AuthLoadingState());
    await _auth.verifyPhoneNumber(
        phoneNumber:phoneNumber ,
        codeSent: (verificationId,forceResendingToken){
          _verificationId = verificationId;
          emit(AuthCodeSendState());
        },
        verificationCompleted: (phoneAuthCredential){
          signInWithPhone(phoneAuthCredential);
        },
        verificationFailed: (error){
          emit(AuthErrorState(error.message.toString()));
        },
        codeAutoRetrievalTimeout: (verificationId){
          _verificationId = verificationId;
        });
  }

  ///___ verifyOTP
  void verifyOTP(String otp)async{
    emit(AuthLoadingOtpState());
    PhoneAuthCredential credential =PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp);
    signInWithPhone(credential);
  }

  ///___ signInWithPhone
  void signInWithPhone(PhoneAuthCredential credential)async{
    try{
      UserCredential userCredential =await _auth.signInWithCredential(credential);
      if(userCredential.user != null){
        emit(AuthLoggedInState(userCredential.user!));
      }
    }
    on FirebaseAuthException catch(ex){
      emit(AuthErrorState(ex.message.toString()));
    }
  }

  ///---- logOut
  void logOut()async{
    await _auth.signOut();
    emit(AUthLoggedOutState());
  }
}