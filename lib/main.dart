import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tecnical_test/controller/model_hive/local_data.dart';
import 'package:tecnical_test/controller/user_infermation.dart/get_userprovider.dart';
import 'package:tecnical_test/view/splash_screen/splash.dart';

void main() async {
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(HiveModelAdapter().typeId)) {
    Hive.registerAdapter(HiveModelAdapter());
  }
  await Hive.openBox<HiveModel>('userBox');
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GetUserInfermation())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          
          useMaterial3: true,
        ),
        home: const Splashpage(),
      ),
    );
  }
}
