import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_firebaseapp/database/databaseManage.dart';
import 'package:login_firebaseapp/services/authenticatio.dart';
// import 'dart:html';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final AuthenticationService _auth = AuthenticationService();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _scoreController = TextEditingController();

  List userProfileList = [];
  String userId = "";

  @override
  void initState() {
    super.initState();
    fetchUserId();
    fetchDatabaseList();
  }

  fetchUserId() async {
    final User? getUserId = FirebaseAuth.instance.currentUser;
    userId = getUserId!.uid;
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getUserData();
    if (resultant == null)
      print("cannot fetch data");
    else {
      setState(() {
        userProfileList = resultant;
      });
    }
  }

  updateData(String name, String gender, int score, String uid) async {
    await DatabaseManager().updateData(name, gender, score, uid);
    fetchDatabaseList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.deepPurple)),
            onPressed: () {
              openDilougeBox(context);
            },
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.deepPurple)),
            onPressed: () async {
              await _auth.signOut().then((result) {
                Navigator.of(context).pop(true);
              });
            },
            child: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
          child: ListView.builder(
              itemCount: userProfileList.length,
              itemBuilder: (context, index) {
                // ignore: prefer_const_constructors
                return Card(
                  child: ListTile(
                    title: Text(userProfileList[index]['name']), //
                    subtitle: Text(userProfileList[index]['gender']), //
                    leading: CircleAvatar(),
                    trailing: Text('${userProfileList[index]['score']}'), //
                  ),
                );
              })),
    );
  }

  openDilougeBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit Details'),
            content: Container(
              height: 160,
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(hintText: 'Name'),
                  ),
                  TextField(
                    controller: _genderController,
                    decoration: InputDecoration(hintText: 'Gender'),
                  ),
                  TextField(
                    controller: _scoreController,
                    decoration: InputDecoration(hintText: 'Score'),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    submit(context);
                    Navigator.of(context).pop(context);
                    print(userId);
                  },
                  child: Text('Submit')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(context);
                  },
                  child: Text('Cancel'))
            ],
          );
        });
  }

  submit(BuildContext context) {
    updateData(_nameController.text, _genderController.text,
        int.parse(_scoreController.text), userId);
    _genderController.clear();
    _nameController.clear();
    _scoreController.clear();
  }
}
