import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_data/extention/context_extention.dart';
import 'package:user_data/logic/users_provider.dart';
import 'package:user_data/screens/home_screen.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UsersProvider(),
      child: Scaffold(
        body: Consumer<UsersProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Name',
                  ),
                  controller: provider.nameController,
                ), // TextField
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Age',
                  ),
                  controller: provider.ageController,
                ), // TextField
                TextButton(
                  onPressed: () {
                    provider.addUser();
                  },
                  child: const Text(
                    'send',
                  ), // Text
                ),

                Expanded(
                  child: ListView.separated(
                    itemCount: provider.docs.length,
                    padding: const EdgeInsets.only(top: 40),
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Text(
                        provider.docs[index].data().toString(),
                        style: context.displayLarge()?.copyWith(fontSize: 25),
                      );
                    },
                  ), // ListView.separated
                ), // Expanded
              ], // children
            ); // Column
          }, // builder
        ), // Consumer
      ), // Scaffold
    ); // ChangeNotifierProvider
  } // build
}
