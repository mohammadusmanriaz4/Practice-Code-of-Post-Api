import 'package:backend_app_01/UI/Auth/Login_with_phone_number.dart';
import 'package:backend_app_01/UI/Auth/SignUp_Screen.dart';
import 'package:backend_app_01/UI/Database_Selection.dart';
import 'package:backend_app_01/UI/Forgot_Password.dart';
import 'package:backend_app_01/Utils/Utils.dart';
import 'package:backend_app_01/Widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> 
{

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance ;

  bool loading = false;




  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  void login ()
  { 
    setState(() {
      loading = true;
    });

    _auth.signInWithEmailAndPassword(
    email: emailcontroller.text, 
    password: passwordcontroller.text.toString(),
    ).then((value) 
    {
      Utils().toastMessage(value.user!.email.toString());
      
      Navigator.push(
      context as BuildContext, 
      MaterialPageRoute(
      builder: (context) => DatabaseSelectionScreen(),
      ));

      setState(() {
      loading = false;
    });

    }).onError((error, stackTrace)
    {
      Utils().toastMessage(error.toString());

      setState(() {
      loading = false;
      });

    });
  }


  Widget build(BuildContext context) {
  return WillPopScope(
    onWillPop: () async {
      SystemNavigator.pop();
      return true;
    },
    child: SafeArea(
    child: Scaffold(
    appBar: AppBar(
    backgroundColor: Colors.deepPurple,
    centerTitle: true,
    automaticallyImplyLeading: false,
    title:const Text(
    "Login",
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
    height: 20,
    ),
    
    
    RoundButton(
    title: 'Login',
    loading: loading,
    ontap: () {
      if(_formkey.currentState!.validate())
      {
        login();
      }
    },
    ),


   
    Align(
    alignment: Alignment.topRight,
    child: TextButton(
      onPressed: ()
      {
        Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => ForgotPasswordScreen()
          ),
        
        );
      }, 
    
      child: const Text(
      'Forgot Password',
      style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      ),
      ),
      ),
    ),

  
     
    
    
   

    InkWell(
      onTap: () 
      {
        Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => LoginWithPhoneNumber(),
        ));
      },
      child: Container(
      height: 45,
      width: 280,
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(120),
      color: Colors.cyan,
      ),
      child: const Center(
      child: Text(
      'Login with Phone Number',
      style: TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      ),
      ),
      ),
      ),
      ),


      const SizedBox(
      height: 10,
      ),



     Row(
      mainAxisAlignment: MainAxisAlignment.end,
    children: [
      const Text(
      "Don't have an account?",
      textAlign: TextAlign.center,
      style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      ),
      ),


      TextButton(
      onPressed: ()
      {
        Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => SignUpScreen()
          ),
        
        );
      }, 
    
      child: const Text(
      'Sign Up',
      style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      ),
      ),
      ),
    
    
    ],
    ),


    
    
    
    ],
    ),
    ),
    ),
    ),
  ); 
  }
}