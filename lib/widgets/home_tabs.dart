import 'dart:developer';
import 'package:doc_app/pages/calendar_page.dart';
import 'package:doc_app/pages/doc_page.dart';
import 'package:doc_app/api/get_data.dart';
import 'package:doc_app/pages/test_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';

class HomeTabs extends StatefulWidget {
  const HomeTabs({Key? key}) : super(key: key);

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> with TickerProviderStateMixin {
  var _category = getCategoryData('categories');
  final List<String> _stack = ['categories'];
  bool _displayBack = false;

  void _initCategories(String _newCategory){
    _displayBack = true; 
    setState(() {
      _category = getCategoryData(_newCategory);
      _stack.add(_newCategory);
    });
  }

  void _returnOneStep(){
    if(_stack.length > 1){
      _stack.removeLast();
    }else if(_stack.last == 'categories'){
      return;
    }
    setState(() {
      if(_stack.length > 1){
        _category = getCategoryData(_stack.last);
      }else{
        _category = getCategoryData('categories');
        _displayBack = false; 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width,
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
                text: 'Календарь',
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
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            "Ошибка загрузки данных.\nПожалуйста, повторите попытку позже: ${snapshot.error.toString()}", 
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
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
                    return Column(
                      children: <Widget>[
                        _displayBack == true 
                        ? IconButton(
                            onPressed: _returnOneStep,
                            icon: const Icon(
                              Icons.arrow_back_sharp,
                            ),
                            tooltip: 'Назад',
                          )
                        // Center( 
                        //     child: BackButton(
                        //       color: Colors.red,
                        //       onPressed: _returnOneStep,
                        //     ),
                        //   )
                        : const SizedBox(height: 0),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                              return GestureDetector(
                                onTap: () => 
                                data['is_subcat'] == null && data['is_nestedcat'] != null
                                ? _initCategories('categories/' + data['id_category'].toString() + '/doctors')
                                : data['is_subcat'] != null && data['is_nestedcat'] == null ? _initCategories('doctors/' + data['id_category'].toString() + '/' + data['id_category'].toString())
                                : (data['is_nestedcat'] != null && data['is_nestedcat'] == true) || (data['is_nestedcat'] == null)
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => DocPage('doctors/' + data['id_category'].toString() + '/' + data['id_category'].toString(), data['id_doctor'])),
                                )
                                : data['is_nestedcat'] != null && data['is_nestedcat'] == false && data['id_category'] == 2
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const TestPage()),
                                ) : data['is_nestedcat'] != null && data['is_nestedcat'] == false && data['id_category'] == 3
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const TestPage()),
                                ) : null,
                                child: Card(
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
                                            data['name'] != null ? Text(data['name'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)) : const SizedBox(height: 0),
                                            const SizedBox(height: 4),
                                            // Text(data['first_name']! + ' ' + data['second_name']!, style: const TextStyle(color: Colors.white70)),
                                            // Text(data['category'], style: const TextStyle(color: Colors.white70)),
                                          ],
                                        ),
                                        const Spacer(),
                                        const CircleAvatar(
                                          // backgroundColor: Colors.white,
                                          // ignore: todo
                                          // TODO: to check if image file exists to avoid problem with image loading when image name is incorrect in DB
                                          // backgroundImage: data['img'] != "" && data['img'] != null
                                          // ? AssetImage('assets/images/' + data['img'])
                                          // : const AssetImage('assets/images/home_img.png')
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
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
              const CalendarPage(),
              /////
            ],
          ),
        ),
      ],
    );
  }
}
