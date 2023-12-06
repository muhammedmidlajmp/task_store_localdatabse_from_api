import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tecnical_test/controller/model_hive/local_data.dart';
import 'package:tecnical_test/model/user_details/user_datas.dart';
import 'package:tecnical_test/view/home_screen/home_page.dart';

class GetUserInfermation extends ChangeNotifier {
 UserList? _userList;

  UserList? get userList => _userList;

  Future<void> fetchData() async {
    const String apiUrl =
        'https://reqres.in/api/users'; // Replace with your API endpoint

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _userList = UserList.fromJson(data);

        // Save user details to Hive
        for (final user in _userList!.data) {
          await Hive.box<HiveModel>('userBox').put(
            user.id,
            HiveModel(
              firstName: user.firstName,
              lastName: user.lastName,
              email: user.email,
              image: user.avatar,
            ),
          );
        }

        notifyListeners();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

   Future<void> editUser(int userId, HiveModel updatedUser) async {
  print('Editing user with ID: $userId');
  print('Updated user details: $updatedUser');
  await Hive.box<HiveModel>('userBox').put(userId, updatedUser);
  notifyListeners();
}

  Future<void> deleteUser(int userId) async {
    await Hive.box<HiveModel>('userBox').delete(userId);
    notifyListeners();
  }

  navigator(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3)).then((value) =>
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomePage())));
  }
}
