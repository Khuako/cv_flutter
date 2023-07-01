import 'package:chat_app_project/pages/home_page.dart';
import 'package:chat_app_project/service/auth_service.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import 'auth/login_page.dart';

class ProfilePage extends StatefulWidget {
  String userName;
  String email;
  ProfilePage({required this.userName, required this.email});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
        ),
      ),
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
              widget.userName,
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
              onTap: () {
                nextScreen(context, const HomePage());
              },
              selected: false,
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
              onTap: () {},
              selected: true,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
          ),
          Icon(
            Icons.account_circle,
            size: 200,
            color: Colors.grey[700],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Full Name',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  widget.userName,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Email',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  widget.email,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
