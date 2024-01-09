import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'globals.dart' as globals;
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String dropdownValueSPLZ = globals.userInfoFinal[10];
  bool changed = false;
  File? _image;

  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Личный кабинет'),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 226, 225, 225),
                      radius: 70.0,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: _image != null
                              ? Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                  width: 140.0,
                                  height: 140.0,
                                )
                              : const Text(''))),
                  SizedBox(
                    width: 55,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: _openImagePicker,
                      child: const Icon(Icons.camera_alt),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'ПРОФИЛЬ',
                    style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        color: Colors.teal.shade100,
                        fontSize: 20.0,
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.bold),
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: Color.fromRGBO(13, 159, 130, 1.000),
                      ),
                      title: Text(
                        "${globals.userInfoFinal[2]} ${globals.userInfoFinal[3]}",
                        style: const TextStyle(
                            color: Color.fromRGBO(13, 159, 130, 1.000),
                            fontFamily: 'Source Sans Pro',
                            fontSize: 17.0),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: const Icon(
                        Icons.home,
                        color: Color.fromRGBO(13, 159, 130, 1.000),
                      ),
                      title: Text(
                        globals.userInfoFinal[4],
                        style: const TextStyle(
                            color: Color.fromRGBO(13, 159, 130, 1.000),
                            fontFamily: 'Source Sans Pro',
                            fontSize: 16.0),
                      ),
                    ),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (globals.userInfoFinal[5] == 'specialist') {
                          if (globals.userInfoFinal[6] == 'Врач') {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  Card(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 25.0),
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.medical_information_outlined,
                                        color:
                                            Color.fromRGBO(13, 159, 130, 1.000),
                                      ),
                                      title: Text(
                                        globals.userInfoFinal[6],
                                        style: const TextStyle(
                                            color: Color.fromRGBO(
                                                13, 159, 130, 1.000),
                                            fontFamily: 'Source Sans Pro',
                                            fontSize: 16.0),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 25.0),
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.school_sharp,
                                        color:
                                            Color.fromRGBO(13, 159, 130, 1.000),
                                      ),
                                      title: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          // Step 3.
                                          value: dropdownValueSPLZ,
                                          // Step 4.
                                          items: <String>[
                                            "Отсутвует",
                                            "Акушер-гинеколог",
                                            "Аллерголог",
                                            "Анестезиолог-реаниматолог",
                                            "Андролог",
                                            "Венеролог",
                                            "ВОП",
                                            "Гастроэнтеролог",
                                            "Гематолог",
                                            "Гепатолог",
                                            "Гериатр",
                                            "Дерматовенеролог",
                                            "Дерматолог",
                                            "Детский хирург",
                                            "Иммунолог",
                                            "Инфекционист",
                                            "Кардиолог",
                                            "Клинический фармаколог",
                                            "Маммолог",
                                            "Нарколог",
                                            "Невролог",
                                            "Нейрохирург",
                                            "Неонатолог",
                                            "Нефролог",
                                            "Нутрициолог",
                                            "Окулист",
                                            "Онколог",
                                            "Оториноларинголог",
                                            "Педиатр",
                                            "Проктолог",
                                            "Психиатр",
                                            "Пульмонолог",
                                            "Ревматолог",
                                            "Сексолог",
                                            "Стоматолог",
                                            "Терапевт",
                                            "Токсиколог",
                                            "Травматолог",
                                            "Трансплантолог",
                                            "Уролог",
                                            "Флеболог",
                                            "Фтизиатр",
                                            "Хирург",
                                            "Эндокринолог",
                                            "Эпилептолог"
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    value,
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                        color: changed
                                                            ? Colors.red
                                                            : const Color
                                                                    .fromRGBO(
                                                                13,
                                                                159,
                                                                130,
                                                                1.000),
                                                        fontFamily:
                                                            'Source Sans Pro',
                                                        fontWeight: changed
                                                            ? FontWeight.w500
                                                            : FontWeight.normal,
                                                        fontSize: 16.0),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                          // Step 5.
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownValueSPLZ = newValue!;
                                              changed = true;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  changed
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              right: 25.0, left: 25.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            minimumSize:
                                                                const Size(
                                                                    100, 48)),
                                                    onPressed: () async {
                                                      globals.userInfoFinal[
                                                              10] =
                                                          dropdownValueSPLZ;
                                                      await changing(globals
                                                          .userInfoFinal);
                                                      setState(() {
                                                        changed = false;
                                                      });
                                                    },
                                                    child: const Text(
                                                      'Сохранить изменения',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox(
                                          height: 0.1,
                                        ),
                                ],
                              ),
                            );
                          } else {
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 25.0),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.school_sharp,
                                  color: Color.fromRGBO(13, 159, 130, 1.000),
                                ),
                                title: Text(
                                  globals.userInfoFinal[6],
                                  style: const TextStyle(
                                      color:
                                          Color.fromRGBO(13, 159, 130, 1.000),
                                      fontFamily: 'Source Sans Pro',
                                      fontSize: 20.0),
                                ),
                              ),
                            );
                          }
                        } else {
                          return Column(
                            children: [
                              Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 25.0),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.calendar_month_outlined,
                                    color: Color.fromRGBO(13, 159, 130, 1.000),
                                  ),
                                  title: Text(
                                    'ДР: ${globals.userInfoFinal[9]}',
                                    style: const TextStyle(
                                        color:
                                            Color.fromRGBO(13, 159, 130, 1.000),
                                        fontFamily: 'Source Sans Pro',
                                        fontSize: 20.0),
                                  ),
                                ),
                              ),
                              Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 25.0),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.balance_rounded,
                                    color: Color.fromRGBO(13, 159, 130, 1.000),
                                  ),
                                  title: Text(
                                    'Вес: ${globals.userInfoFinal[7]}',
                                    style: const TextStyle(
                                        color:
                                            Color.fromRGBO(13, 159, 130, 1.000),
                                        fontFamily: 'Source Sans Pro',
                                        fontSize: 20.0),
                                  ),
                                ),
                              ),
                              Card(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 25.0,
                                  ),
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.height_outlined,
                                      color: Colors.teal,
                                    ),
                                    title: Text(
                                      'Рост: ${globals.userInfoFinal[8]}',
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          color: Color.fromRGBO(
                                              13, 159, 130, 1.000),
                                          fontFamily: 'Source Sans Pro'),
                                    ),
                                  )),
                            ],
                          );
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              minimumSize: const Size(100, 48)),
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/', (_) => false);
                          },
                          child: const Text(
                            'Покинуть профиль',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  change(userinfo, connection) async {
    await connection.query(
        "UPDATE users SET _narrow_specialization = '${userinfo[10].toString()}' WHERE _email = '${userinfo[0].toString()}'");
  }

  changing(userinfo) async {
    var connection = globals.connection();

    await connection.open();
    await change(userinfo, connection);
  }
}
