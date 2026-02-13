import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saigeware_task/data/task_model.dart';
import 'package:saigeware_task/presentation/home_page.dart';
import 'package:saigeware_task/presentation/task_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  final box = await Hive.openBox<TaskModel>('tasks');
  runApp(
    ChangeNotifierProvider(
      create: (_) => TaskProvider(box),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saigeware Task',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.blueGrey)),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
