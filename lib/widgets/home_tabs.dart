import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeTabs extends StatefulWidget {
  const HomeTabs({Key? key}) : super(key: key);

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> with TickerProviderStateMixin {
  final Stream<QuerySnapshot> _category = FirebaseFirestore.instance.collection('category').snapshots();
  
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width,
          // height: 55.0,
          height: MediaQuery.of(context).size.height * 0.1,
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const <Widget>[
              Tab(
                icon: Icon(Icons.medical_services),
                text: 'Категории',
              ),
              Tab(
                icon: Icon(Icons.event_note),
                text: 'История',
              ),
              Tab(
                icon: Icon(Icons.calendar_today),
                text: 'График',
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          // height: 150.0,
          height: MediaQuery.of(context).size.height * 0.575,
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              /////
              StreamBuilder<QuerySnapshot>(
                stream: _category,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Flexible(
                          child: Text(
                            "Ошибка загрузки данных.\nПожалуйста, повторите попытку позже", 
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  }

                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Flexible(
                          child: Text(
                            "Загрузка данных, пожалуйста, подождите..", 
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  }

                  if(snapshot.hasData){
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                          return Card(
                            margin: const EdgeInsets.all(12),
                            elevation: 4,
                            color: const Color.fromRGBO(64, 75, 96, .9),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(data['category'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 4),
                                      // Text(data['first_name']! + ' ' + data['second_name']!, style: const TextStyle(color: Colors.white70)),
                                      // Text(data['category'], style: const TextStyle(color: Colors.white70)),
                                    ],
                                  ),
                                  const Spacer(),
                                  CircleAvatar(
                                    // backgroundColor: Colors.white,
                                    backgroundImage: 
                                    data['img'] != "" &&  data['img'] != null && data['img'].length > 0 ?
                                    AssetImage('assets/images/' + data['img'])
                                    : const AssetImage('assets/images/home_img.png')
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }else{
                    return Expanded(
                    child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Flexible(
                            child: Text(
                              "Ошибка загрузки данных.\nПожалуйста, повторите попытку позже", 
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              /////
              const Text('1'),
              /////
              const Text('2'),
              /////
            ],
          ),
        ),
      ],
    );
  }
}
