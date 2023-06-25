import 'package:chat_app_project/helper/helper_function.dart';
import 'package:chat_app_project/pages/auth/login_page.dart';
import 'package:chat_app_project/pages/profile_page.dart';
import 'package:chat_app_project/pages/search_page.dart';
import 'package:chat_app_project/service/auth_service.dart';
import 'package:chat_app_project/service/database_service.dart';
import 'package:chat_app_project/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userName = "";
  String? email = "";
  Stream? groups;
  String groupName = "";
  bool _isLoading = false;
  AuthService authService = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingUserData();
  }

  void gettingUserData() async {
    await HelperFunctions.getEmail().then((value) {
      email = value;
    });
    await HelperFunctions.getUserName().then((value) {
      userName = value;
    });
    setState(() {});
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((value) => groups = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: [
            Icon(
              Icons.account_circle,
              size: 150,
              color: Colors.grey[700],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              userName ?? "*UserName*",
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              title: const Text(
                'Groups',
                style: TextStyle(color: Colors.black),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              selectedColor: Theme.of(context).primaryColor,
              leading: const Icon(Icons.people_alt),
              onTap: () {},
              selected: true,
            ),
            ListTile(
              title: const Text(
                'Profile',
                style: TextStyle(color: Colors.black),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              selectedColor: Theme.of(context).primaryColor,
              leading: const Icon(Icons.person_2),
              onTap: () {
                nextScreenReplace(
                    context,
                    ProfilePage(
                      userName: userName!,
                      email: email!,
                    ));
              },
            ),
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.black),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              selectedColor: Theme.of(context).primaryColor,
              leading: const Icon(Icons.exit_to_app),
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: const Text('Are you sure you want to logout?'),
                      title: const Text("Logout"),
                      actions: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            )),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const LoginPage())),
                                  (route) => false);
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.green,
                            )),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              nextScreen(context, const SearchPage());
            },
            icon: const Icon(Icons.search),
          ),
        ],
        title: const Center(
          child: Text(
            'Groups',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
        onPressed: () {
          popUpDialog(context);
        },
      ),
      body: groupList(),
    );
  }

  groupList() {
    return StreamBuilder(
        stream: groups,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data["groups"] != null) {
              if (snapshot.data["groups"].length != 0) {
                return Text('Hellooooo');
              } else {
                return noGroupsFoundWigdet();
              }
            } else {
              return noGroupsFoundWigdet();
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            );
          }
        });
  }

  Widget noGroupsFoundWigdet() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.add_circle,
            color: Colors.grey,
            size: 75,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "You haven't joined any group, tap on the add icon to create a group or also search from top search button.",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  popUpDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Create a group',
            textAlign: TextAlign.left,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor),
                    )
                  : TextField(
                      onChanged: (value) {
                        groupName = value;
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor),
              child: const Text(
                'CANCEL',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor),
              onPressed: () {},
              child: const Text('CREATE'),
            ),
          ],
        );
      },
    );
  }
}
