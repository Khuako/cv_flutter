import 'package:chat_app_project/helper/helper_function.dart';
import 'package:chat_app_project/pages/chat_page.dart';
import 'package:chat_app_project/service/database_service.dart';
import 'package:chat_app_project/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  bool _isLoading = false;
  bool hasUserSearched = false;
  bool isJoined = false;
  QuerySnapshot? group;
  String userName = "";
  User? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUserIDandName();
  }

  getCurrentUserIDandName() async {
    await HelperFunctions.getUserName().then((value) {
      setState(() {
        userName = value!;
      });
    });
    user = FirebaseAuth.instance.currentUser;
  }

  Future searchButton() async {
    if (searchController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      await DatabaseService().searchByName(searchController.text).then((value) {
        setState(() {
          group = value;
          _isLoading = false;
          hasUserSearched = true;
        });
      });
    }
  }

  void isJoinedOrNot(
      String userName, String groupId, String groupName, String admin) async {
    await DatabaseService(uid: user!.uid)
        .usUserJoined(groupName, groupId, userName)
        .then((value) {
      isJoined = value;
      setState(() {});
    });
  }

  groupList() {
    return hasUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: group!.docs.length,
            itemBuilder: (context, index) {
              return groupTile(
                userName,
                group!.docs[index]['groupId'],
                group!.docs[index]['groupName'],
                group!.docs[index]['admin'],
              );
            },
          )
        : Container();
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  Widget groupTile(
      String userName, String groupId, String groupName, String admin) {
    isJoinedOrNot(userName, groupId, groupName, admin);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        radius: 30,
        child: Text(
          groupName.substring(0, 1).toUpperCase(),
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      title: Text(
        groupName,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text("Admin: ${getName(admin)}"),
      trailing: InkWell(
        onTap: () async {
          await DatabaseService(uid: user!.uid)
              .toggleJoin(groupId, userName, groupName);
          if (isJoined) {
            setState(() {
              isJoined = !isJoined;
            });
            showSnackBar(context, Colors.green, 'Succesfully joined the group');
            Future.delayed(const Duration(seconds: 2), () {
              nextScreen(
                  context,
                  ChatPage(
                      groupId: groupId,
                      groupName: groupName,
                      userName: userName));
            });
          } else {
            setState(() {
              isJoined = !isJoined;
              showSnackBar(context, Colors.red, 'Left the group $groupName');
            });
          }
        },
        child: isJoined
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                  border: Border.all(color: Colors.white, width: 1),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text(
                  'Joined',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                  border: Border.all(color: Colors.white, width: 1),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text(
                  'Join',
                  style: TextStyle(color: Colors.white),
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Search',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextField(
              controller: searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search groups...",
                hintStyle: const TextStyle(color: Colors.white, fontSize: 16),
                border: InputBorder.none,
                suffixIcon: GestureDetector(
                  onTap: () {
                    searchButton();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor),
                )
              : groupList(),
        ],
      ),
    );
  }
}
