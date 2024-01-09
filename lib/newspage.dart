import 'package:flutter/material.dart';
import 'package:flutter_application_1/news/advicePage.dart';
import 'package:flutter_application_1/news/community.dart';
import 'package:flutter_application_1/news/news.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _NewsPageState extends State<NewsPage> with TickerProviderStateMixin {
  late TabController _tabController;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          // ignore: sort_child_properties_last
          child: AppBar(
                        automaticallyImplyLeading: false,

            backgroundColor: const Color.fromARGB(255, 247, 247, 247),
            elevation: 0,
            toolbarHeight: 100, // default is 56
            title: TextField(
              focusNode: _focusNode,  
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(width: 0.8)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                          width: 0.8,
                          color: Color.fromRGBO(13, 159, 130, 1.000))),
                  hintText: "Поиск...",
                  hintStyle: const TextStyle(
                      color: Color.fromRGBO(13, 159, 130, 1.000)),
                  prefixIcon: const Icon(Icons.search,
                      size: 30, color: Color.fromRGBO(13, 159, 130, 1.000)),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      color: const Color.fromRGBO(13, 159, 130, 1.000),
                      onPressed: () {
                        _focusNode.unfocus();
                        // controller.clear();
                      })),
            ),
            bottom: TabBar(
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // Creates border
                  color: const Color.fromRGBO(13, 159, 130, 1.000)),
              controller: _tabController,
              labelStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              labelColor: const Color.fromARGB(255, 255, 255, 255),
              unselectedLabelColor: const Color.fromRGBO(13, 159, 130, 1.000),

              // ignore: prefer_const_literals_to_create_immutables
              tabs: [
                // ignore: prefer_const_constructors
                Tab(
                    icon: const Text(
                  'Новости',
                  style: TextStyle(fontSize: 14),
                )),
                const Tab(
                    icon: Text(
                  'Советы',
                  style: TextStyle(fontSize: 14),
                )),
                const Tab(
                    icon: Text(
                  'Сообщества',
                  style: TextStyle(fontSize: 14),
                )),
              ],
            ),
          ),
          // ),
        ),
        body: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: TabBarView(
            controller: _tabController,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const News(),
              const AdvicePage(),
              const Community(),
            ],
          ),
        ),
      ),
    );
  }
}
