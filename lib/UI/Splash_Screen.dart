import 'package:backend_app_01/Firebase_Services/Splash_Services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices  splashServices = SplashServices();

  @override
  void initState()
  {
    super.initState();
    splashServices.isLogin(context); //Asif uses splasScreen instead of splashServices
  }

  @override
  Widget build(BuildContext context) {
  return SafeArea(
  child: Scaffold(
  appBar: AppBar(
  
  ),

  body: const Center(
  child: Text(
  'Firebase App',
  style: TextStyle(
  fontSize: 36,
  color: Colors.indigo,
  fontWeight: FontWeight.bold,
  ),
  ),
  ),

  ),
  );
  }
}