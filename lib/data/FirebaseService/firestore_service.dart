import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:password_vault_app/data/models/saved_data_model.dart';

class FirestoreService {
  Future login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException {
      print("Something went wrong!");
    }
  }

  Future logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Stream<List<Data?>> fetchDataStream() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final Stream<QuerySnapshot<Map<String, dynamic>>> snapshotStream = firestore
        .collection('users')
        .doc("test@admin.com")
        .collection("passwordDB")
        .snapshots();

    return snapshotStream.map((querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        return const [];
      }

      final List<Data?> dataList = querySnapshot.docs.map((doc) {
        if (!doc.data().containsKey('website') ||
            !doc.data().containsKey('username') ||
            !doc.data().containsKey('password') ||
            !doc.data().containsKey('timestamp')) {
          print('Warning: Document ${doc.id} is missing required fields.');
          return null;
        }
        return Data.fromFirestore(doc);
      }).toList();

      return dataList.where((data) => data != null).toList();
    });
  }

  Future addData(String username, String password, String website) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc("test@admin.com")
        .collection('passwordDB')
        .add({
      'website': website,
      'username': username,
      'password': password,
      'timestamp': DateTime.now(),
    });
  }

  Future removeData(String docID) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc('test@admin.com')
        .collection('passwordDB')
        .doc(docID)
        .delete();
  }
}
