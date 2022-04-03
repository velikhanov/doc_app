// import 'package:doc_app/auth/auth_service.dart';
import 'package:doc_app/pages/chats_page.dart';
import 'package:doc_app/widgets/home_tabs.dart';
import 'package:doc_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

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
      // floatingActionButton: FloatingActionButton(
      //   child: const Text('Action'),
      //   onPressed: () {
      //     context.read<AuthenticationService>().signOut();
      //     ChatsPage
      //   },
      // ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Text('Action'),
      //   onPressed: (() => Navigator.push(
      //         context,
      //         // MaterialPageRoute(builder: (context) => const ChatPage(),
      //         MaterialPageRoute(builder: (context) => const ChatsPage(),
      //     ))),
      // ),
    );
  }
}
