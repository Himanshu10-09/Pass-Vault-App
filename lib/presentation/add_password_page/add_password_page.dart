import 'package:flutter/material.dart';
import 'package:password_vault_app/data/FirebaseService/firestore_service.dart';
import 'package:password_vault_app/presentation/home_page/home_page.dart';

class AddPasswordPage extends StatefulWidget {
  const AddPasswordPage({super.key});

  @override
  State<AddPasswordPage> createState() => _AddPasswordPageState();
}

class _AddPasswordPageState extends State<AddPasswordPage> {
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _websiteController.dispose();
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
              "Add New Password",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "*Please enter all the fields to save the password",
                style: TextStyle(color: Colors.grey[500]),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _websiteController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  label: const Text(
                    "Website",
                    style: TextStyle(color: Colors.black),
                  ),
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
              TextFormField(
                controller: _usernameController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  label: const Text(
                    "Username",
                    style: TextStyle(color: Colors.black),
                  ),
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
              TextFormField(
                controller: _passwordController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  label: const Text(
                    "Password",
                    style: TextStyle(color: Colors.black),
                  ),
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
              TextFormField(
                controller: _confirmPasswordController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  label: const Text(
                    "Confirm Password",
                    style: TextStyle(color: Colors.black),
                  ),
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
              ElevatedButton(
                  onPressed: () {
                    if (_websiteController.text.trim().isEmpty ||
                        _usernameController.text.isEmpty ||
                        _passwordController.text.isEmpty ||
                        _confirmPasswordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          elevation: 6,
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
                                "Please fill all the fields to save data",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          )));
                    }
                    if (_passwordController.text.trim() !=
                            _confirmPasswordController.text.trim() &&
                        _passwordController.text.isNotEmpty &&
                        _confirmPasswordController.text.isNotEmpty) {
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
                                "Passwords don't match",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          )));
                    }
                    if (_passwordController.text.trim() ==
                            _confirmPasswordController.text.trim() &&
                        _websiteController.text.isNotEmpty &&
                        _usernameController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty &&
                        _confirmPasswordController.text.isNotEmpty) {
                      try {
                        FirestoreService().addData(
                            _usernameController.text.trim(),
                            _passwordController.text.trim(),
                            _websiteController.text.trim());
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                backgroundColor: Colors.green,
                                content: Row(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Data saved successfully",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                )));
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (route) => false,
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                backgroundColor: Colors.black87,
                                content: Row(
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Some error occured while saving",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    ),
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
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
