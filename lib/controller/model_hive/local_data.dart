import 'package:hive/hive.dart';
part 'local_data.g.dart';

@HiveType(typeId: 0)
class HiveModel extends HiveObject {
  @HiveField(0)
  String? firstName;

  @HiveField(1)
  String? lastName;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? image;

  HiveModel({this.firstName, this.lastName, this.email, this.image});
}