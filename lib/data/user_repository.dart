import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getUser(String userId) async {
    final doc = await _firestore
        .collection('users')
        .doc(userId)
        .get();

    if (!doc.exists) {
      return null;
    }

    return doc.data();
  }
}