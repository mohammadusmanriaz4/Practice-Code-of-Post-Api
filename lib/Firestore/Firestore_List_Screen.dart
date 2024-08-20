import 'package:backend_app_01/Firestore/Add_Firestore_Data.dart';
import 'package:backend_app_01/UI/Auth/Login_Screen.dart';
import 'package:backend_app_01/Utils/Utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';






class FirestoreListScreen extends StatefulWidget {
  const FirestoreListScreen({super.key});

  @override
  State<FirestoreListScreen> createState() => _FirestoreListScreenState();
}

class _FirestoreListScreenState extends State<FirestoreListScreen> {
  final auth = FirebaseAuth.instance;
  final editController = TextEditingController();
  final searchController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  

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
    iconTheme: const IconThemeData(
    color: Colors.white,
    ),
    backgroundColor: Colors.deepPurple,
    title: const Text(
    'Firestore Post Screeen',
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
    MaterialPageRoute(builder: (context) => const AddFirestoreDataScreen()
    ),
    );
    },
    child: const Icon(Icons.add),
    ),

    body: Column(
    children: [

      const SizedBox(
      height: 10,
      ),

      Padding(
      padding: const EdgeInsets.symmetric(
      horizontal: 10,
      ),
      child: TextFormField(
      controller: searchController,
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


      //Fetching Data from Firestore using Stream Builder.
      StreamBuilder<QuerySnapshot>(
      stream: fireStore, 
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) 
      {

        if (snapshot.connectionState == ConnectionState.waiting) 
        return Center(child: CircularProgressIndicator());
        
        if (snapshot.hasError)
        return Text('Something went wrong.');
  
        return Expanded(
        child: ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index)
        {
          final title = snapshot.data!.docs[index]['title'].toString();
          //Code with Search
          if(searchController.text.isEmpty)
          {
          return ListTile(
          title: Text(
          snapshot.data!.docs[index]['title'].toString()
          ),
          subtitle: Text(
          snapshot.data!.docs[index].id,
          ),
          trailing: PopupMenuButton(
          icon: const Icon(Icons.more_vert_rounded),
          itemBuilder: (context) => [
          PopupMenuItem(
          value: 1,
          child: ListTile(
          onTap: () {
            final title = snapshot.data!.docs[index]['title'].toString();
            Navigator.pop(context);
            showMyDialogInFirestore(title, snapshot.data!.docs[index].id,);
          },
          leading: const Icon(Icons.edit),
          title: const Text('Edit'),
          ),
          ),

          PopupMenuItem(
          onTap: ()
          {
            ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
          },
          value: 1,
          child: const ListTile(
          leading: Icon(Icons.delete),
          title: Text('Delete'),
          ),
          ),
          ]
          ),
          );
          }
          else if (title.toLowerCase().contains(searchController.text.toLowerCase().toLowerCase()))
          {
            return ListTile(
            title: Text(
            snapshot.data!.docs[index]['title'].toString()
          ),
            subtitle: Text(
            snapshot.data!.docs[index].id,
          ),
          );
          }
          else
        {
          return Container();
        }

         },
        ),
        );
       
        }
        ),

         ]
         ),
         ),
         );
  }

  Future<void> showMyDialogInFirestore (String title, String id) async
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
                ref.doc(id).update({
                'title': editController.text.toLowerCase(),
              }).then((value) {
                Utils().toastMessage('Post Updated on Firestore.');
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

//***************************************************************************************************/
//           Code without search
//           return ListTile(
//           title: Text(
//           snapshot.data!.docs[index]['title'].toString()
//           ),
//           subtitle: Text(
//           snapshot.data!.docs[index].id,
//           ),
//           trailing: PopupMenuButton(
//           icon: const Icon(Icons.more_vert_rounded),
//           itemBuilder: (context) => [
//           PopupMenuItem(
//           value: 1,
//           child: ListTile(
//           onTap: () {
//             final title = snapshot.data!.docs[index]['title'].toString();
//             Navigator.pop(context);
//             showMyDialogInFirestore(title, snapshot.data!.docs[index].id,);
//           },
//           leading: const Icon(Icons.edit),
//           title: const Text('Edit'),
//           ),
//           ),

//           PopupMenuItem(
//           onTap: ()
//           {
//             ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
//           },
//           value: 1,
//           child: const ListTile(
//           leading: Icon(Icons.delete),
//           title: Text('Delete'),
//           ),
//           ),
//           ],
//           ),
//           );













//**************************************************************************************** */
//Fetching Data from Firestore using List View Builder.
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