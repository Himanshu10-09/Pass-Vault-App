import 'package:flutter/material.dart';
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
              style: TextStyle(color: Colors.white, fontSize: 26),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                ))
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) => HomePageTile(
          name: mockData[index],
        ),
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
