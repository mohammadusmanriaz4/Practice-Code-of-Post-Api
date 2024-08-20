import 'package:backend_app_01/Utils/Utils.dart';
import 'package:backend_app_01/Widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPostsScreen extends StatefulWidget {
  const AddPostsScreen({super.key});

  @override
  State<AddPostsScreen> createState() => _AddPostsScreenState();
}

class _AddPostsScreenState extends State<AddPostsScreen> {
  
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  bool loading = false;
  final postController = TextEditingController();

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
    'Add Post',
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
        controller: postController,
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

          String id = DateTime.now().millisecond.toString();
          
          databaseRef.child(id)
          .set({
              'title': postController.text.toString(),
              'id': id,
            }).then((value) => {
            setState(() {
              loading = false;
            }),
            Utils().toastMessage('Post Uploaded'),
            }).onError((error, stackTrace) => {
              setState(() {
              loading = false;
            }),
              Utils().toastMessage(error.toString()),
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

