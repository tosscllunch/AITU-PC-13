// ignore_for_file: use_build_context_synchronously

import 'package:postgres/postgres.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/registration.dart';
import 'globals.dart' as globals;

class Registration2 extends StatefulWidget {
  final List userInfo;

  const Registration2({Key? key, required this.userInfo}) : super(key: key);
  @override
  State<Registration2> createState() => _Registration2();
}

class _Registration2 extends State<Registration2> {
  final nameTextFieldController = TextEditingController();
  final surnameTextFieldController = TextEditingController();
  final dateFieldController = TextEditingController();
  final heightTextFieldController = TextEditingController();
  final weightTextFieldController = TextEditingController();

  String dropdownValueCity = 'Астана';
  String dropdownValueType = 'Врач';
  String dropdownValue = 'Медицинский специалист';
  String dropdownValueSPLZ = "Отсутвует";

  bool inputet = false;
  bool nameError = false;
  bool surnameError = false;
  bool weightError = false;
  bool heightError = false;

  late bool done;

  void awaiting() async {
    final email = await connection(widget.userInfo[0]);

    if (email.length != 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const Registration(email3Error: true)));
    } else {
      setState(() {
        done = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    awaiting();
    done = false;
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 40,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          body: done
              ? Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Регистрация",
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Фамилия',
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                            // textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: nameTextFieldController,
                            onChanged: (value) {
                              setState(() {
                                nameError = false;
                              });
                              if (nameTextFieldController.text.isNotEmpty &&
                                  surnameTextFieldController.text.isNotEmpty) {
                                if (dropdownValue == 'Пользователь') {
                                  if (dateFieldController.text.isNotEmpty &&
                                      heightTextFieldController
                                          .text.isNotEmpty &&
                                      weightTextFieldController
                                          .text.isNotEmpty) {
                                    setState(() {
                                      inputet = true;
                                    });
                                  }
                                } else {
                                  setState(() {
                                    inputet = true;
                                  });
                                }
                              } else {
                                setState(() {
                                  inputet = false;
                                });
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.teal[200],
                              errorText: nameError
                                  ? 'Пожалуйста, введите свое имя'
                                  : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.teal,
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              hintText: 'Фамилия',
                              hintStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Имя',
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                            // textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: surnameTextFieldController,
                            onChanged: (value) {
                              setState(() {
                                surnameError = false;
                              });
                              if (nameTextFieldController.text.isNotEmpty &&
                                  surnameTextFieldController.text.isNotEmpty) {
                                if (dropdownValue == 'Пользователь') {
                                  if (dateFieldController.text.isNotEmpty &&
                                      heightTextFieldController
                                          .text.isNotEmpty &&
                                      weightTextFieldController
                                          .text.isNotEmpty) {
                                    setState(() {
                                      inputet = true;
                                    });
                                  }
                                } else {
                                  setState(() {
                                    inputet = true;
                                  });
                                }
                              } else {
                                setState(() {
                                  inputet = false;
                                });
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.teal[200],
                              errorText: surnameError
                                  ? 'Пожалуйста, введите свою фамилию'
                                  : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.teal,
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              hintText: 'Имя',
                              hintStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Город',
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                            // textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.teal[200],
                              border: Border.all(
                                width: 1,
                                color: Colors.teal,
                              ),
                            ),
                            width: 400,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                // Step 3.
                                value: dropdownValueCity,
                                dropdownColor: Colors.teal[200],

                                // Step 4.
                                items: <String>[
                                  'Алматы',
                                  'Астана',
                                  'Шымкент',
                                  'Абайская область',
                                  'Акмолинская область',
                                  'Актюбинская область',
                                  'Алматинская область',
                                  'Атырауская область',
                                  'Восточно-Казахстанская область',
                                  'Жамбылская область',
                                  'Жетысуская область',
                                  'Западно-Казахстанская область',
                                  'Карагандинская область',
                                  'Костанайская область',
                                  'Кызылординская область',
                                  'Мангистауская область',
                                  'Павлодарская область',
                                  'Северо-Казахстанская область',
                                  'Туркестанская область',
                                  'Улытауская область',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        const Icon(
                                          Icons.home,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          value,
                                          textScaleFactor: 1.0,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                // Step 5.
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValueCity = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Тип пользователя',
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.teal[200],
                              border: Border.all(
                                width: 1,
                                color: Colors.teal,
                              ),
                            ),
                            width: 400,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                // Step 3.
                                value: dropdownValue,
                                dropdownColor: Colors.teal[200],

                                // Step 4.
                                items: <String>[
                                  'Медицинский специалист',
                                  'Пользователь'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        if (value == 'Пользователь')
                                          const Icon(
                                            Icons.badge_outlined,
                                            color: Colors.white,
                                          )
                                        else
                                          const Icon(
                                            Icons.local_hospital_rounded,
                                            color: Colors.white,
                                          ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          value,
                                          textScaleFactor: 1.0,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                // Step 5.
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                  if (dropdownValue == 'Пользователь') {
                                    if (dateFieldController.text.isEmpty ||
                                        heightTextFieldController
                                            .text.isEmpty ||
                                        weightTextFieldController
                                            .text.isEmpty) {
                                      setState(() {
                                        inputet = false;
                                      });
                                    }
                                  } else {
                                    if (nameTextFieldController
                                            .text.isNotEmpty &&
                                        surnameTextFieldController
                                            .text.isNotEmpty) {
                                      setState(() {
                                        inputet = true;
                                      });
                                    } else {
                                      setState(() {
                                        inputet = false;
                                      });
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                if (dropdownValue == 'Медицинский специалист') {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Специализация',
                                        style: TextStyle(
                                          color: Colors.teal,
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.teal[200],
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.teal,
                                          ),
                                        ),
                                        width: 400,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            // Step 3.
                                            value: dropdownValueType,
                                            dropdownColor: Colors.teal[200],

                                            // Step 4.
                                            items: <String>[
                                              'Врач',
                                              'Медсестра/Медбрат',
                                              'Фармацевт',
                                              'Cтудент медицинского ВУЗа'
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    if (value ==
                                                        'Cтудент медицинского ВУЗа')
                                                      const Icon(
                                                        Icons.badge_outlined,
                                                        color: Colors.white,
                                                      )
                                                    else if (value ==
                                                        'Медсестра/Медбрат')
                                                      const Icon(
                                                        Icons.emergency_rounded,
                                                        color: Colors.white,
                                                      )
                                                    else if (value ==
                                                        'Фармацевт')
                                                      const Icon(
                                                        Icons
                                                            .medication_rounded,
                                                        color: Colors.white,
                                                      )
                                                    else
                                                      const Icon(
                                                        Icons
                                                            .local_hospital_rounded,
                                                        color: Colors.white,
                                                      ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    Text(
                                                      value,
                                                      textScaleFactor: 1.0,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                            // Step 5.
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownValueType = newValue!;
                                                if (dropdownValueType ==
                                                    'Студент медицинского ВУЗа') {}
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return const SizedBox(
                                    height: 0.1,
                                  );
                                }
                              }),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                if (dropdownValue != 'Пользователь') {
                                  if (dropdownValueType == 'Врач') {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        const Text(
                                          'Узкая специализация',
                                          style: TextStyle(
                                            color: Colors.teal,
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          // textAlign: TextAlign.left,
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.teal[200],
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.teal,
                                            ),
                                          ),
                                          width: 400,
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              // Step 3.
                                              value: dropdownValueSPLZ,
                                              dropdownColor: Colors.teal[200],

                                              // Step 4.
                                              items: <String>[
                                                'Отсутвует',
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
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      const Icon(
                                                        Icons.school_rounded,
                                                        color: Colors.white,
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Text(
                                                        value,
                                                        textScaleFactor: 1.0,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                              // Step 5.
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownValueSPLZ = newValue!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    );
                                  } else {
                                    return const SizedBox(
                                      height: 20,
                                    );
                                  }
                                } else if (dropdownValue == 'Пользователь') {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Дата рождения',
                                        style: TextStyle(
                                          color: Colors.teal,
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.teal[200],
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.teal,
                                          ),
                                        ),
                                        child: TextField(
                                          controller: dateFieldController,
                                          onChanged: (value) {
                                            if (nameTextFieldController
                                                    .text.isNotEmpty &&
                                                surnameTextFieldController
                                                    .text.isNotEmpty) {
                                              if (dropdownValue ==
                                                  'Пользователь') {
                                                if (dateFieldController
                                                        .text.isNotEmpty &&
                                                    heightTextFieldController
                                                        .text.isNotEmpty &&
                                                    weightTextFieldController
                                                        .text.isNotEmpty) {
                                                  setState(() {
                                                    inputet = true;
                                                  });
                                                }
                                              } else {
                                                setState(() {
                                                  inputet = true;
                                                });
                                              }
                                            } else {
                                              setState(() {
                                                inputet = false;
                                              });
                                            }
                                          },
                                          autofillHints: const ['xx/xx/xxxx'],
                                          keyboardType: TextInputType.datetime,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            prefixIcon: Icon(
                                              Icons.calendar_month_outlined,
                                              color: Colors.white,
                                            ),
                                            hintText: 'дд/мм/гггг',
                                            hintStyle:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Рост',
                                        style: TextStyle(
                                          color: Colors.teal,
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        // textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: heightTextFieldController,
                                        onChanged: (value) {
                                          setState(() {
                                            heightError = false;
                                          });
                                          if (nameTextFieldController
                                                  .text.isNotEmpty &&
                                              surnameTextFieldController
                                                  .text.isNotEmpty) {
                                            if (dropdownValue ==
                                                'Пользователь') {
                                              if (dateFieldController
                                                      .text.isNotEmpty &&
                                                  heightTextFieldController
                                                      .text.isNotEmpty &&
                                                  weightTextFieldController
                                                      .text.isNotEmpty) {
                                                setState(() {
                                                  inputet = true;
                                                });
                                              }
                                            } else {
                                              setState(() {
                                                inputet = true;
                                              });
                                            }
                                          } else {
                                            setState(() {
                                              inputet = false;
                                            });
                                          }
                                        },
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          filled: true,
                                          fillColor: Colors.teal[200],
                                          errorText: heightError
                                              ? 'Пожалуйста, введите свой рост'
                                              : null,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Colors.teal,
                                            ),
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.height_rounded,
                                            color: Colors.white,
                                          ),
                                          hintText: 'Pocт',
                                          hintStyle: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Bec',
                                        style: TextStyle(
                                          color: Colors.teal,
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        // textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: weightTextFieldController,
                                        onChanged: (value) {
                                          setState(() {
                                            weightError = false;
                                          });
                                          if (nameTextFieldController
                                                  .text.isNotEmpty &&
                                              surnameTextFieldController
                                                  .text.isNotEmpty) {
                                            if (dropdownValue ==
                                                'Пользователь') {
                                              if (dateFieldController
                                                      .text.isNotEmpty &&
                                                  heightTextFieldController
                                                      .text.isNotEmpty &&
                                                  weightTextFieldController
                                                      .text.isNotEmpty) {
                                                setState(() {
                                                  inputet = true;
                                                });
                                              }
                                            } else {
                                              setState(() {
                                                inputet = true;
                                              });
                                            }
                                          } else {
                                            setState(() {
                                              inputet = false;
                                            });
                                          }
                                        },
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          filled: true,
                                          fillColor: Colors.teal[200],
                                          errorText: weightError
                                              ? 'Пожалуйста, введите свой вес'
                                              : null,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Colors.teal,
                                            ),
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.balance_rounded,
                                            // fitness_center_outlined
                                            color: Colors.white,
                                          ),
                                          hintText: 'Bec',
                                          hintStyle: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  );
                                } else {
                                  return const SizedBox(height: 20);
                                }
                              }),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                  child: inputet
                                      ? ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.teal,
                                              minimumSize: const Size(100, 50)),
                                          onPressed: () async {
                                            if (nameTextFieldController.text !=
                                                "") {
                                              widget.userInfo[2] =
                                                  nameTextFieldController.text;
                                            }
                                            if (surnameTextFieldController
                                                    .text !=
                                                "") {
                                              widget.userInfo[3] =
                                                  surnameTextFieldController
                                                      .text;
                                            }
                                            if (dropdownValueCity != "") {
                                              widget.userInfo[4] =
                                                  dropdownValueCity;
                                            }
                                            if (dropdownValue != "") {
                                              if (dropdownValue ==
                                                  "Пользователь") {
                                                widget.userInfo[5] = "user";
                                                widget.userInfo[7] =
                                                    heightTextFieldController
                                                        .text;
                                                widget.userInfo[8] =
                                                    weightTextFieldController
                                                        .text;
                                              } else {
                                                widget.userInfo[5] =
                                                    "specialist";
                                                widget.userInfo[6] =
                                                    dropdownValueType;
                                              }
                                            }
                                            if (dateFieldController.text !=
                                                "") {
                                              widget.userInfo[9] =
                                                  dateFieldController.text;
                                            }
                                            if (dropdownValueSPLZ != "") {
                                              widget.userInfo[10] =
                                                  dropdownValueSPLZ;
                                            }

                                            await registration(widget.userInfo);

                                            for (int i = 0;
                                                i < widget.userInfo.length;
                                                i++) {
                                              globals.userInfoFinal[i] =
                                                  widget.userInfo[i];
                                            }

                                            // ignore: use_build_context_synchronously
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/homepage',
                                                (_) => false);
                                          },
                                          child: const Text(
                                            "Завершить регистрацию",
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ))
                                      : TextButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.grey,
                                              minimumSize: const Size(100, 50)),
                                          onPressed: () {
                                            if (nameTextFieldController
                                                .text.isEmpty) {
                                              setState(() {
                                                nameError = true;
                                              });
                                            }
                                            if (surnameTextFieldController
                                                .text.isEmpty) {
                                              setState(() {
                                                surnameError = true;
                                              });
                                            }
                                            if (dropdownValue ==
                                                'Пользователь') {
                                              if (weightTextFieldController
                                                  .text.isEmpty) {
                                                setState(() {
                                                  weightError = true;
                                                });
                                              }
                                              if (heightTextFieldController
                                                  .text.isEmpty) {
                                                setState(() {
                                                  heightError = true;
                                                });
                                              }
                                            }
                                          },
                                          child: const Text(
                                            "Завершить регистрацию",
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        ));
  }

  register(userinfo, connection) async {
    await connection.execute(
        "INSERT INTO users (_email, _password, _name, _surname, _city, _usertype, _specialization, _height, _weight, _date, _narrow_specialization) VALUES ('${userinfo[0].toString()}', '${userinfo[1].toString()}', '${userinfo[2].toString()}', '${userinfo[3].toString()}', '${userinfo[4].toString()}', '${userinfo[5].toString()}', '${userinfo[6].toString()}', '${userinfo[7].toString()}', '${userinfo[8].toString()}', '${userinfo[9].toString()}', '${userinfo[10].toString()}')");
  }

  registration(userinfo) async {
    var connection = PostgreSQLConnection(
        "62.84.121.141", // hostURL
        5432, // port
        "mua_db_v1", // databaseName
        username: "postgres",
        password: "admin",
        useSSL: false);

    await connection.open();
    await register(userinfo, connection);
  }

  connect(email, connection) async {
    var result = await connection
        .query("SELECT * FROM users WHERE _email = '${email.toString()}'");

    if (result.length == 0) {
      return [];
    } else {
      return result;
    }
  }

  connection(email) async {
    var connection = PostgreSQLConnection(
        "62.84.121.141", // hostURL
        5432, // port
        "mua_db_v1", // databaseName
        username: "postgres",
        password: "admin",
        useSSL: false);

    await connection.open();
    return await connect(email, connection);
  }
}
