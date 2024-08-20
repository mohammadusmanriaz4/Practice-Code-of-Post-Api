import 'dart:io';
import 'package:backend_app_01/Utils/Utils.dart';
import 'package:backend_app_01/Widgets/round_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> 
{
  
  File? _image;
  bool loading = false;
  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('UploadedImages');

  Future getImageGallery() async
  {
    final pickedFile = await picker.pickImage(
    source: ImageSource.gallery, 
    imageQuality: 80,
    );

    setState(() 
    {
      if(pickedFile != null)
    {
      _image = File(pickedFile.path);
    }
    else
    {
      print('Select Image First');
    }
    });

    
  } 



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
    'Upload Image',
    style: TextStyle(
    color: Colors.white,
    ),
    ),
  ),

  body: Padding(
  padding: const EdgeInsets.symmetric(
  horizontal: 20
  ),
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    
    
  Center(
  child: InkWell(
  onTap: ()
  {
    getImageGallery();
  },
  child: Container(
  height: 200,
  width: 200,
  decoration: BoxDecoration(
  border: Border.all(
  color: Colors.black,
  ),
  ),
  child: _image != null ? Image.file(_image!.absolute) : const Center(
  child: Icon(
  Icons.image,
  ),
  ),
  ),
  ),
  ),
    
  const SizedBox(
  height: 30,
  ),
    
  RoundButton(
  title: 'Upload', 
  ontap: () async
  {
    setState(() {
      loading = true;
    });

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/Uploaded/'+DateTime.now().millisecondsSinceEpoch.toString(), );
    firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);

    Future.value(uploadTask).then((value) async
    {

    var newUrl = await ref.getDownloadURL();

    databaseRef.child('1').set({
      'id': '12907856',
      'title': newUrl.toString(),
    }).then((value) {
      setState(() {
      loading = false;
      });
      Utils().toastMessage('Image Uploaded Successfully');
    }).onError((error, stackTrace) {
      
      setState(() {
      loading = false;
      });

    Utils().toastMessage(error.toString());
    });

    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
      loading = false;
      });
    });

    


  },
  ),
    
    
    
    
    ],
    ),
  ),

  ),);
  }
}