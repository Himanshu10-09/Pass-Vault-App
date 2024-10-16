// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:password_vault_app/presentation/home_page/home_page.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Website:",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "admin.com",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Username:",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "test@admin.com",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Password:",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "12345678",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {},
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
    );
  }
}
