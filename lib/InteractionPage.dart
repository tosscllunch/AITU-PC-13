// ignore_for_file: use_build_context_synchronously, prefer_is_empty, duplicate_ignore, unused_label, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:tuple/tuple.dart';
import 'package:trotter/trotter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'globals.dart' as globals;

class InteractionPage extends StatefulWidget {
  const InteractionPage({Key? key}) : super(key: key);

  @override
  State<InteractionPage> createState() => _InteractionPageState();
}

class _InteractionPageState extends State<InteractionPage> {
  final textController = TextEditingController();

  List<String> drug = [];

  bool isLoading = false;

  bool parameters = false;

  String dropdownValueType = 'Мужской';

  late TextEditingController _controller1;

  late TextEditingController _controller2;

  late TextEditingController _controller3;

  late List<String> autoCompleteData;

  late TextEditingController controller;

  // final _focusNode = FocusNode();

  Future fetchAutoCompleteData() async {
    setState(() {
      isLoading = true;
    });

    final String stringData =
        await rootBundle.loadString("assets/eng_name.json");

    final List<dynamic> json = jsonDecode(stringData);

    final List<String> jsonStringData = json.cast<String>();
    // print(json.runtimeType);
    // print(jsonStringData.runtimeType);

    // print(jsonStringData);

    setState(() {
      isLoading = false;
      autoCompleteData = jsonStringData;
    });
  }

  String btntxt() {
    if (drug.length >= 2) {
      return 'Найти взаимодействия';
    } else {
      return 'Добавьте минимум 2 лекарства';
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    fetchAutoCompleteData();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            shadowColor: const Color.fromARGB(255, 255, 255, 255),
            toolbarHeight: 70, // default is 56
            toolbarOpacity: 1,
            title: Row(
              children: [
                Expanded(
                    child: Autocomplete(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    } else {
                      return autoCompleteData.where((word) => word
                          .toLowerCase()
                          .startsWith(textEditingValue.text.toLowerCase()));
                    }
                  },
                  optionsViewBuilder:
                      (context, Function(String) onSelected, options) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: options.length > 5 ? 5 : options.length,
                      itemBuilder: (context, index) {
                        final option = options.elementAt(index);

                        return Padding(
                          padding: const EdgeInsets.only(right: 95, left: 25),
                          child: Material(
                            elevation: 4,
                            child: ListTile(
                              visualDensity: const VisualDensity(vertical: 3),
                              title: Text(
                                option.toString()[0].toUpperCase() +
                                    option.toString().substring(1),
                                textScaleFactor: 1.0,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700),
                              ),
                              onTap: () {
                                setState(() {
                                  if (drug.contains(option) == false) {
                                    drug.add(option);
                                    controller.clear();
                                  } else {
                                    controller.clear();
                                  }
                                });
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  fieldViewBuilder:
                      (context, controller, focusNode, onEditingComplete) {
                    this.controller = controller;
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      onEditingComplete: onEditingComplete,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 15.0),
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
                          hintText: "Добавить препарат...",
                          hintStyle: const TextStyle(
                              color: Color.fromRGBO(13, 159, 130, 1.000)),
                          prefixIcon: const Icon(Icons.search,
                              size: 30,
                              color: Color.fromRGBO(13, 159, 130, 1.000)),
                          suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              color: const Color.fromRGBO(13, 159, 130, 1.000),
                              onPressed: () {
                                controller.clear();
                                FocusManager.instance.primaryFocus?.unfocus();
                              })),
                    );
                  },
                )),
                SizedBox(
                  width: 40,
                  child: RawMaterialButton(
                      shape: const CircleBorder(),
                      fillColor: const Color.fromRGBO(13, 159, 130, 1.000),
                      onPressed: () {
                        setState(() {
                          if (autoCompleteData
                              .contains(controller.text.toLowerCase())) {
                            if (drug.contains(controller.text.toLowerCase()) ==
                                false) {
                              drug.add(controller.text);
                              controller.clear();
                            } else {
                              controller.clear();
                            }
                          } else {
                            setState(() {
                              controller.clear();
                            });
                          }
                        });
                      },
                      child: const Icon(Icons.add)),
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (drug.length > 0) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'СПИСОК ПРЕПАРАТОВ:',
                              style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  color: Colors.teal.shade100,
                                  fontSize: 20.0,
                                  letterSpacing: 2.5,
                                  fontWeight: FontWeight.bold),
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
                    itemCount: drug.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          child: ListTile(
                        title: Text(drug[index][0].toUpperCase() +
                            drug[index].substring(1)),
                        trailing: TextButton(
                          onPressed: () {
                            setState(() {
                              drug.removeAt(index);
                            });
                            if (drug.length < 2) {
                              setState(() {
                                parameters = false;
                              });
                            }
                          },
                          child: const Icon(Icons.delete,
                              color: Color.fromARGB(255, 233, 22, 22)),
                        ),
                        onTap: () {
                          setState(() {
                            textController.text = drug[index];
                          });
                        },
                      ));
                    }),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                        child: Center(
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                if (globals.userInfoFinal[5] == 'specialist' &&
                                    drug.length > 1) {
                                  return OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero,
                                          ),
                                          backgroundColor: const Color.fromARGB(
                                              153, 207, 215, 252),
                                          minimumSize: const Size(100, 48)),
                                      onPressed: () {
                                        setState(() {
                                          if (parameters) {
                                            parameters = false;
                                          } else {
                                            parameters = true;
                                          }
                                        });
                                      },
                                      child: const Text(
                                        'Добавить параметры пациента',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ));
                                } else {
                                  return const SizedBox(
                                    height: 0.1,
                                  );
                                }
                              }),
                        ),
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (parameters) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 55,
                                    child: Card(
                                      shape: const RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: ListTile(
                                        // ignore: prefer_const_constructors
                                        leading: Icon(
                                          Icons.calendar_month_outlined,
                                          color: const Color.fromRGBO(
                                              13, 159, 130, 1.000),
                                          size: 30,
                                        ),
                                        title: TextField(
                                          controller: _controller1,
                                          keyboardType: TextInputType.number,
                                          style: const TextStyle(
                                              fontFamily: 'Source Sans Pro',
                                              fontSize: 15.0),
                                          decoration: const InputDecoration(
                                            hintText: 'Возраст...',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 55,
                                    child: Card(
                                      shape: const RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: ListTile(
                                        leading: const Icon(
                                          Icons.wc_rounded,
                                          color: Color.fromRGBO(
                                              13, 159, 130, 1.000),
                                          size: 30,
                                        ),
                                        trailing: DropdownButton<String>(
                                          // Step 3.
                                          value: dropdownValueType,
                                          dropdownColor: Colors.teal[200],

                                          // Step 4.
                                          items: <String>['Мужской', 'Женский']
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value));
                                          }).toList(),
                                          // Step 5.
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownValueType = newValue!;
                                            });
                                          },
                                        ),
                                        title: const Text(
                                          'Пол:',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  13, 159, 130, 1.000),
                                              fontFamily: 'Source Sans Pro',
                                              fontSize: 15.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 55,
                                    child: Card(
                                      shape: const RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: ListTile(
                                        // ignore: prefer_const_constructors
                                        leading: Icon(
                                          Icons.balance_rounded,
                                          color: const Color.fromRGBO(
                                              13, 159, 130, 1.000),
                                          size: 30,
                                        ),
                                        title: TextField(
                                          controller: _controller2,
                                          keyboardType: TextInputType.number,
                                          style: const TextStyle(
                                              fontFamily: 'Source Sans Pro',
                                              fontSize: 15.0),
                                          decoration: const InputDecoration(
                                            hintText: 'Вес(в кг)',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 60,
                                    child: Card(
                                      shape: const RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: ListTile(
                                        // ignore: prefer_const_constructors
                                        leading: Icon(
                                          Icons.height_rounded,
                                          color: const Color.fromRGBO(
                                              13, 159, 130, 1.000),
                                          size: 30,
                                        ),
                                        title: TextField(
                                          controller: _controller3,
                                          keyboardType: TextInputType.number,
                                          style: const TextStyle(
                                              fontFamily: 'Source Sans Pro',
                                              fontSize: 15.0),
                                          decoration: const InputDecoration(
                                            hintText: 'Рост(в см)',
                                          ),
                                        ),
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      dropdownValueType == 'Женский' ||
                              _controller1.text.isNotEmpty ||
                              _controller2.text.isNotEmpty ||
                              _controller3.text.isNotEmpty ||
                              drug.length >= 2
                          ? Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(100, 48),
                                    backgroundColor: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    _controller1.text = '';
                                    _controller2.text = '';
                                    _controller3.text = '';
                                    dropdownValueType == 'Мужской';
                                    parameters = false;
                                    drug.clear();
                                  });
                                },
                                child: const Text(
                                  "Очистить все",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(
                              height: 0.1,
                            ),
                      dropdownValueType == 'Женский' ||
                              _controller1.text.isNotEmpty ||
                              _controller2.text.isNotEmpty ||
                              _controller3.text.isNotEmpty ||
                              drug.length >= 2
                          ? const SizedBox(
                              width: 5,
                            )
                          : const SizedBox(
                              height: 0.1,
                            ),
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(100, 48)),
                            onPressed: (drug.length > 1)
                                ? () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return SecondPage(drug: drug);
                                    }));

                                    if (globals.userInfoFinal[5] == 'user') {
                                      QuickAlert.show(
                                          context: context,
                                          title: 'Важно!',
                                          confirmBtnText: "Понятно",
                                          barrierDismissible: true,
                                          type: QuickAlertType.warning,
                                          widget: ListBody(
                                            children: const [
                                              Text(
                                                'Информация носит рекомендательный характер. Поговорите со своим врачом или фармацевтом, если у вас есть какие-либо вопросы или опасения. Важно сообщить своему врачу обо всех других лекарствах, которые вы принимаете, включая витамины и травы. Не прекращайте прием каких-либо лекарств, предварительно не посоветовавшись со своим врачом',
                                                style: TextStyle(fontSize: 15),
                                              )
                                            ],
                                          ));
                                    }
                                  }
                                : null,
                            child: Text(
                              btntxt(),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  final List drug;

  const SecondPage({
    Key? key,
    required this.drug,
  }) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  var customTileExpanded = <double>[];
  var customTileExpanded2 = <double>[];
  var customTileExpanded3 = <double>[];
  var customTileExpanded4 = <double>[];
  var customTileExpanded5 = <double>[];

  late bool done;

  var fininteractionList = [];
  var findegree = [];
  var finmedDescription = [];
  var finconsDescription = [];
  var finreference = [];
  var finfoodinteractionList = [];
  var finfooddegree = [];
  var finfoodmedDescription = [];
  var finfoodconsDescription = [];
  var finfoodreference = [];
  var findivision = [];

  String user = globals.userInfoFinal[5];

  void awaiting() async {
    var allLists = await allListsFinalOutput(widget.drug);
    var foodallLists = await allListsFoodOutput(widget.drug);
    setState(() {
      fininteractionList = allLists[0];
      findegree = allLists[1];
      finmedDescription = allLists[2];
      finconsDescription = allLists[3];
      finreference = allLists[4];
      if (foodallLists != null) {
        finfoodinteractionList = foodallLists[0];
        finfooddegree = foodallLists[1];
        finfoodmedDescription = foodallLists[2];
        finfoodconsDescription = foodallLists[3];
        finfoodreference = foodallLists[4];
      } else {
        finfoodinteractionList = [];
        finfooddegree = [];
        finfoodmedDescription = [];
        finfoodconsDescription = [];
        finfoodreference = [];
      }
      findivision = allLists[5];
      done = true;
    });

    await catcher(widget.drug, globals.userInfoFinal);
  }

  @override
  void initState() {
    super.initState();
    awaiting();
    done = false;
  }

  @override
  Widget build(BuildContext context) {
    if (done) {
      for (var i = 0; i < findivision[0]; i++) {
        customTileExpanded.add(0.0);
      }
      for (var i = 0; i < findivision[1]; i++) {
        customTileExpanded2.add(0.0);
      }
      for (var i = 0; i < findivision[2]; i++) {
        customTileExpanded3.add(0.0);
      }
      for (var i = 0; i < finfoodinteractionList.length; i++) {
        customTileExpanded5.add(0.0);
      }
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text('Результат проверки'),
              actions: <Widget>[
                IconButton(
                  iconSize: 36,
                  icon: const Icon(
                    Icons.info,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  onPressed: () {
                    if (user == 'user') {
                      QuickAlert.show(
                          context: context,
                          title: 'Описание',
                          confirmBtnText: "Понятно",
                          barrierDismissible: true,
                          type: QuickAlertType.info,
                          widget: ListBody(
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  null;
                                },
                                icon: const Icon(
                                  Icons.warning_rounded,
                                  color: Color.fromARGB(255, 175, 39, 47),
                                  size: 40,
                                ),
                                label: const Text(
                                    'Смертельно опасно(красное): совместный прием лекарств может быть опасным для жизни'),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  null;
                                },
                                icon: const Icon(
                                  Icons.warning_rounded,
                                  color: Color.fromARGB(255, 255, 106, 57),
                                  size: 40,
                                ),
                                label: const Text(
                                    'Умеренно опасно(оранжевое): состояние здоровья при совместном приеме может ухудшиться'),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  null;
                                },
                                icon: const Icon(
                                  Icons.warning_rounded,
                                  color: Color.fromARGB(255, 255, 214, 145),
                                  size: 40,
                                ),
                                label: const Text(
                                    'Неопасно (желтое): эффект совместного приема незначительный и не представляет угрозу для здоровья'),
                              ),
                            ],
                          ));
                    } else {
                      QuickAlert.show(
                          context: context,
                          title: 'Описание',
                          confirmBtnText: "Понятно",
                          barrierDismissible: true,
                          type: QuickAlertType.info,
                          widget: ListBody(
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  null;
                                },
                                icon: const Icon(
                                  Icons.warning_rounded,
                                  color: Color.fromARGB(255, 175, 39, 47),
                                  size: 40,
                                ),
                                label: const Text(
                                    'Опасное взаимодействие (красное): Взаимодействие может быть опасным для жизни пациента'),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  null;
                                },
                                icon: const Icon(
                                  Icons.warning_rounded,
                                  color: Color.fromARGB(255, 255, 106, 57),
                                  size: 40,
                                ),
                                label: const Text(
                                    'Умеренное взаимодействие (оранжевое): Взаимодействие имеет клинически выраженный эффект, состояние пациента может ухудшиться'),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  null;
                                },
                                icon: const Icon(
                                  Icons.warning_rounded,
                                  color: Color.fromARGB(255, 255, 214, 145),
                                  size: 40,
                                ),
                                label: const Text(
                                    'Слабое взаимодействие(желтое): Взаимодействие имеет незначительный клинический эффект, но не представляет угрозу для здоровья пациента'),
                              ),
                            ],
                          ));
                    }
                  },
                )
              ],
            ),
            body: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: const Color.fromARGB(255, 233, 253, 246),
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0, right: 2),
                            child: ElevatedButton(
                              child: const Text('Специалист'),
                              onPressed: () {
                                setState(() {
                                  user = 'specialist';
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5.0, left: 2),
                            child: ElevatedButton(
                              child: const Text('Пользователь'),
                              onPressed: () {
                                setState(() {
                                  user = 'user';
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: SizedBox(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (findivision[0] != 0) {
                                      return Column(
                                        children: const [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 5.0),
                                              child: Text(
                                                'Опасные',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.teal),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: 5, left: 5),
                                              child: Divider(
                                                thickness: 2,
                                                color: Color.fromRGBO(
                                                    13, 159, 130, 1.000),
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
                                  });
                            },
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: findivision[0],
                            itemBuilder: (BuildContext context, int index) {
                              final interactionList = fininteractionList[index];
                              final reference = finreference[index];
                              final description;
                              if (user == 'user') {
                                description = finconsDescription[index];
                                return Card(
                                  child: ExpansionTile(
                                    leading: const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.warning_rounded,
                                        color: Color.fromARGB(255, 175, 39, 47),
                                        size: 40,
                                      ),
                                    ),
                                    title: Text(
                                        interactionList[0].toUpperCase() +
                                            interactionList.substring(1)),
                                    subtitle: const Text('Смертельно опасно'),
                                    trailing: AnimatedRotation(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      turns: customTileExpanded[index],
                                      child: const Icon(Icons.arrow_downward),
                                    ),
                                    children: <Widget>[
                                      ListTile(
                                          title: Text(
                                        description
                                            .replaceAll(RegExp(' +'), " ")
                                            .replaceAll("\t", "")
                                            .replaceAll("\f", "")
                                            .replaceAll("\r", "")
                                            .replaceAll("\n ", "\n")
                                            .replaceAll("\n", "\n\n")
                                            .trim(),
                                        textAlign: TextAlign.justify,
                                      )),
                                    ],
                                    onExpansionChanged: (bool expanded) {
                                      if (expanded == true) {
                                        setState(() =>
                                            customTileExpanded[index] += 0.5);
                                      } else {
                                        setState(() =>
                                            customTileExpanded[index] -= 0.5);
                                      }
                                    },
                                  ),
                                );
                              } else {
                                description = finmedDescription[index];
                                return Card(
                                  child: ExpansionTile(
                                    leading: const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.warning_rounded,
                                        color: Color.fromARGB(255, 175, 39, 47),
                                        size: 40,
                                      ),
                                    ),
                                    title: Text(
                                        interactionList[0].toUpperCase() +
                                            interactionList.substring(1)),
                                    subtitle:
                                        const Text('Опасное взаимодействие'),
                                    trailing: AnimatedRotation(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      turns: customTileExpanded[index],
                                      child: const Icon(Icons.arrow_downward),
                                    ),
                                    children: <Widget>[
                                      ExpansionTile(
                                        title: const Text('Описание'),
                                        children: [
                                          ListTile(
                                              title: Text(
                                            description
                                                .replaceAll(RegExp(' +'), " ")
                                                .replaceAll("\t", "")
                                                .replaceAll("\f", "")
                                                .replaceAll("\r", "")
                                                .replaceAll("\n ", "\n")
                                                .replaceAll("\n", "\n\n")
                                                .trim(),
                                            textAlign: TextAlign.justify,
                                          )),
                                        ],
                                      ),
                                      ExpansionTile(
                                        title: const Text('Литература'),
                                        children: [
                                          ListTile(
                                              title: Text(
                                            reference
                                                .replaceAll(RegExp(' +'), " ")
                                                .replaceAll("\t", "")
                                                .replaceAll("\f", "")
                                                .replaceAll("\r", "")
                                                .replaceAll("\n ", "\n")
                                                .replaceAll("\n", "\n\n")
                                                .trim(),
                                            textAlign: TextAlign.justify,
                                          )),
                                        ],
                                      ),
                                    ],
                                    onExpansionChanged: (bool expanded) {
                                      if (expanded == true) {
                                        setState(() =>
                                            customTileExpanded[index] += 0.5);
                                      } else {
                                        setState(() =>
                                            customTileExpanded[index] -= 0.5);
                                      }
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                if (findivision[1] != 0) {
                                  return Column(
                                    children: const [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 5.0),
                                          child: Text(
                                            'Умеренные',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.teal),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 5, left: 5),
                                          child: Divider(
                                            thickness: 2,
                                            color: Color.fromRGBO(
                                                13, 159, 130, 1.000),
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
                            itemCount: findivision[1],
                            itemBuilder: (BuildContext context, int index) {
                              var i = (index + findivision[0]).toInt();
                              final interactionList = fininteractionList[i];
                              final reference = finreference[i];
                              final description;
                              if (user == 'user') {
                                description = finconsDescription[i];
                                return Card(
                                  child: ExpansionTile(
                                    leading: const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.warning_rounded,
                                        color:
                                            Color.fromARGB(255, 255, 106, 57),
                                        size: 40,
                                      ),
                                    ),
                                    title: Text(
                                        interactionList[0].toUpperCase() +
                                            interactionList.substring(1)),
                                    subtitle: const Text('Умеренно опасно'),
                                    trailing: AnimatedRotation(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      turns: customTileExpanded2[index],
                                      child: const Icon(Icons.arrow_downward),
                                    ),
                                    children: <Widget>[
                                      ListTile(
                                          title: Text(
                                        description
                                            .replaceAll(RegExp(' +'), " ")
                                            .replaceAll("\t", "")
                                            .replaceAll("\f", "")
                                            .replaceAll("\r", "")
                                            .replaceAll("\n ", "\n")
                                            .replaceAll("\n", "\n\n")
                                            .trim(),
                                        textAlign: TextAlign.justify,
                                      )),
                                    ],
                                    onExpansionChanged: (bool expanded) {
                                      if (expanded == true) {
                                        setState(() =>
                                            customTileExpanded2[index] += 0.5);
                                      } else {
                                        setState(() =>
                                            customTileExpanded2[index] -= 0.5);
                                      }
                                    },
                                  ),
                                );
                              } else {
                                description = finmedDescription[i];
                                return Card(
                                  child: ExpansionTile(
                                    leading: const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.warning_rounded,
                                        color:
                                            Color.fromARGB(255, 255, 106, 57),
                                        size: 40,
                                      ),
                                    ),
                                    title: Text(
                                        interactionList[0].toUpperCase() +
                                            interactionList.substring(1)),
                                    subtitle:
                                        const Text('Умеренное взаимодействие'),
                                    trailing: AnimatedRotation(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      turns: customTileExpanded2[index],
                                      child: const Icon(Icons.arrow_downward),
                                    ),
                                    children: <Widget>[
                                      ExpansionTile(
                                        title: const Text('Описание'),
                                        children: [
                                          ListTile(
                                              title: Text(
                                            description
                                                .replaceAll(RegExp(' +'), " ")
                                                .replaceAll("\t", "")
                                                .replaceAll("\f", "")
                                                .replaceAll("\r", "")
                                                .replaceAll("\n ", "\n")
                                                .replaceAll("\n", "\n\n")
                                                .trim(),
                                            textAlign: TextAlign.justify,
                                          )),
                                        ],
                                      ),
                                      ExpansionTile(
                                        title: const Text('Литература'),
                                        children: [
                                          ListTile(
                                              title: Text(
                                            reference
                                                .replaceAll(RegExp(' +'), " ")
                                                .replaceAll("\t", "")
                                                .replaceAll("\f", "")
                                                .replaceAll("\r", "")
                                                .replaceAll("\n ", "\n")
                                                .replaceAll("\n", "\n\n")
                                                .trim(),
                                            textAlign: TextAlign.justify,
                                          )),
                                        ],
                                      ),
                                    ],
                                    onExpansionChanged: (bool expanded) {
                                      if (expanded == true) {
                                        setState(() =>
                                            customTileExpanded2[index] += 0.5);
                                      } else {
                                        setState(() =>
                                            customTileExpanded2[index] -= 0.5);
                                      }
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                if (findivision[2] != 0) {
                                  return Column(
                                    children: const [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 5.0),
                                          child: Text(
                                            'Слабые',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.teal),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 5, left: 5),
                                          child: Divider(
                                            thickness: 2,
                                            color: Color.fromRGBO(
                                                13, 159, 130, 1.000),
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
                            itemCount: findivision[2],
                            itemBuilder: (BuildContext context, int index) {
                              var i = (index + findivision[1] + findivision[0])
                                  .toInt();
                              final interactionList = fininteractionList[i];
                              final reference = finreference[i];
                              final description;
                              if (user == 'user') {
                                description = finconsDescription[i];
                                return Column(
                                  children: [
                                    Card(
                                      child: ExpansionTile(
                                        leading: const CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.warning_rounded,
                                            color: Color.fromARGB(
                                                255, 255, 214, 145),
                                            size: 40,
                                          ),
                                        ),
                                        title: Text(
                                            interactionList[0].toUpperCase() +
                                                interactionList.substring(1)),
                                        subtitle: const Text('Неопасно'),
                                        trailing: AnimatedRotation(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          turns: customTileExpanded3[index],
                                          child:
                                              const Icon(Icons.arrow_downward),
                                        ),
                                        children: <Widget>[
                                          ListTile(
                                              title: Text(
                                            description
                                                .replaceAll(RegExp(' +'), " ")
                                                .replaceAll("\t", "")
                                                .replaceAll("\f", "")
                                                .replaceAll("\r", "")
                                                .replaceAll("\n ", "\n")
                                                .replaceAll("\n", "\n\n")
                                                .trim(),
                                            textAlign: TextAlign.justify,
                                          )),
                                        ],
                                        onExpansionChanged: (bool expanded) {
                                          if (expanded == true) {
                                            setState(() =>
                                                customTileExpanded3[index] +=
                                                    0.5);
                                          } else {
                                            setState(() =>
                                                customTileExpanded3[index] -=
                                                    0.5);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                description = finmedDescription[i];
                                return Column(
                                  children: [
                                    Card(
                                      child: ExpansionTile(
                                        leading: const CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.warning_rounded,
                                            color: Color.fromARGB(
                                                255, 255, 214, 145),
                                            size: 40,
                                          ),
                                        ),
                                        title: Text(
                                            interactionList[0].toUpperCase() +
                                                interactionList.substring(1)),
                                        subtitle:
                                            const Text('Слабое взаимодействие'),
                                        trailing: AnimatedRotation(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          turns: customTileExpanded3[index],
                                          child:
                                              const Icon(Icons.arrow_downward),
                                        ),
                                        children: <Widget>[
                                          ExpansionTile(
                                            title: const Text('Описание'),
                                            children: [
                                              ListTile(
                                                  title: Text(
                                                description
                                                    .replaceAll(
                                                        RegExp(' +'), " ")
                                                    .replaceAll("\t", "")
                                                    .replaceAll("\f", "")
                                                    .replaceAll("\r", "")
                                                    .replaceAll("\n ", "\n")
                                                    .replaceAll("\n", "\n\n")
                                                    .trim(),
                                                textAlign: TextAlign.justify,
                                              )),
                                            ],
                                          ),
                                          ExpansionTile(
                                            title: const Text('Литература'),
                                            children: [
                                              ListTile(
                                                  title: Text(
                                                reference
                                                    .replaceAll(
                                                        RegExp(' +'), " ")
                                                    .replaceAll("\t", "")
                                                    .replaceAll("\f", "")
                                                    .replaceAll("\r", "")
                                                    .replaceAll("\n ", "\n")
                                                    .replaceAll("\n", "\n\n")
                                                    .trim(),
                                                textAlign: TextAlign.justify,
                                              )),
                                            ],
                                          ),
                                        ],
                                        onExpansionChanged: (bool expanded) {
                                          if (expanded == true) {
                                            setState(() =>
                                                customTileExpanded3[index] +=
                                                    0.5);
                                          } else {
                                            setState(() =>
                                                customTileExpanded3[index] -=
                                                    0.5);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (finfoodinteractionList.isNotEmpty) {
                                return Column(
                                  children: const [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          'Взаимодействия с пищей:',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.teal),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(right: 5, left: 5),
                                        child: Divider(
                                          thickness: 2,
                                          color: Color.fromRGBO(
                                              13, 159, 130, 1.000),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return const SizedBox(
                                  height: 1,
                                );
                              }
                            },
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: finfoodinteractionList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final interactionList =
                                  finfoodinteractionList[index];
                              var degree = finfooddegree[index];
                              var warningcolor;
                              final reference = finfoodreference[index];
                              final description;
                              if (user == 'user') {
                                if (degree == 'major') {
                                  degree = 'Смертельно опасно';
                                  warningcolor =
                                      const Color.fromARGB(255, 175, 39, 47);
                                } else if (degree == 'moderate') {
                                  degree = 'Умеренно опасно';
                                  warningcolor =
                                      const Color.fromARGB(255, 255, 106, 57);
                                } else if (degree == 'minor') {
                                  degree = 'Неопасно';
                                  warningcolor =
                                      const Color.fromARGB(255, 255, 214, 145);
                                }
                                description = finfoodconsDescription[index];
                                return Card(
                                  child: ExpansionTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.warning_rounded,
                                        color: warningcolor,
                                        size: 40,
                                      ),
                                    ),
                                    title: Text(
                                        interactionList[0].toUpperCase() +
                                            interactionList.substring(1)),
                                    subtitle: Text('$degree'),
                                    trailing: AnimatedRotation(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      turns: customTileExpanded5[index],
                                      child: const Icon(Icons.arrow_downward),
                                    ),
                                    children: <Widget>[
                                      ListTile(
                                          title: Text(
                                        description
                                            .replaceAll(RegExp(' +'), " ")
                                            .replaceAll("\t", "")
                                            .replaceAll("\f", "")
                                            .replaceAll("\r", "")
                                            .replaceAll("\n ", "\n")
                                            .replaceAll("\n", "\n\n")
                                            .trim(),
                                        textAlign: TextAlign.justify,
                                      )),
                                    ],
                                    onExpansionChanged: (bool expanded) {
                                      if (expanded == true) {
                                        setState(() =>
                                            customTileExpanded5[index] += 0.5);
                                      } else {
                                        setState(() =>
                                            customTileExpanded5[index] -= 0.5);
                                      }
                                    },
                                  ),
                                );
                              } else {
                                if (degree == 'major') {
                                  degree = 'Опасное взаимодействие';
                                  warningcolor =
                                      const Color.fromARGB(255, 175, 39, 47);
                                } else if (degree == 'moderate') {
                                  degree = 'Умеренное взаимодействие';
                                  warningcolor =
                                      const Color.fromARGB(255, 255, 106, 57);
                                } else if (degree == 'minor') {
                                  degree = 'Слабое взаимодействие';
                                  warningcolor =
                                      const Color.fromARGB(255, 255, 214, 145);
                                }
                                description = finfoodmedDescription[index];
                                return Card(
                                  child: ExpansionTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.warning_rounded,
                                        color: warningcolor,
                                        size: 40,
                                      ),
                                    ),
                                    title: Text(
                                        interactionList[0].toUpperCase() +
                                            interactionList.substring(1)),
                                    subtitle: Text('$degree'),
                                    trailing: AnimatedRotation(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      turns: customTileExpanded5[index],
                                      child: const Icon(Icons.arrow_downward),
                                    ),
                                    children: <Widget>[
                                      ExpansionTile(
                                        title: const Text('Описание'),
                                        children: [
                                          ListTile(
                                              title: Text(
                                            description
                                                .replaceAll(RegExp(' +'), " ")
                                                .replaceAll("\t", "")
                                                .replaceAll("\f", "")
                                                .replaceAll("\r", "")
                                                .replaceAll("\n ", "\n")
                                                .replaceAll("\n", "\n\n")
                                                .trim(),
                                            textAlign: TextAlign.justify,
                                          )),
                                        ],
                                      ),
                                      ExpansionTile(
                                        title: const Text('Литература'),
                                        children: [
                                          ListTile(
                                              title: Text(
                                            reference
                                                .replaceAll(RegExp(' +'), " ")
                                                .replaceAll("\t", "")
                                                .replaceAll("\f", "")
                                                .replaceAll("\r", "")
                                                .replaceAll("\n ", "\n")
                                                .replaceAll("\n", "\n\n")
                                                .trim(),
                                            textAlign: TextAlign.justify,
                                          )),
                                        ],
                                      ),
                                    ],
                                    onExpansionChanged: (bool expanded) {
                                      if (expanded == true) {
                                        setState(() =>
                                            customTileExpanded5[index] += 0.5);
                                      } else {
                                        setState(() =>
                                            customTileExpanded5[index] -= 0.5);
                                      }
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          home: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                  onPressed: () {
                    Navigator.pop(context);

                    // Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                  },
                ),
                title: const Text('Результат проверки'),
              ),
              body: const Center(child: CircularProgressIndicator()),
            ),
          ));
    }
  }

  listsOutput(bagOfItems, connection) async {
    var c = Permutations(2, bagOfItems);
    int totalCombinations = c.length.toInt();
    var rank = [];
    var degree = [];
    var interactionList = [];
    var medDescription = [];
    var consDescription = [];
    var reference = [];
    var division = [0, 0, 0];

    for (var i = 0; i < totalCombinations; i++) {
      //goes through each combination

      final wholeRow = await queryDrugs(connection, c[i][0], c[i][1]);
      if (wholeRow.isNotEmpty) {
        var queryDegreeResult = wholeRow[0][10];
        var queryMedDescriptionResult = wholeRow[0][6];
        var queryConsDescriptionResult = wholeRow[0][8];
        var queryReferenceResult = wholeRow[0][7];

        interactionList.add("${c[i][0]} - ${c[i][1]}");
        degree.add(queryDegreeResult);
        medDescription.add(queryMedDescriptionResult);
        consDescription.add(queryConsDescriptionResult);
        reference.add(queryReferenceResult);
        if (queryDegreeResult == 'major') {
          rank.add(1);
          division[0] = division[0] + 1;
        } else if (queryDegreeResult == 'moderate') {
          rank.add(2);
          division[1] = division[1] + 1;
        } else if (queryDegreeResult == 'minor') {
          rank.add(3);
          division[2] = division[2] + 1;
        }
      }
    }

    var combined = <Tuple6<int, String, String, String, String, String>>[
      for (var i = 0; i < degree.length; i += 1)
        Tuple6(rank[i], degree[i], interactionList[i], medDescription[i],
            consDescription[i], reference[i]),
    ];

    combined.sort((tuple1, tuple2) => tuple1.item1.compareTo(tuple2.item1));

    for (var i = 0; i < combined.length; i += 1) {
      rank[i] = combined[i].item1;
      degree[i] = combined[i].item2;
      interactionList[i] = combined[i].item3;
      medDescription[i] = combined[i].item4;
      consDescription[i] = combined[i].item5;
      reference[i] = combined[i].item6;
    }

    var allLists = [
      interactionList,
      degree,
      medDescription,
      consDescription,
      reference,
      division
    ];
    return allLists;
  }

  foodOutput(bagOfItems, connection) async {
    var rank = [];
    var degree = [];
    var interactionList = [];
    var medDescription = [];
    var consDescription = [];
    var reference = [];

    for (var i = 0; i < bagOfItems.length; i++) {
      var counted = await count(connection, bagOfItems[i]);
      var queryinteraction;
      var queryDegreeResult;
      var queryMedDescriptionResult;
      var queryConsDescriptionResult;
      var queryReferenceResult;
      for (var n = 0; n < counted; n++) {
        queryinteraction = await interaction(connection, bagOfItems[i], n);
        final wholeRow =
            await queryFood(connection, bagOfItems[i], queryinteraction);
        queryDegreeResult = wholeRow[0][10];
        queryMedDescriptionResult = wholeRow[0][6];
        queryConsDescriptionResult = wholeRow[0][8];
        queryReferenceResult = await wholeRow[0][7];

        if (queryDegreeResult != null) {
          interactionList.add("${bagOfItems[i]} - $queryinteraction");
          degree.add(queryDegreeResult);
          medDescription.add(queryMedDescriptionResult);
          consDescription.add(queryConsDescriptionResult);
          reference.add(queryReferenceResult);
          if (queryDegreeResult == 'major') {
            rank.add(1);
          } else if (queryDegreeResult == 'moderate') {
            rank.add(2);
          } else if (queryDegreeResult == 'minor') {
            rank.add(3);
          }
        }
      }
      //goes through each combination
    }

    var combined = <Tuple6<int, String, String, String, String, String>>[
      for (var i = 0; i < degree.length; i += 1)
        Tuple6(rank[i], degree[i], interactionList[i], medDescription[i],
            consDescription[i], reference[i]),
    ];

    combined.sort((tuple1, tuple2) => tuple1.item1.compareTo(tuple2.item1));

    for (var i = 0; i < combined.length; i += 1) {
      degree[i] = combined[i].item2;
      interactionList[i] = combined[i].item3;
      medDescription[i] = combined[i].item4;
      consDescription[i] = combined[i].item5;
      reference[i] = combined[i].item6;
    }

    var allLists = [
      interactionList,
      degree,
      medDescription,
      consDescription,
      reference,
    ];
    return allLists;
  }

  queryDrugs(connection, med1, med2) async {
    var result = await connection.query(
        "SELECT * FROM drugdrug WHERE LOWER(ru_0) = LOWER('$med1') AND LOWER(ru_1) = LOWER('$med2');");

    return result;
  }

  count(connection, med1) async {
    var result = await connection.query(
        "SELECT COUNT(food_ru) FROM drugfood WHERE LOWER(drug_ru) = LOWER('$med1');");

    for (final row in result) {
      return row[0];
      //result returns a _PostgreSQL Type. That's why we need to extract it
    }
  }

  interaction(connection, med1, n) async {
    var result = await connection.query(
        "SELECT food_ru FROM drugfood WHERE LOWER(drug_ru) = LOWER('$med1') LIMIT 1 OFFSET $n;");

    for (final row in result) {
      return row[0];
    }
  }

  queryFood(connection, med1, food1) async {
    var result = await connection.query(
        "SELECT * FROM drugfood WHERE LOWER(drug_ru) = LOWER('$med1') AND LOWER(food_ru) = LOWER('$food1');");

    return result;
  }

  allListsFoodOutput(medList) async {
    var connection = globals.connection();

    await connection.open();
    return await foodOutput(medList, connection);
  }

  allListsFinalOutput(medList) async {
    var connection = globals.connection();

    await connection.open();
    return await listsOutput(medList, connection);
  }

  catching(medList, userInfo, connection) async {
    await connection.execute(
        "INSERT INTO interactions (_email, _name, _surname, _city, _usertype, _drugs) VALUES ('${userInfo[0].toString()}', '${userInfo[2].toString()}', '${userInfo[3].toString()}', '${userInfo[4].toString()}', '${userInfo[5].toString()}', '$medList')");
  }

  catcher(medList, userInfo) async {
    var connection = globals.connection();

    await connection.open();
    await catching(medList, userInfo, connection);
  }
}
