import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Task1Main extends StatefulWidget {
  const Task1Main({super.key});

  @override
  State<Task1Main> createState() => _Task1MainState();
}

List<Tab> tabs = <Tab>[
  const Tab(text: 'Item 1'),
  const Tab(text: 'Item 2'),
  const Tab(text: 'Item 3'),
  const Tab(text: 'Item 4'),
  const Tab(text: 'Item 5'),
];

class _Task1MainState extends State<Task1Main> with TickerProviderStateMixin {
  late Future<dynamic> itemsJson;
  late TabController _tabController;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    itemsJson = getItems();
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        _activeIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Builder(
        builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              setState(() {
                _activeIndex = tabController.index;
              });
            }
          });
          return Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  tabs: tabs,
                ),
              ),
              body: TabBarView(
                  children:
                      (tabs.map<Widget>((currTab) => FutureBuilder<dynamic>(
                            future: itemsJson,
                            builder: (
                              BuildContext context,
                              AsyncSnapshot<dynamic> snapshot,
                            ) {
                              if (snapshot.hasData) {
                                var currItemData = snapshot.data[_activeIndex];
                                return Column(children: [
                                  Expanded(
                                      child:
                                          Image.network(currItemData['image'])),
                                  Text(currItemData.toString())
                                ]);
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ))).toList()));
        },
      ),
    );
  }
}

Future<dynamic> getItems() async {
  var resp =
      await http.get(Uri.parse('https://fakestoreapi.com/products?limit=5'));
  return jsonDecode(resp.body);
}
