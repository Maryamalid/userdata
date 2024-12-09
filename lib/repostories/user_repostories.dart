import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  // add user to firebase
  Future<void> addUser({required String name, required int age}) async {
    DocumentReference documentReference =
        await FirebaseFirestore.instance.collection("users").add({
      "name": name,
      "age": age,
    });
    print("documentReference ${documentReference.toString()}");
  }

  // get users from firebase
  Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    return FirebaseFirestore.instance.collection("users").snapshots();
  }
}
