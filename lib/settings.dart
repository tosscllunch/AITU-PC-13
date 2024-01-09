import 'package:flutter/material.dart';

// import 'settingPage/aboutUs.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isDark = false;
  bool isEye = false;
  bool isDalt = false;
  bool isMed = false;
  bool budilnik = false;
  bool russian = true;
  bool english = false;
  bool kazakh = false;

  PageController pageController = PageController();

  int selectIndex = 0;

  void onPageChanged(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Настройки'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              ListTile(
                iconColor: const Color.fromRGBO(13, 159, 130, 1.000),
                textColor: const Color.fromRGBO(13, 159, 130, 1.000),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 2, color: Color.fromRGBO(13, 159, 130, 1.000)),
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text('Уведомления',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                leading: const Icon(Icons.notifications),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        color: const Color.fromARGB(255, 255, 255, 254),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _CustomListTile(
                                //смени название
                                title: "Убрать звук",
                                icon: Icons.music_note,
                                trailing: Switch(
                                    value: isMed,
                                    onChanged: (value) {
                                      setState(() {
                                        isMed = value;
                                        Navigator.pop(context);
                                      });
                                    })),
                            _CustomListTile(
                                title: "Присылать уведомления",
                                icon: Icons.notification_add,
                                trailing: Checkbox(
                                  value: budilnik,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      budilnik = value!;
                                      Navigator.pop(context);
                                    });
                                  },
                                )),
                          ],
                        ),
                      );
                    },
                  );
                  // Navigator.pushNamed(context, '/check');
                },
              ),
              const SizedBox(
                height: 8,
              ),
              ListTile(
                iconColor: const Color.fromRGBO(13, 159, 130, 1.000),
                textColor: const Color.fromRGBO(13, 159, 130, 1.000),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 2, color: Color.fromRGBO(13, 159, 130, 1.000)),
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text(
                  'Политика Конфиденциальности',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                leading: const Icon(Icons.security),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Policits()),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              ListTile(
                iconColor: const Color.fromRGBO(13, 159, 130, 1.000),
                textColor: const Color.fromRGBO(13, 159, 130, 1.000),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 2, color: Color.fromRGBO(13, 159, 130, 1.000)),
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text('Обратная связь',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                leading: const Icon(Icons.phone),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FedBack()),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              ListTile(
                iconColor: const Color.fromRGBO(13, 159, 130, 1.000),
                textColor: const Color.fromRGBO(13, 159, 130, 1.000),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 2, color: Color.fromRGBO(13, 159, 130, 1.000)),
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text('Смена языка',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                leading: const Icon(Icons.language),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 230,
                        color: const Color.fromARGB(255, 255, 255, 254),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _CustomListTile(
                                title: "Русский",
                                icon: Icons.language,
                                trailing: Checkbox(
                                  value: russian,
                                  onChanged: (bool? value) {
                                    if (value == true) {
                                      setState(() {
                                        russian = true;
                                        english = false;
                                        kazakh = false;

                                        Navigator.pop(context);
                                      });
                                    }
                                  },
                                )),
                            _CustomListTile(
                                title: "English",
                                icon: Icons.language,
                                trailing: Checkbox(
                                  value: english,
                                  onChanged: (bool? value) {
                                    if (value == true) {
                                      setState(() {
                                        russian = false;
                                        english = true;
                                        kazakh = false;

                                        Navigator.pop(context);
                                      });
                                    }
                                  },
                                )),
                            _CustomListTile(
                                title: "Қазақша",
                                icon: Icons.language,
                                trailing: Checkbox(
                                  value: kazakh,
                                  onChanged: (bool? value) {
                                    if (value == true) {
                                      setState(() {
                                        russian = false;
                                        english = false;
                                        kazakh = true;

                                        Navigator.pop(context);
                                      });
                                    }
                                  },
                                )),
                          ],
                        ),
                      );
                    },
                  );
                  // Navigator.pushNamed(context, '/check');
                },
              ),
              const SizedBox(
                height: 8,
              ),
              ListTile(
                iconColor: const Color.fromRGBO(13, 159, 130, 1.000),
                textColor: const Color.fromRGBO(13, 159, 130, 1.000),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 2, color: Color.fromRGBO(13, 159, 130, 1.000)),
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text('О нас',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                leading: const Icon(Icons.info),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutUs()),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                color: Color.fromRGBO(13, 159, 130, 1.000),
                thickness: 2,
              ),
              _CustomListTile(
                  title: "Ночной и дневной режим",
                  icon: Icons.dark_mode_outlined,
                  trailing: Switch(
                      value: _isDark,
                      onChanged: (value) {
                        setState(() {
                          _isDark = value;
                        });
                      })),
              _CustomListTile(
                  //смени название
                  title: "Режим для слабовидящих",
                  icon: Icons.remove_red_eye,
                  trailing: Switch(
                      value: isEye,
                      onChanged: (value) {
                        setState(() {
                          isEye = value;
                        });
                      })),
              _CustomListTile(
                  title: "Режим для дальтоников",
                  icon: Icons.invert_colors_on,
                  trailing: Switch(
                      value: isDalt,
                      onChanged: (value) {
                        setState(() {
                          isDalt = value;
                        });
                      })),
            ],
          ),
        ),
      ),
    );
  }
}

class Policits extends StatelessWidget {
  const Policits({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('О нас'),
          ),
          body: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(height: 30),
              const Text(
                "Политика",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
    );
  }
}

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('О нас'),
          ),
          body: Column(
            children: [
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3,
                child: Image.asset('lib/icons/logo.png'),
              ),
              const Text(
                "Инфа",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
    );
  }
}

class FedBack extends StatelessWidget {
  const FedBack({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Обратная связь'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              ListTile(
                iconColor: const Color.fromRGBO(13, 159, 130, 1.000),
                textColor: const Color.fromRGBO(13, 159, 130, 1.000),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 2, color: Color.fromRGBO(13, 159, 130, 1.000)),
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text('Живой оператор',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                leading: const Icon(Icons.person),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {
                  // Navigator.pushNamed(context, '/check');
                },
              ),
              const SizedBox(
                height: 8,
              ),
              ListTile(
                iconColor: const Color.fromRGBO(13, 159, 130, 1.000),
                textColor: const Color.fromRGBO(13, 159, 130, 1.000),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 2, color: Color.fromRGBO(13, 159, 130, 1.000)),
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text(
                  'Чат-бот',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                leading: const Icon(Icons.telegram_rounded),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {},
              ),
              const SizedBox(
                height: 8,
              ),
              ListTile(
                iconColor: const Color.fromRGBO(13, 159, 130, 1.000),
                textColor: const Color.fromRGBO(13, 159, 130, 1.000),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 2, color: Color.fromRGBO(13, 159, 130, 1.000)),
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text('Часто задаваемые вопросы',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                leading: const Icon(Icons.help),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Questions()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Questions extends StatelessWidget {
  const Questions({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Часто задаваемые вопросы'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              ListTile(
                iconColor: const Color.fromRGBO(13, 159, 130, 1.000),
                textColor: const Color.fromRGBO(13, 159, 130, 1.000),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 2, color: Color.fromRGBO(13, 159, 130, 1.000)),
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text('Регистрация в приложении',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {
                  // Navigator.pushNamed(context, '/check');
                },
              ),
              const SizedBox(
                height: 8,
              ),
              ListTile(
                iconColor: const Color.fromRGBO(13, 159, 130, 1.000),
                textColor: const Color.fromRGBO(13, 159, 130, 1.000),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 2, color: Color.fromRGBO(13, 159, 130, 1.000)),
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text(
                  'Как проверить взаимодействие лекарств?',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {},
              ),
              const SizedBox(
                height: 8,
              ),
              ListTile(
                iconColor: const Color.fromRGBO(13, 159, 130, 1.000),
                textColor: const Color.fromRGBO(13, 159, 130, 1.000),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 2, color: Color.fromRGBO(13, 159, 130, 1.000)),
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text(
                    'Как найти лекарство и где находится справочник?',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {},
              ),
              const SizedBox(
                height: 8,
              ),
              ListTile(
                iconColor: const Color.fromRGBO(13, 159, 130, 1.000),
                textColor: const Color.fromRGBO(13, 159, 130, 1.000),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 2, color: Color.fromRGBO(13, 159, 130, 1.000)),
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text(
                  'Не помню пароль как быть?',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {},
              ),
              const SizedBox(
                height: 8,
              ),
              ListTile(
                iconColor: const Color.fromRGBO(13, 159, 130, 1.000),
                textColor: const Color.fromRGBO(13, 159, 130, 1.000),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 2, color: Color.fromRGBO(13, 159, 130, 1.000)),
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text(
                  'Не помню логин как быть?',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {},
              ),
              const SizedBox(
                height: 8,
              ),
              ListTile(
                iconColor: const Color.fromRGBO(13, 159, 130, 1.000),
                textColor: const Color.fromRGBO(13, 159, 130, 1.000),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 2, color: Color.fromRGBO(13, 159, 130, 1.000)),
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text(
                  'Как поставить напоминание в будильнике?',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {},
              ),
              const SizedBox(
                height: 8,
              ),
              ListTile(
                iconColor: const Color.fromRGBO(13, 159, 130, 1.000),
                textColor: const Color.fromRGBO(13, 159, 130, 1.000),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 2, color: Color.fromRGBO(13, 159, 130, 1.000)),
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text(
                  'Я был ранее регистрирован, как мне войти в новое мобильное приложение?',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {},
              ),
              const SizedBox(
                height: 8,
              ),
              ListTile(
                iconColor: const Color.fromRGBO(13, 159, 130, 1.000),
                textColor: const Color.fromRGBO(13, 159, 130, 1.000),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 2, color: Color.fromRGBO(13, 159, 130, 1.000)),
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text(
                  'Я дальтоник как можно поменять режим?',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  const _CustomListTile(
      {Key? key, required this.title, required this.icon, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
              width: 2, color: Color.fromRGBO(13, 159, 130, 1.000)),
          borderRadius: BorderRadius.circular(10),
        ),
        color: const Color.fromARGB(255, 252, 255, 254),
        child: ListTile(
          iconColor: const Color.fromRGBO(13, 159, 130, 1.000),
          textColor: const Color.fromARGB(255, 10, 128, 105),
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          leading: Icon(icon),
          trailing: trailing,
          onTap: () {
            // const snackBar = SnackBar(content: Text('Tap'));
            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        ),
      ),
    );
  }
}
