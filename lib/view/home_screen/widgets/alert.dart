
  import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tecnical_test/controller/model_hive/local_data.dart';
import 'package:tecnical_test/controller/user_infermation.dart/get_userprovider.dart';

Widget editUser(BuildContext context, HiveModel user) {
    TextEditingController firstNameController =
        TextEditingController(text: user.firstName);
    TextEditingController lastNameController =
        TextEditingController(text: user.lastName);
    TextEditingController emailController =
        TextEditingController(text: user.email);
    TextEditingController imageController =
        TextEditingController(text: user.image);

    
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
      }
   
// class EditAlert extends StatelessWidget {
//   const EditAlert({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }