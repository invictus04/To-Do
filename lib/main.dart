import 'package:database/data/local/db_helper.dart';
import 'package:database/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MyHomePage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DBProvider(dbHelper: DBHelper.getInstance),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(),
    );
  }
}
