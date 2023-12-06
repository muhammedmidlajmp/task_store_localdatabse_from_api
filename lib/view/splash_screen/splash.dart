import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tecnical_test/controller/user_infermation.dart/get_userprovider.dart';

class Splashpage extends StatelessWidget {
  const Splashpage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<GetUserInfermation>(context,listen: false).navigator(context);
        Provider.of<GetUserInfermation>(context,listen: false).fetchData();

    return Scaffold(body: 
    Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.blueGrey,
    )
    ,);
  }
}