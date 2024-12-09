import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _docs = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    _usersCollection.snapshots().listen((snapshot) {
      setState(() {
        _docs =
            snapshot.docs as List<QueryDocumentSnapshot<Map<String, dynamic>>>;
      });
    });
  }

  Future<void> _addUser() async {
    final String name = _nameController.text;
    final String ageText = _ageController.text;
    final int age = int.tryParse(ageText) ?? 0;

    if (name.isNotEmpty) {
      await _usersCollection.add({
        'name': name,
        'age': age,
      });

      _nameController.clear();
      _ageController.clear();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users Data'),
        leading: IconButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Data entry fields
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addUser,
              child: const Text('Send'),
            ),
            const SizedBox(height: 16),
            // Show users
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text("Error loading users"));
                  }
                  final users = snapshot.data?.docs ?? [];
                  if (users.isEmpty) {
                    return const Center(child: Text("No users found"));
                  }
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      final userData = user.data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '{name: ${userData['name']}, sport: ${userData['sport']}, age: ${userData['age']}}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:user_data/extention/Example_a_stream.dart';
// import 'package:user_data/extention/context_extention.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int? randomStream;
//   int? randomFuture;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               FirebaseAuth.instance.signOut();
//             },
//             icon: Icon(Icons.arrow_back_ios)),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Stream<int> stream = creaeStream();
//                 stream.listen((value) {
//                   setState(() {
//                     randomStream = value;
//                   });
//                 });
//               },
//               icon: Icon(Icons.music_note)),
//           IconButton(
//             onPressed: () {
//               Future<int?> futureResult = creaeFuture();
//               futureResult.then((value) {
//                 setState(() {
//                   randomFuture = value;
//                 });
//               });
//             },
//             icon: Icon(Icons.list_alt),
//           )
//         ],
//       ),
//       body: Center(
//           child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//         Text(
//           randomStream.toString(),
//           style: context.displayLarge(),
//         ),
//         Text(
//           randomFuture.toString(),
//           style: context.displayLarge(),
//         ),
//       ])),
//     );
//   }
// }

// //FirebaseAuth.instance.currentUser?.email ?? "  " لعرض بيانات المستخدم الطريقة السهلة