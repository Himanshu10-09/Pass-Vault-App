// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:password_vault_app/data/FirebaseService/firestore_service.dart';
import 'package:password_vault_app/presentation/home_page/home_page.dart';

class UpdatePasswordPage extends StatefulWidget {
  final String username;
  final String website;
  final String password;
  final Timestamp timestamp;
  final String docID;
  const UpdatePasswordPage(
      {super.key,
      required this.username,
      required this.website,
      required this.password,
      required this.timestamp,
      required this.docID});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _websiteController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            const Text(
              "Update Data",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '*Enter new value in the fields you want to update',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "Website:",
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: _websiteController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: widget.website,
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.black,
                        width: 2),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Username:",
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: _usernameController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: widget.username,
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.black,
                        width: 2),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Password:",
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: _passwordController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: widget.password,
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.black,
                        width: 2),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  'Last updated on: ${widget.timestamp.toDate()}',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_websiteController.text.isEmpty &&
                        _usernameController.text.isEmpty &&
                        _passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Row(
                            children: const [
                              Icon(
                                Icons.error_outline,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Modify at least one field to update',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              )
                            ],
                          )));
                    }

                    if (_websiteController.text.isNotEmpty &&
                        _passwordController.text.isEmpty &&
                        _usernameController.text.isEmpty) {
                      try {
                        FirestoreService().updateData(
                            widget.docID,
                            widget.username,
                            _websiteController.text.trim(),
                            widget.password);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.done,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Updated Successfully',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )
                              ],
                            )));
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (route) => false,
                        );
                      } on FirebaseException {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Something went wrong',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )
                              ],
                            )));
                      }
                    }
                    if (_websiteController.text.isEmpty &&
                        _passwordController.text.isNotEmpty &&
                        _usernameController.text.isEmpty) {
                      try {
                        FirestoreService().updateData(
                            widget.docID,
                            widget.username,
                            widget.website,
                            _passwordController.text.trim());
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.done,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Updated Successfully',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )
                              ],
                            )));
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (route) => false,
                        );
                      } on FirebaseException {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Something went wrong',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )
                              ],
                            )));
                      }
                    }
                    if (_websiteController.text.isEmpty &&
                        _passwordController.text.isEmpty &&
                        _usernameController.text.isNotEmpty) {
                      try {
                        FirestoreService().updateData(
                            widget.docID,
                            _usernameController.text.trim(),
                            widget.website,
                            widget.password);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.done,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Updated Successfully',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )
                              ],
                            )));
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (route) => false,
                        );
                      } on FirebaseException {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Something went wrong',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )
                              ],
                            )));
                      }
                    }

                    if (_websiteController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty &&
                        _usernameController.text.isEmpty) {
                      try {
                        FirestoreService().updateData(
                            widget.docID,
                            widget.username,
                            _websiteController.text.trim(),
                            _passwordController.text.trim());
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.done,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Updated Successfully',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )
                              ],
                            )));
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (route) => false,
                        );
                      } on FirebaseException {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Something went wrong',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )
                              ],
                            )));
                      }
                    }
                    if (_websiteController.text.isNotEmpty &&
                        _passwordController.text.isEmpty &&
                        _usernameController.text.isNotEmpty) {
                      try {
                        FirestoreService().updateData(
                            widget.docID,
                            _usernameController.text.trim(),
                            _websiteController.text.trim(),
                            widget.password);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.done,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Updated Successfully',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )
                              ],
                            )));
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (route) => false,
                        );
                      } on FirebaseException {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Something went wrong',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )
                              ],
                            )));
                      }
                    }
                    if (_websiteController.text.isEmpty &&
                        _passwordController.text.isNotEmpty &&
                        _usernameController.text.isNotEmpty) {
                      try {
                        FirestoreService().updateData(
                            widget.docID,
                            _usernameController.text.trim(),
                            widget.website,
                            _passwordController.text.trim());
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.done,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Updated Successfully',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )
                              ],
                            )));
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (route) => false,
                        );
                      } on FirebaseException {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Something went wrong',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )
                              ],
                            )));
                      }
                    }

                    if (_websiteController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty &&
                        _usernameController.text.isNotEmpty) {
                      try {
                        FirestoreService().updateData(
                            widget.docID,
                            _usernameController.text.trim(),
                            _websiteController.text.trim(),
                            _passwordController.text.trim());
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.done,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Updated Successfully',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )
                              ],
                            )));
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (route) => false,
                        );
                      } on FirebaseException {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Something went wrong',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )
                              ],
                            )));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      fixedSize: Size(MediaQuery.of(context).size.width, 50)),
                  child: Text(
                    'Update',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
