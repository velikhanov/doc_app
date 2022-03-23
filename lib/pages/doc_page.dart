import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_app/api/get_data.dart';
import 'package:doc_app/pages/chat_page.dart';
import 'package:doc_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class DocPage extends StatelessWidget {

  final String _collection;
  final int _id;

  const DocPage(this._collection, this._id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _query = getDoctorData(_collection, _id);
    return DefaultTextStyle(
      style: const TextStyle(
        decoration: TextDecoration.none,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(15.0),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 33, 124, 243),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Material(
                    color: const Color.fromARGB(255, 33, 124, 243),
                    child: IconButton(
                      onPressed: (() => Navigator.pop(context)),
                      icon: const Icon(Icons.arrow_back_sharp, color: Colors.white,),
                    ),
                  ),
                  Material(
                    color: const Color.fromARGB(255, 33, 124, 243),
                    child: IconButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage(),
                      )),
                      icon: const Icon(Icons.home, color: Colors.white,),
                    ),
                  ),
                ],
              ),
              FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: _query,
                  builder: (_, snapshot) {
                    if (snapshot.hasError) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                "Ошибка загрузки данных.\nПожалуйста, повторите попытку позже: ${snapshot.error.toString()}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Flexible(
                              child: Text(
                                "Загрузка данных, пожалуйста, подождите..",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    if (snapshot.hasData) {
                      var _data = snapshot.data!.data();
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const CircleAvatar(
                              radius: 100.0,
                              // backgroundColor: Colors.red,
                              backgroundImage:
                                  AssetImage('assets/images/home_img.png'),
                            ),
                            Text(
                              _data?['name'] ?? '',
                              // 'Mahmuthan B',
                              // _data[]??'',
                              style: const TextStyle(
                                fontSize: 40.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pacifico',
                              ),
                            ),
                            Text(
                              _data?['category'] ?? '',
                              // '',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.teal.shade100,
                                letterSpacing: 1.5,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                              width: 150.0,
                              child: Divider(
                                color: Colors.teal.shade100,
                              ),
                            ),
                            Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 25.0),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.phone,
                                  color: Colors.teal,
                                ),
                                title: Text(
                                  _data?['phone_number'] ?? '',
                                  // '+90 506 922 92 21',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'SourceSansPro',
                                    color: Colors.teal.shade900,
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 25.0),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.email,
                                  color: Colors.teal,
                                ),
                                title: Text(
                                  _data?['email'] ?? '',
                                  // 'mahmuthanb@gmail.com',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'SourceSansPro',
                                    color: Colors.teal.shade900,
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 120.0),
                              child: TextButton(
                                onPressed: (() => Navigator.push(
                                    context,
                                    // MaterialPageRoute(builder: (context) => const ChatPage(),
                                    MaterialPageRoute(builder: (context) => const ChatPage(),
                                ))),
                                // onPressed: (){},
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.chat_rounded,
                                    color: Colors.teal,
                                  ),
                                  title: Text(
                                    'Чат',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'SourceSansPro',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal.shade900,
                                    ),
                                  ),
                                ),
                              )
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Flexible(
                              child: Text(
                                "Ошибка загрузки данных.\nПожалуйста, повторите попытку позже",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
