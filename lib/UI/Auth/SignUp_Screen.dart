import 'package:backend_app_01/UI/Auth/Login_Screen.dart';
import 'package:backend_app_01/Utils/Utils.dart';
import 'package:backend_app_01/Widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool loading = false;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;

  void signUp ()
  {
    setState(() {
        loading = true;
      });

      _auth.createUserWithEmailAndPassword(
      email: emailcontroller.text.toString(), 
      password: passwordcontroller.text.toString(),
      ).then((value) {
        setState(() {
        loading = false;
      });

      }).onError((error, stackTrace) {
        Utils().toastMessage(error.toString());
        setState(() {
        loading = false;
      });
        
      });
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }


  Widget build(BuildContext context) {
  return SafeArea(
  child: Scaffold(
  appBar: AppBar(
  iconTheme: const IconThemeData(
  color: Colors.white,
  ),
  backgroundColor: Colors.deepPurple,
  centerTitle: true,
  title:const Text(
  "SignUp",
  style: TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
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
  
  Form(
  key: _formkey,
  child: Column(
  children: [
  

  TextFormField(
  controller: emailcontroller,
  keyboardType: TextInputType.emailAddress,
  decoration: const InputDecoration(
  label: Text(
  'Email',
  style: TextStyle(
  color: Colors.deepPurple,
  fontWeight: FontWeight.bold,
  ),
  ),
  hintText: 'firebase@gmail.com',
  prefixIcon: Icon(
  Icons.email,
  color: Colors.deepPurple,
  ),
  ),
  validator: (value) {
    if(value!.isEmpty)
    {
      return 'Enter Email';
    }
    return null;
  },
  ),

  const SizedBox(
  height: 10,
  ),

  TextFormField(
  controller: passwordcontroller,
  obscureText: true,
  keyboardType: TextInputType.text,
  decoration: const InputDecoration(
  label: Text(
  'Password',
  style: TextStyle(
  color: Colors.deepPurple,
  fontWeight: FontWeight.bold,
  ),
  ),
  hintText: '********',
  prefixIcon: Icon(
  Icons.password,
  color: Colors.deepPurple,
  ),
  ),
  validator: (value) {
    if(value!.isEmpty)
    {
      return 'Enter Password';
    }
    return null;
  },
  ),

  


  



  ],
  ),
  ),


  const SizedBox(
  height: 50,
  ),

  
  RoundButton(
  title: 'SignUp',
  loading: loading,
  ontap: () {
    if(_formkey.currentState!.validate())
    {
      signUp();
    }
  },
  ),

  const SizedBox(
  height: 30,
  ),

  Row(
    mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Text(
    "Already have an account?",
    ),

    TextButton(
    onPressed: ()
    {
      Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => LoginScreen()
        ),
      
      );
    }, 

    child: const Text('Sign In'),
    ),


  ],
  ),



  ],
  ),
  ),
  ),
  ); 
  }
}