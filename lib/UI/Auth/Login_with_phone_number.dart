import 'package:backend_app_01/UI/Auth/Verify_Code.dart';
import 'package:backend_app_01/Utils/Utils.dart';
import 'package:backend_app_01/Widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {

  final phoneNumberController = TextEditingController();

  final auth = FirebaseAuth.instance;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
  return SafeArea(
  child: Scaffold(
  appBar: AppBar(
  centerTitle: true,
  iconTheme: const IconThemeData(
  color: Colors.white,
  ),
  backgroundColor: Colors.deepPurple,
  title: const Text(
  'Login with Phone Number',
  style: TextStyle(
  color: Colors.white,
  ),
  ),
  ),
  

  body: Padding(
    padding: const EdgeInsets.symmetric(
    horizontal: 40,
    ),
    child: Column(
    children: [
    
      const SizedBox(
      height: 80,
      ),
    
      TextFormField(
      controller: phoneNumberController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
      hintText: '+1 345 567 780',
      
      ),
      ),


      const SizedBox(
      height: 80,
      ),

      RoundButton(
      title: 'Login', 
      loading: loading,
      ontap: () 
      { 
        setState(() {
          loading = true;
        });

        auth.verifyPhoneNumber(
        phoneNumber: phoneNumberController.text,
        verificationCompleted: (_) {
        setState(() {
          loading = false;
        });
        },

        codeSent:(String verificationId, int? token) 
        {
          Navigator.push(
          context, 
          MaterialPageRoute(
          builder: (context) => VerifyCodeScreen(
          verificationId: verificationId,
          ),
          ), 
          );
          setState(() {
          loading = false;
          });
        }, 

        verificationFailed: (e)
        {
          setState(() {
          loading = false;
          });
          Utils().toastMessage(e.toString());
        }, 
        
        codeAutoRetrievalTimeout: (e)
        {
          Utils().toastMessage(e.toString());
          setState(() {
          loading = false;
          });
        }, 
        );
      },
      ),
    
    ],
    ),
  ),

  ),
  ); 
  }
}