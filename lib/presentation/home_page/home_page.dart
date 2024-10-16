import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_vault_app/data/FirebaseService/firestore_service.dart';
import 'package:password_vault_app/data/models/saved_data_model.dart';
import 'package:password_vault_app/presentation/add_password_page/add_password_page.dart';
import 'package:password_vault_app/presentation/home_page/home_page_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> mockData = [
    "test@admin.com",
    "Netflix",
    "Amazon Prime",
    "Disney+ Hotstar"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            const Icon(
              Icons.lock,
              color: Colors.white,
              size: 26,
            ),
            const SizedBox(
              width: 7,
            ),
            const Text(
              "PASSVAULT",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  try {
                    FirestoreService().logOut();
                  } on FirebaseAuthException {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.red,
                        content: Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Something went wrong',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )
                          ],
                        )));
                  }
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  size: 28,
                  color: Colors.white,
                ))
          ],
        ),
      ),
      body: StreamBuilder<List<Data?>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc("test@admin.com")
            .collection('passwordDB')
            .snapshots()
            .map((querySnapshot) {
          return querySnapshot.docs
              .map((doc) => Data.fromFirestore(doc))
              .toList();
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            ));
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error fetching user data: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final List<Data?> resData = snapshot.data!;
            return ListView.builder(
              itemCount: resData.length,
              itemBuilder: (context, index) {
                final data = resData[index];
                return HomePageTile(
                  username: data!.username,
                  website: data.website,
                  password: data.password,
                  timestamp: data.timestamp,
                  docID: data.docID,
                );
              },
            );
          } else {
            return const Center(
                child: Text(
              "No data found ",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AddPasswordPage(),
              ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
