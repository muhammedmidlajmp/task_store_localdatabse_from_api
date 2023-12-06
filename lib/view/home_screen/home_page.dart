import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tecnical_test/controller/model_hive/local_data.dart';
import 'package:tecnical_test/controller/user_infermation.dart/get_userprovider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GetUserInfermation>(
      builder: (context, value, _) {
        final userBox = Hive.box<HiveModel>('userBox');
        final userList = userBox.values.toList();

        return FutureBuilder(
          future: Hive.openBox<HiveModel>('userBox'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final userBox = Hive.box<HiveModel>('userBox');
              return DefaultTabController(
                length: userList.length,
                child: Scaffold(
                  appBar: AppBar(
                    actions: [
                      IconButton(
                        onPressed: () {
                          // Handle refresh logic here
                          // For example: Provider.of<GetUserInfermation>(context, listen: false).fetchData();
                        },
                        icon: const Icon(Icons.refresh),
                      )
                    ],
                    title: const Center(child: Text('HomePage')),
                    bottom: TabBar(
                      tabs: userList
                          .map((user) => Tab(text: user.firstName))
                          .toList(),
                    ),
                  ),
                  body: TabBarView(
                    children: userList.asMap().entries.map((entry) {
                      final user = entry.value;
                      final index = entry.key;
                      return Column(
                        children: [
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  final HiveModel user = userBox.getAt(index)!;
                                  _editUser(context, user);
                                },
                                child: const Text('Edit'),
                              ),
                              TextButton(
                                onPressed: () {
                                  final HiveModel user = userBox.getAt(index)!;
                                  _deleteUser(context, user);
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  NetworkImage(user.image.toString()),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text('Firstname : ${user.firstName}'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text('Lastname : ${user.lastName}'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text('Email : ${user.email}'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }

  void _editUser(BuildContext context, HiveModel user) {
    TextEditingController firstNameController =
        TextEditingController(text: user.firstName);
    TextEditingController lastNameController =
        TextEditingController(text: user.lastName);
    TextEditingController emailController =
        TextEditingController(text: user.email);
    TextEditingController imageController =
        TextEditingController(text: user.image);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit User'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                ),
                TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: imageController,
                  decoration: InputDecoration(labelText: 'Image URL'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final updatedUser = HiveModel(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  email: emailController.text,
                  image: imageController.text,
                );

                // Update the user in Hive
                // Replace 'yourHiveBox' with your actual Hive box name
                Provider.of<GetUserInfermation>(context, listen: false)
                    .editUser(user.key!, updatedUser);

                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteUser(BuildContext context, HiveModel user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete User'),
          content: Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Delete the user from Hive
                // Replace 'yourHiveBox' with your actual Hive box name
                Provider.of<GetUserInfermation>(context, listen: false)
                    .deleteUser(user.key!);

                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
