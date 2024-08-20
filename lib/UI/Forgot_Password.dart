import 'package:backend_app_01/Utils/Utils.dart';
import 'package:backend_app_01/Widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
  return SafeArea(
  child: Scaffold(
  appBar: AppBar(
  centerTitle: true,
    automaticallyImplyLeading: false,
    iconTheme: const IconThemeData(
    color: Colors.white,
    ),
    backgroundColor: Colors.deepPurple,
    title: const Text(
    'Reset Password',
    style: TextStyle(
    color: Colors.white,
    ),
    ),
    ),
  

  body: Padding(
    padding: const EdgeInsets.symmetric(
    horizontal: 20,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    
    TextFormField(
    controller: emailController,
    decoration: InputDecoration(
    hintText: 'Email',
    
    ),
    ),

    const SizedBox(
    height: 40,
    ),

    RoundButton(
    title: 'Forgot',
    loading: loading, 
    ontap: ()
    { 
      setState(() {
        loading = true;
      });
      auth.sendPasswordResetEmail(
      email: emailController.text.toString(),
      ).then((value) {
        setState(() {
        loading = false;
        });
        Utils().toastMessage('Recovery Email is send to email provided. Please check.');
      }).onError((error, stackTrace) {
        setState(() {
        loading = false;
        });
        Utils().toastMessage(error.toString());
      });
    },
    ),
    
    ],
    ),
  ),
  ),
  ); 
  }
}