import 'package:cloud_firestore/cloud_firestore.dart' as fbStore;
import 'package:rewear/config/app_init.dart';
import 'package:rewear/models/firestore.model.dart';
import 'package:rewear/models/request.model.dart';

class FirestoreServices {
  static final FirestoreServices _singleton = FirestoreServices._internal();
  factory FirestoreServices() {
    return _singleton;
  }
  FirestoreServices._internal();

  static const String USERS_COLLECTION = 'users';
  static const String REQUESTS_COLLECTION = 'requests';

  /* -------------------------------- Users Services -------------------------------- */

  Future<FirestoreData> getUser(String uid) async {
    final doc = await fbStore.FirebaseFirestore.instance
        .collection(FirestoreServices.USERS_COLLECTION)
        .where('uid', isEqualTo: uid)
        .get();

    return FirestoreData(data: doc.docs.first.data(), docId: doc.docs.first.id);
  }

  Future<void> updateUserWithDocId(
      String docId, Map<String, dynamic> data) async {
    await fbStore.FirebaseFirestore.instance
        .collection(FirestoreServices.USERS_COLLECTION)
        .doc(docId)
        .update(data);
  }

  Future<String> addUser(Map<String, dynamic> data) async {
    final res = await fbStore.FirebaseFirestore.instance
        .collection(FirestoreServices.USERS_COLLECTION)
        .add(data);
    return res.id;
  }

  /* -------------------------------- Requests Services -------------------------------- */

  Future<String> addRequests(Map<String, dynamic> data) async {
    final res = await fbStore.FirebaseFirestore.instance
        .collection(FirestoreServices.REQUESTS_COLLECTION)
        .add(data);
    return res.id;
  }

  void getRequests() async {
    fbStore.FirebaseFirestore.instance
        .collection(REQUESTS_COLLECTION)
        .where('sellerId', isEqualTo: AppInit().user.uid)
        .snapshots()
        .listen((snapshot) {
      AppInit().requests.clear();
      for (final doc in snapshot.docs) {
        final Map<String, dynamic> updatedData = {'docId': doc.id}
          ..addAll(doc.data());
        AppInit().requests.add(Request.fromJson(updatedData));
      }
    });
  }
}
