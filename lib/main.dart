import 'package:flutter/material.dart';
import 'package:w24_app_dev_2_exam_2/task_1.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:w24_app_dev_2_exam_2/task_2.dart';

import 'firebase_options.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /*
  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('Initialized default app $app');
  }
  */

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'App Dev 2 Exam 2',
      home: MenuScreen(),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Task1Main()));
                },
                child: const Text('Task 1')),
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Task2Main()));
                },
                child: const Text('Task 2'))
          ],
        ),
      ),
    );
  }
}
