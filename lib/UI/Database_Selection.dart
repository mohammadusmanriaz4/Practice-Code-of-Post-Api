import 'package:backend_app_01/Firestore/Firestore_List_Screen.dart';
import 'package:backend_app_01/UI/Posts/Posts_Screen.dart';
import 'package:flutter/material.dart';

class DatabaseSelectionScreen extends StatefulWidget {
  const DatabaseSelectionScreen({super.key});

  @override
  State<DatabaseSelectionScreen> createState() => _DatabaseSelectionScreenState();
}

class _DatabaseSelectionScreenState extends State<DatabaseSelectionScreen> {
  @override
  Widget build(BuildContext context) {
  return SafeArea(
  child: Scaffold(
    

  appBar: AppBar(
    centerTitle: true,
    //automaticallyImplyLeading: false,
    iconTheme: const IconThemeData(
    color: Colors.white,
    ),
    backgroundColor: Colors.deepPurple,
    title: const Text(
    'Select Database to Post',
    style: TextStyle(
    color: Colors.white,
    ),
    ),
    ),

  body: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [

  InkWell(
  onTap: () 
  {
    Navigator.of(context).push(
    MaterialPageRoute(builder: (context) =>  FirebasePostScreen(),
    ),);
  },
  child: Center(
  child: Container(
  height: 80,
  width: 200,
  decoration: BoxDecoration(
  color: Colors.cyan,
  borderRadius: BorderRadius.circular(30)
  ),
        
  child: const Center(
  child: Text(
  'Post on Firebase\nDatabase',
  textAlign: TextAlign.center,
  style: TextStyle(
  fontSize: 16,
  color: Colors.white,
  fontWeight: FontWeight.bold,
  ),),),), ),),


  const SizedBox(
  height: 40,
  ),
  

  InkWell(
  onTap: () 
  {
    Navigator.of(context).push(
    MaterialPageRoute(builder: (context) =>  FirestoreListScreen(),
    ),);
  },
  child: Center(
  child: Container(
  height: 80,
  width: 200,
  decoration: BoxDecoration(
  color: Colors.cyan,
  borderRadius: BorderRadius.circular(30)
  ),
        
  child: const Center(
  child: Text(
  'Post on Firebase\nFirestore Database',
  textAlign: TextAlign.center,
  style: TextStyle(
  fontSize: 16,
  color: Colors.white,
  fontWeight: FontWeight.bold,
  ),),),), ),),
  

    ],
    ),

  ),
  );
  }
}