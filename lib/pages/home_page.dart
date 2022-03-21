import 'package:doc_app/widgets/home_tabs.dart';
import 'package:doc_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: const <Widget>[
          TopBar(),
          HomeTabs(),
        ],
      ),
    );
  }
}