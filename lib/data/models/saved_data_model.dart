import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  final String website;
  final String username;
  final String password;
  final Timestamp timestamp;
  final String docID;

  Data.fromFirestore(DocumentSnapshot doc)
      : website = doc['website'],
        username = doc['username'],
        password = doc['password'],
        docID = doc.id,
        timestamp = doc['timestamp'];
}
