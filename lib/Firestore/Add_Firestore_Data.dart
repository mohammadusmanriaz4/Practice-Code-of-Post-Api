import 'package:backend_app_01/Utils/Utils.dart';
import 'package:backend_app_01/Widgets/round_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class AddFirestoreDataScreen extends StatefulWidget {
  const AddFirestoreDataScreen({super.key});

  @override
  State<AddFirestoreDataScreen> createState() => _AddFirestoreDataScreenState();
}

class _AddFirestoreDataScreenState extends State<AddFirestoreDataScreen> {
  final fireStore = FirebaseFirestore.instance.collection('users');
  bool loading = false;
  final firestorePostController = TextEditingController();

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
    'Post on Firestore',
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
      children: [
      
        const SizedBox(
        height: 30,
        ),
       
        TextFormField(
        controller: firestorePostController,
        maxLines: 4,
        decoration: const InputDecoration(
        hintText: 'Whats in your mind?',
        border: OutlineInputBorder(),
        ),
        ),

        const SizedBox(
        height: 30,
        ),

        RoundButton(
        title: 'Add',
        loading: loading, 
        ontap: () 
        {
          setState(() {
          loading = true;
          });    


          String id = DateTime.now().microsecondsSinceEpoch.toString();

          fireStore.doc(id).set({
            'title': firestorePostController.text.toString(),
            'id': id,

          }).then((value) {
            setState(
              () {
                    loading = false;
              });

              Utils().toastMessage('Post Added to Firestore Successfully');

          }).onError((error, stackTrace) {
            setState(
              () {
                    loading = false;
              });

              Utils().toastMessage(error.toString());
          });      
            
            
        }
        ),

        
      
      ],
      ),
    ),

  ),
  );
  }

  
}






