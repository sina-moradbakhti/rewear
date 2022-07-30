import 'package:cloud_firestore/cloud_firestore.dart' as fbStore;
import 'package:rewear/models/firestore.model.dart';

class FirestoreServices {
  static final FirestoreServices _singleton = FirestoreServices._internal();
  factory FirestoreServices() {
    return _singleton;
  }
  FirestoreServices._internal();

  Future<FirestoreData> getUser(String uid) async {
    final doc = await fbStore.FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();

    return FirestoreData(data: doc.docs.first.data(), docId: doc.docs.first.id);
  }

  Future<void> updateUserWithDocId(
      String docId, Map<String, dynamic> data) async {
    await fbStore.FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .update(data);
  }

  Future<String> addUser(Map<String, dynamic> data) async {
    final res =
        await fbStore.FirebaseFirestore.instance.collection('users').add(data);
    return res.id;
  }
}
