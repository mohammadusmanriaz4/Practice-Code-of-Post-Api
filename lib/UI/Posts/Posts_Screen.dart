import 'package:backend_app_01/UI/Auth/Login_Screen.dart';
import 'package:backend_app_01/UI/Posts/Add_Posts.dart';
import 'package:backend_app_01/UI/Upload_Image.dart';
import 'package:backend_app_01/Utils/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class FirebasePostScreen extends StatefulWidget {
  const FirebasePostScreen({super.key});

  @override
  State<FirebasePostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<FirebasePostScreen> {

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchFilter = TextEditingController();
  final editController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
    'Post Screen',
    style: TextStyle(
    color: Colors.white,
    ),
    ),

    actions: [
    IconButton(
    onPressed: ()
    {
      auth.signOut().then((value) {
      Navigator.push(
      context, 
      MaterialPageRoute(
      builder: (context) => LoginScreen(),
      ));

      }).onError((error, stackTrace) {
        Utils().toastMessage(error.toString());
      });
    }, 

    icon: const Icon(Icons.logout),
    ),

    const SizedBox(
    width: 10,
    ),
    ],
    ),


    floatingActionButton: FloatingActionButton(
    onPressed: (){
    Navigator.push(
    context, 
    //MaterialPageRoute(builder: (context) => const AddPostsScreen(),
    MaterialPageRoute(builder: (context) => const UploadImageScreen(),
    ),
    );
    },
    child: const Icon(Icons.post_add),
    ),

    

    body: Column(
    children: [

      const SizedBox(
      height: 10,
      ),

      //Search from List
      Padding(
      padding: const EdgeInsets.symmetric(
      horizontal: 10,
      ),
      child: TextFormField(
      controller: searchFilter,
      decoration: const InputDecoration(
      hintText: 'Search',
      border: OutlineInputBorder(),
      ),
      onChanged: (String value) {
      setState(() {
        
      });
      },
      ),
      ),

      //Fetching Data from Firebase using FirebaseAnimatedList.
      Expanded(
      child: FirebaseAnimatedList(
      query: ref, 
      itemBuilder: (context, snapshot, animation, index)
      {
        final title = snapshot.child('title').value.toString();
        if(searchFilter.text.isEmpty)
        {
          return ListTile(
        title: Text(
        snapshot.child('title').value.toString(),
         ),
        subtitle: Text(
        snapshot.child('id').value.toString(),
         ),
         trailing: PopupMenuButton(
          icon: const Icon(Icons.more_vert_rounded),
          itemBuilder: (context) => [
          PopupMenuItem(
          value: 1,
          child: ListTile(
          onTap: () {
            Navigator.pop(context);
            showMyDialogInFirebase(title, snapshot.child('id').value.toString(),);
          },
          leading: const Icon(Icons.edit),
          title: const Text('Edit'),
          ),
          ),

          PopupMenuItem(
          onTap: ()
          {
            Navigator.pop(context);
            ref.child(snapshot.child('id').value.toString(),).remove();
          },
          value: 1,
          child: const ListTile(
          leading: Icon(Icons.delete),
          title: Text('Delete'),
          ),
          ),
          ],
          ), 
         );
        }
        else if (title.toLowerCase().contains(searchFilter.text.toLowerCase().toLowerCase()))
        {
          return ListTile(
          title: Text(
          snapshot.child('title').value.toString(),
          ),
          subtitle: Text(
          snapshot.child('id').value.toString(),
          ),
          
          );
        }
        else
        {
          return Container();
        }

        
         },
         ),
         ),

      //Fetching Data from Firebase using Stream Builder.
      // Expanded(
      // child: StreamBuilder(
      // stream: ref.onValue,
      // builder: (context, AsyncSnapshot<DatabaseEvent> snapshot)
      // { 
      //   if(!snapshot.hasData)
      //   {
      //     return const CircularProgressIndicator();
      //   }
      //   else
      //   { 
      //     Map <dynamic , dynamic> map = snapshot.data!.snapshot.value as dynamic;
      //     List<dynamic> list = [];
      //     list.clear();
      //     list = map.values.toList();

      //     return ListView.builder(
      //     itemCount: snapshot.data!.snapshot.children.length,
      //     itemBuilder: (context , index)
      //     {
      //       return ListTile(
      //       title: Text(list[index]['title']),
      //       subtitle: Text(list[index]['id']),
      //       );
      //     }
      //     );
      //   }

        
      // }, 
      // )
      // ),
    ],
    ),

  ),
  );
  }

  Future<void> showMyDialogInFirebase (String title, String id) async
        { editController.text = title;
          return showDialog(
            context: context,
            builder: (BuildContext  context) 
            {
              return AlertDialog(
              title: const Text('Update'),
              content: Container(
              child: TextField(
              controller: editController,
              decoration: const InputDecoration(
              hintText: 'Edit',
              ),
              ),
              ),
              actions: [
              TextButton(
              onPressed: () {
              Navigator.pop(context);
              }, 
              child: const Text('Cancel'),
              ),

              TextButton(
              onPressed: () {
              Navigator.pop(context);
              ref.child(id).update({
                'title': editController.text.toLowerCase(),
              }).then((value) {
                Utils().toastMessage('Post Updated');
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString(),);
              });
              }, 
              child: const Text('Update'),
              ),
              ],
              );
            }
          );
        }
}