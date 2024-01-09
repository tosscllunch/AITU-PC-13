import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/news/comments/CardDetalsPage.dart';
import 'package:flutter_application_1/news/comments/comart.dart';
import 'package:flutter_application_1/news/screens/article_screen.dart';
import 'package:flutter_application_1/customIcons/check_list_icons.dart';
import 'package:flutter_application_1/customIcons/new_paper_icons.dart';
import 'package:flutter_application_1/customIcons/setting_icons.dart';
import 'package:flutter_application_1/news/comments/comAd.dart';
import 'customIcons/book_icons.dart';
import 'customIcons/pills_icons.dart';
import 'customIcons/user_icons.dart';

import 'news/screens/advice_screen.dart';
import 'InteractionPage.dart';
import 'guidepage.dart';
import 'check.dart';
import 'newspage.dart';
import 'settings.dart';
import 'profile.dart';
import 'login_screen.dart';

import 'package:flutter_application_1/news/advicePage.dart';
import 'package:flutter_application_1/news/community.dart';

import 'package:flutter_application_1/alarm/alarmpage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Demo',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 242, 245, 244),
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ))),
      initialRoute: '/',
      routes: {
        '/homepage': (context) => const MyHomePage(),
        '/settings': (context) => const Settings(),
        '/profile': (context) => const ProfilePage(),
        '/guidepage': (context) => const GuidePage(),
        '/check': (context) => const Check(),
        '/': (context) => const LoginScreen(),
        '/alarm': (context) => const AlarmPage(),
        '/advice': (context) => const AdvicePage(),
        '/community': (context) => const Community(),
        '/newspage': (context) => const NewsPage(),
        '/cardDetails': (context) => const CardDetailsPage(card: []),
        //___articles___
        '/article': (context) => const ArticleScreen(article: []),

        //___advices___
        '/advi': (context) => const AdviceScreen(advice: []),
        //___comments_News___
        '/comments': (context) => const Comments(
              articleID: 0,
            ),
        //___comments_Adv___
        '/comAdv': (context) => const ComAdv(
              articleID: 0,
            ),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController pageController = PageController();

  late List<Widget> pages = [
    const InteractionPage(),
    const GuidePage(),
    const Check(),
    const NewsPage(),
    const AlarmPage(),
  ];

  int selectIndex = 0;

  void onPageChanged(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.white,
        toolbarHeight: 50,
        toolbarOpacity: 1,
        elevation: 0,
        centerTitle: true,
        title: Text(
          selectIndex == 0
              ? 'Взаимодействия'
              : selectIndex == 1
                  ? 'Справочник'
                  : selectIndex == 2
                      ? 'Проверка рецепта'
                      : selectIndex == 3
                          ? 'Новости'
                          : 'Будильник',
          style: const TextStyle(color: Colors.teal),
        ),
        backgroundColor: const Color.fromARGB(255, 242, 245, 244),
        leading: IconButton(
          iconSize: 32,
          icon: const Icon(
            Setting.cog,
            color: Color.fromRGBO(13, 159, 130, 1.000),
          ),
          tooltip: 'Menu Icon',
          onPressed: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
        actions: <Widget>[
          IconButton(
            iconSize: 36,
            icon: const Icon(
              User.user_circle,
              color: Color.fromRGBO(13, 159, 130, 1.000),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          )
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: const Color.fromARGB(255, 151, 155, 154),
        selectedFontSize: 20,
        unselectedFontSize: 12,
        showUnselectedLabels: false,
        currentIndex: selectIndex,
        onTap: (index) {
          setState(() {
            pageController.jumpToPage(index);
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 242, 245, 244),
        selectedItemColor: const Color.fromRGBO(13, 159, 130, 1.000),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Pills.pills,
              size: 29,
            ),
            label: '••',
            backgroundColor: Color.fromRGBO(240, 255, 250, 1.000),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Book.book_medical,
              size: 29,
            ),
            label: '••',
            backgroundColor: Color.fromRGBO(240, 255, 250, 1.000),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CheckList.checklist,
              size: 36,
            ),
            label: '••',
            backgroundColor: Color.fromRGBO(240, 255, 250, 1.000),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              NewPaper.doc,
              size: 29,
            ),
            label: '••',
            backgroundColor: Color.fromRGBO(240, 255, 250, 1.000),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm, size: 35),
            label: '••',
            backgroundColor: Color.fromRGBO(240, 255, 250, 1.000),
          ),
        ],
      ),
    );
  }
}
