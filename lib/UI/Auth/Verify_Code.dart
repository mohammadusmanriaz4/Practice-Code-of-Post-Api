import 'package:backend_app_01/UI/Database_Selection.dart';
import 'package:backend_app_01/Utils/Utils.dart';
import 'package:backend_app_01/Widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyCodeScreen extends StatefulWidget 
{
  
  final String verificationId;
  
  VerifyCodeScreen
  ({
  required this.verificationId,
  super.key,
  });

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  
  final cerificationCodeController = TextEditingController();

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
  title:  Text(
  'Verify 6 Digit Code',
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
      controller: cerificationCodeController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
      hintText: '6 Digit Code.',
      
      ),
      ),


      const SizedBox(
      height: 80,
      ),

      RoundButton(
      title: 'Verify', 
      loading: loading,
      ontap: () 
      async { 
        setState(() {
         loading = true; 
        });

        final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, 
        smsCode: cerificationCodeController.text.toString(), 
        );

        try
        {
          await auth.signInWithCredential(credential);
          Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => DatabaseSelectionScreen(),
          ) 
          );
        }
        catch(e)
        {
          setState(() {
            loading = true; 
          });
          Utils().toastMessage(e.toString());
        }

        
      },
      ),
    
    ],
    ),
  ),

  ),
  ); 
  
  }
}

