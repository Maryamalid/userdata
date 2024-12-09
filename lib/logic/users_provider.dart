import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_data/repostories/user_repostories.dart';

class UsersProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  UserRepository userRepository = UserRepository();

  List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = [];

  UsersProvider() {
    getUsers();
  }

  // Fetch user data from Firestore
  void getUsers() {
    userRepository
        .getUsers()
        .listen((QuerySnapshot<Map<String, dynamic>> qSnapshot) {
      docs = qSnapshot.docs;
      notifyListeners();
    });
  }

  //add new User
  void addUser() {
    int? age = int.tryParse(ageController.text);
    userRepository.addUser(
      name: nameController.text,
      age: age ?? 0,
    );
    nameController.clear();
    ageController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }
}
