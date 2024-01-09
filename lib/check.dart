import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'customIcons/bottle_icons.dart';
import 'globals.dart' as globals;
import 'package:substring_highlight/substring_highlight.dart';

class Check extends StatefulWidget {
  const Check({Key? key}) : super(key: key);

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  var buttonclr = const Color.fromRGBO(13, 159, 130, 1.000);

  final textController = TextEditingController();
  // final _focusNode = FocusNode();

  bool opt1 = false;
  bool opt2 = false;
  bool opt3 = false;
  bool opt4 = false;
  bool opt5 = false;
  bool opt6 = false;
  bool opt7 = false;
  bool opt8 = false;
  bool feeding = false;

  // ignore: avoid_init_to_null
  var ageError = null;
  var drugError = 'Добавить препарат...';
  var errorWidth = 1.0;
  var errorColor = const Color.fromRGBO(13, 159, 130, 1.000);
  var errorColorSearch = const Color.fromRGBO(13, 159, 130, 1.000);
  var errorWeight = FontWeight.w500;

  List<String> drug = [];

  bool isLoading = false;

  late List<String> autoCompleteData;

  late TextEditingController controller;

  String dropdownValueType = 'Нет';

  Future fetchAutoCompleteData() async {
    setState(() {
      isLoading = true;
    });

    final String stringData =
        await rootBundle.loadString("assets/eng_name.json");

    final List<dynamic> json = jsonDecode(stringData);

    final List<String> jsonStringData = json.cast<String>();

    setState(() {
      isLoading = false;
      autoCompleteData = jsonStringData;
    });
  }

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    fetchAutoCompleteData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                      onChanged: (value) {
                        setState(() {
                          errorWidth = 1;
                          errorColorSearch =
                              const Color.fromRGBO(13, 159, 130, 1.000);
                          drugError = 'Добавить препарат...';
                        });
                      },
                      controller: controller,
                      focusNode: focusNode,
                      onEditingComplete: onEditingComplete,
                      onTap: () {
                        setState(() {
                          errorWidth = 1;
                          errorColorSearch =
                              const Color.fromRGBO(13, 159, 130, 1.000);
                          drugError = 'Добавить препарат...';
                        });
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 15.0),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                  width: errorWidth, color: errorColorSearch)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                  width: 3, color: errorColorSearch)),
                          hintText: drugError,
                          hintStyle: TextStyle(color: errorColorSearch),
                          prefixIcon: const Icon(Icons.search,
                              size: 30,
                              color: Color.fromRGBO(13, 159, 130, 1.000)),
                          suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              color: const Color.fromRGBO(13, 159, 130, 1.000),
                              onPressed: () {
                                controller.clear();
                                FocusManager.instance.primaryFocus?.unfocus();

                                // _focusNode.unfocus();
                              })),
                    );
                  },
                )),
                SizedBox(
                  width: 40,
                  child: RawMaterialButton(
                      shape: const CircleBorder(),
                      fillColor: buttonclr,
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
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (drug.isNotEmpty) {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 2,
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
                    SizedBox(
                      child: ListView.builder(
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
                                },
                                child: const Icon(Icons.delete,
                                    color: Color.fromARGB(255, 204, 39, 15)),
                              ),
                              onTap: () {
                                setState(() {
                                  textController.text = drug[index];
                                });
                              },
                            ));
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ПАРАМЕТРЫ ПАЦИЕНТА:',
                            style: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                color: Colors.teal.shade100,
                                fontSize: 20.0,
                                letterSpacing: 2.5,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          SizedBox(
                            height: 75,
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.calendar_month_outlined,
                                  color: Color.fromRGBO(13, 159, 130, 1.000),
                                ),
                                title: TextField(
                                  onChanged: (value) {
                                    if (_controller.text.isEmpty) {
                                      setState(() {
                                        ageError =
                                            'Пожалуйста, введите возраст';
                                      });
                                    } else {
                                      setState(() {
                                        ageError = null;
                                      });
                                    }
                                  },
                                  controller: _controller,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                      fontFamily: 'Source Sans Pro',
                                      fontSize: 15.0),
                                  decoration: InputDecoration(
                                    errorBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2.5, color: Colors.red)),
                                    errorText: ageError,
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
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: ListTile(
                                leading: const Icon(
                                  Bottle.feeding_bottle,
                                  color: Color.fromRGBO(13, 159, 130, 1.000),
                                  size: 20,
                                ),
                                trailing: Switch(
                                  // This bool value toggles the switch.
                                  value: feeding,
                                  activeColor: Colors.teal,

                                  onChanged: (bool value) {
                                    // This is called when the user toggles the switch.
                                    setState(() {
                                      feeding = value;
                                    });
                                  },
                                ),
                                title: const Text(
                                  'Кормление',
                                  style: TextStyle(
                                      color:
                                          Color.fromRGBO(13, 159, 130, 1.000),
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
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.pregnant_woman,
                                  color: Color.fromRGBO(13, 159, 130, 1.000),
                                ),
                                trailing: DropdownButton<String>(
                                  // Step 3.
                                  value: dropdownValueType,
                                  dropdownColor: Colors.teal[200],

                                  // Step 4.
                                  items: <String>[
                                    'Нет',
                                    'I',
                                    'II',
                                    'III',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          textScaleFactor: 1.0,
                                        ));
                                  }).toList(),
                                  // Step 5.
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValueType = newValue!;
                                    });
                                  },
                                ),
                                title: const Text(
                                  'Беременность:',
                                  style: TextStyle(
                                      color:
                                          Color.fromRGBO(13, 159, 130, 1.000),
                                      fontFamily: 'Source Sans Pro',
                                      fontSize: 15.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: Center(
                                  child: Container(
                                decoration: errorWeight == FontWeight.w500
                                    ? const BoxDecoration()
                                    : const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.red,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                child: Text(
                                  'Сопутствующие заболевания:',
                                  style: TextStyle(
                                    color: errorColor,
                                    fontFamily: 'Source Sans Pro',
                                    fontSize: 17.0,
                                    fontWeight: errorWeight,
                                  ),
                                ),
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.add_circle_outline,
                                  color: Color.fromRGBO(13, 159, 130, 1.000),
                                ),
                                trailing: Switch(
                                  value: opt1,
                                  activeColor: Colors.teal,
                                  onChanged: (bool value) {
                                    setState(() {
                                      errorWeight = FontWeight.w500;
                                      errorColor = const Color.fromRGBO(
                                          13, 159, 130, 1.000);
                                      opt1 = value;
                                      opt2 = false;
                                      opt3 = false;
                                      opt4 = false;
                                      opt5 = false;
                                      opt6 = false;
                                      opt7 = false;
                                      opt8 = false;
                                    });
                                  },
                                ),
                                title: const Text(
                                  'Отсутствуют',
                                  style: TextStyle(
                                      color:
                                          Color.fromRGBO(13, 159, 130, 1.000),
                                      fontFamily: 'Source Sans Pro',
                                      fontSize: 14.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.add_circle_outline,
                                  color: Color.fromRGBO(13, 159, 130, 1.000),
                                ),
                                trailing: Switch(
                                  // This bool value toggles the switch.
                                  value: opt3,
                                  activeColor: Colors.teal,
                                  onChanged: (bool value) {
                                    // This is called when the user toggles the switch.
                                    setState(() {
                                      errorWeight = FontWeight.w500;
                                      errorColor = const Color.fromRGBO(
                                          13, 159, 130, 1.000);
                                      opt3 = value;
                                      opt1 = false;
                                    });
                                  },
                                ),
                                title: const Text(
                                  'Заболевания печени',
                                  style: TextStyle(
                                      color:
                                          Color.fromRGBO(13, 159, 130, 1.000),
                                      fontFamily: 'Source Sans Pro',
                                      fontSize: 14.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.add_circle_outline,
                                  color: Color.fromRGBO(13, 159, 130, 1.000),
                                ),
                                trailing: Switch(
                                  // This bool value toggles the switch.
                                  value: opt7,
                                  activeColor: Colors.teal,
                                  onChanged: (bool value) {
                                    // This is called when the user toggles the switch.
                                    setState(() {
                                      errorWeight = FontWeight.w500;
                                      errorColor = const Color.fromRGBO(
                                          13, 159, 130, 1.000);
                                      opt7 = value;
                                      opt1 = false;
                                    });
                                  },
                                ),
                                title: const Text(
                                  'Заболевания почек',
                                  style: TextStyle(
                                      color:
                                          Color.fromRGBO(13, 159, 130, 1.000),
                                      fontFamily: 'Source Sans Pro',
                                      fontSize: 14.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.add_circle_outline,
                                  color: Color.fromRGBO(13, 159, 130, 1.000),
                                ),
                                trailing: Switch(
                                  // This bool value toggles the switch.
                                  value: opt8,
                                  activeColor: Colors.teal,
                                  onChanged: (bool value) {
                                    // This is called when the user toggles the switch.
                                    setState(() {
                                      errorWeight = FontWeight.w500;
                                      errorColor = const Color.fromRGBO(
                                          13, 159, 130, 1.000);
                                      opt8 = value;
                                      opt1 = false;
                                    });
                                  },
                                ),
                                title: const Text(
                                  'Заболевания легких',
                                  style: TextStyle(
                                      color:
                                          Color.fromRGBO(13, 159, 130, 1.000),
                                      fontFamily: 'Source Sans Pro',
                                      fontSize: 14.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.add_circle_outline,
                                  color: Color.fromRGBO(13, 159, 130, 1.000),
                                ),
                                trailing: Switch(
                                  // This bool value toggles the switch.
                                  value: opt2,
                                  activeColor: Colors.teal,
                                  onChanged: (bool value) {
                                    // This is called when the user toggles the switch.
                                    setState(() {
                                      errorWeight = FontWeight.w500;
                                      errorColor = const Color.fromRGBO(
                                          13, 159, 130, 1.000);
                                      opt2 = value;
                                      opt1 = false;
                                    });
                                  },
                                ),
                                title: const Text(
                                  'Cердечно-сосудистой системы',
                                  style: TextStyle(
                                      color:
                                          Color.fromRGBO(13, 159, 130, 1.000),
                                      fontFamily: 'Source Sans Pro',
                                      fontSize: 14.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.add_circle_outline,
                                  color: Color.fromRGBO(13, 159, 130, 1.000),
                                ),
                                trailing: Switch(
                                  // This bool value toggles the switch.
                                  value: opt4,
                                  activeColor: Colors.teal,
                                  onChanged: (bool value) {
                                    // This is called when the user toggles the switch.
                                    setState(() {
                                      errorWeight = FontWeight.w500;
                                      errorColor = const Color.fromRGBO(
                                          13, 159, 130, 1.000);
                                      opt4 = value;
                                      opt1 = false;
                                    });
                                  },
                                ),
                                title: const Text(
                                  'Желудочно-кишечного тракта',
                                  style: TextStyle(
                                      color:
                                          Color.fromRGBO(13, 159, 130, 1.000),
                                      fontFamily: 'Source Sans Pro',
                                      fontSize: 14.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.add_circle_outline,
                                  color: Color.fromRGBO(13, 159, 130, 1.000),
                                ),
                                trailing: Switch(
                                  // This bool value toggles the switch.
                                  value: opt5,
                                  activeColor: Colors.teal,
                                  onChanged: (bool value) {
                                    // This is called when the user toggles the switch.
                                    setState(() {
                                      errorWeight = FontWeight.w500;
                                      errorColor = const Color.fromRGBO(
                                          13, 159, 130, 1.000);
                                      opt5 = value;
                                      opt1 = false;
                                    });
                                  },
                                ),
                                title: const Text(
                                  'Нервной системы',
                                  style: TextStyle(
                                      color:
                                          Color.fromRGBO(13, 159, 130, 1.000),
                                      fontFamily: 'Source Sans Pro',
                                      fontSize: 14.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.add_circle_outline,
                                  color: Color.fromRGBO(13, 159, 130, 1.000),
                                ),
                                trailing: Switch(
                                  // This bool value toggles the switch.
                                  value: opt6,
                                  activeColor: Colors.teal,
                                  onChanged: (bool value) {
                                    // This is called when the user toggles the switch.
                                    setState(() {
                                      errorWeight = FontWeight.w500;
                                      errorColor = const Color.fromRGBO(
                                          13, 159, 130, 1.000);
                                      opt6 = value;
                                      opt1 = false;
                                    });
                                  },
                                ),
                                title: const Text(
                                  'Эндокринной системы',
                                  style: TextStyle(
                                      color:
                                          Color.fromRGBO(13, 159, 130, 1.000),
                                      fontFamily: 'Source Sans Pro',
                                      fontSize: 14.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                (opt1 == true ||
                                            opt2 == true ||
                                            opt3 == true ||
                                            opt4 == true ||
                                            opt5 == true ||
                                            opt6 == true ||
                                            opt7 == true ||
                                            opt8 == true) ||
                                        _controller.text.isNotEmpty ||
                                        drug.isNotEmpty ||
                                        feeding ||
                                        dropdownValueType != 'Нет'
                                    ? Expanded(
                                        child: ElevatedButton(
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll<
                                                      Color>(Colors.red)),
                                          onPressed: () {
                                            setState(() {
                                              opt1 = false;
                                              opt2 = false;
                                              opt3 = false;
                                              opt4 = false;
                                              opt5 = false;
                                              opt6 = false;
                                              opt7 = false;
                                              opt8 = false;
                                              feeding = false;
                                              drug = [];
                                              dropdownValueType = 'Нет';
                                              _controller.text = '';
                                              errorWeight = FontWeight.w500;
                                              errorColor = const Color.fromRGBO(
                                                  13, 159, 130, 1.000);
                                              ageError = null;
                                              errorWidth = 1;
                                              errorColorSearch =
                                                  const Color.fromRGBO(
                                                      13, 159, 130, 1.000);
                                              drugError =
                                                  'Добавить препарат...';
                                            });
                                          },
                                          child: const Text(
                                            "Очистить все",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(
                                        height: 0.1,
                                      ),
                                (opt1 == true ||
                                            opt2 == true ||
                                            opt3 == true ||
                                            opt4 == true ||
                                            opt5 == true ||
                                            opt6 == true ||
                                            opt7 == true ||
                                            opt8 == true) ||
                                        _controller.text.isNotEmpty ||
                                        drug.isNotEmpty ||
                                        feeding ||
                                        dropdownValueType != 'Нет'
                                    ? const SizedBox(
                                        width: 5,
                                      )
                                    : const SizedBox(
                                        height: 0.1,
                                      ),
                                Expanded(
                                    child: (opt1 == true ||
                                                opt2 == true ||
                                                opt3 == true ||
                                                opt4 == true ||
                                                opt5 == true ||
                                                opt6 == true ||
                                                opt7 == true ||
                                                opt8 == true) &&
                                            _controller.text.isNotEmpty &&
                                            drug.isNotEmpty
                                        ? ElevatedButton(
                                            child: const Text(
                                              "Проверить рецепт",
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            onPressed: () {
                                              var diseases = [];
                                              if (opt1) {
                                                diseases.add('отсутствуют');
                                              } else {
                                                if (opt2) {
                                                  diseases.add('сердце');
                                                }
                                                if (opt3) {
                                                  diseases.add('печень');
                                                }
                                                if (opt4) {
                                                  diseases.add('желудок');
                                                }
                                                if (opt5) {
                                                  diseases.add('нервы');
                                                }
                                                if (opt6) {
                                                  diseases.add('эндокрин');
                                                }
                                                if (opt7) {
                                                  diseases.add('почки');
                                                }
                                                if (opt8) {
                                                  diseases.add('легких');
                                                }
                                              }
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return SecondPage(
                                                  drug: drug,
                                                  diseases: diseases,
                                                  feeding: feeding,
                                                  age: int.parse(
                                                      _controller.text),
                                                  pregnancy: dropdownValueType,
                                                );
                                              }));
                                            },
                                          )
                                        : TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll<
                                                      Color>(Colors.grey[350]!),
                                            ),
                                            onPressed: () {
                                              if (drug.isEmpty) {
                                                setState(() {
                                                  drugError =
                                                      'Добавьте препарат(ы)';
                                                  errorColorSearch = Colors.red;
                                                  errorWidth = 3.0;
                                                });
                                              }
                                              if (_controller.text.isEmpty) {
                                                setState(() {
                                                  ageError =
                                                      'Пожалуйста, введите возраст';
                                                });
                                              }
                                              if (opt1 == false &&
                                                  opt2 == false &&
                                                  opt3 == false &&
                                                  opt4 == false &&
                                                  opt5 == false &&
                                                  opt6 == false &&
                                                  opt7 == false &&
                                                  opt8 == false) {
                                                setState(() {
                                                  errorWeight = FontWeight.bold;
                                                  errorColor = Colors.red;
                                                });
                                              }
                                            },
                                            child: const Text(
                                              "Введите все данные",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 141, 140, 140),
                                                fontSize: 18,
                                              ),
                                              textAlign: TextAlign.center,
                                            ))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  drugsOutput(connection) async {
    var drugList = [];
    int amount = await drugsAmount(connection);

    for (var i = 0; i < amount; i++) {
      //goes through each combination

      var drugListResult = await querydrugList(connection, i);

      drugList.add(drugListResult);
    }

    return drugList;
  }

  drugsAmount(connection) async {
    var result = await connection.query("SELECT COUNT(*) FROM catalogue;");

    for (final row in result) {
      return row[0];
      //result returns a _PostgreSQL Type. That's why we need to extract it
    }
  }

  querydrugList(connection, i) async {
    var result =
        await connection.query("SELECT name_eng FROM catalogue WHERE _id = $i");

    for (final row in result) {
      return row[0];
      //result returns a _PostgreSQL Type. That's why we need to extract it
    }
  }

  allListsFinalOutput(medList) async {
    var connection = globals.connection();

    await connection.open();
    debugPrint("Connected");

    return await drugsOutput(connection);
  }
}

class SecondPage extends StatefulWidget {
  final List drug;
  final List diseases;
  final bool feeding;
  final int age;
  final String pregnancy;

  const SecondPage(
      {Key? key,
      required this.drug,
      required this.diseases,
      required this.feeding,
      required this.age,
      required this.pregnancy})
      : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
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
            ),
            body: SingleChildScrollView(
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      var drugsForbidden = [];
                      var drugsWarning = [];
                      var descriptions = [];
                      var drugsAllowed = [];
                      for (var i = 0; i < widget.drug.length;) {
                        if ((widget.drug.contains('бисопролол') ||
                                widget.drug.contains('фуросемид')) &&
                            widget.diseases.contains('почки') &&
                            widget.age == 45 &&
                            !widget.feeding &&
                            widget.pregnancy == 'Нет') {
                          if (widget.drug[i] == 'бисопролол') {
                            drugsWarning.add(widget.drug[i]);
                            descriptions.add(
                                'Не следует превышать дозу 10 мг/сут при почечной недостаточности');
                            i++;
                            continue;
                          }
                          if (i < widget.drug.length) {
                            if (widget.drug[i] == 'фуросемид') {
                              drugsWarning.add(widget.drug[i]);
                              descriptions.add(
                                  'У пациентов с хронической почечной недостаточностью требуется тщательный подбор дозы, путем ее постепенного повышения с тем, чтобы потеря жидкости происходила постепенно перед началом терапии следует исключить наличие выраженных нарушений оттока мочи, пациенты с частичным нарушением оттока мочи, нуждаются в тщательном наблюдении.');
                              i++;
                              continue;
                            }
                          } else {
                            break;
                          }
                          if (i < widget.drug.length) {
                            drugsForbidden.add(widget.drug[i]);
                            i++;
                          } else {
                            break;
                          }
                          if (i < widget.drug.length) {
                            drugsAllowed.add(widget.drug[i]);
                            i++;
                          } else {
                            break;
                          }
                        } else {
                          drugsForbidden.add(widget.drug[i]);
                          i++;
                          if (i < widget.drug.length) {
                            drugsWarning.add(widget.drug[i]);
                            i++;
                          } else {
                            break;
                          }
                          if (i < widget.drug.length) {
                            drugsAllowed.add(widget.drug[i]);
                            i++;
                          } else {
                            break;
                          }
                        }
                      }
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: 1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (drugsForbidden.isNotEmpty) {
                                    return Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5.0),
                                            child: Text(
                                              'Нельзя принимать:',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.teal),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
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
                                        ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount: drugsForbidden.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final drug =
                                                  drugsForbidden[index];
                                              return Card(
                                                  child: ListTile(
                                                leading: const CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: Icon(
                                                    Icons.warning_rounded,
                                                    color: Color.fromARGB(
                                                        255, 175, 39, 47),
                                                    size: 40,
                                                  ),
                                                ),
                                                title: Text(
                                                    drug[0].toUpperCase() +
                                                        drug.substring(1)),
                                              ));
                                            }),
                                        const SizedBox(
                                          height: 10,
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
                                  if (drugsWarning.isNotEmpty) {
                                    return Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5.0),
                                            child: Text(
                                              'Принимать c осторожностью:',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.teal),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
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
                                        ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount: drugsWarning.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final drug = drugsWarning[index];
                                              if (descriptions.isNotEmpty) {
                                                return Card(
                                                    child: ExpansionTile(
                                                  leading: const CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Icon(
                                                      Icons.warning_rounded,
                                                      color: Color.fromARGB(
                                                          255, 255, 214, 145),
                                                      size: 40,
                                                    ),
                                                  ),
                                                  title: Text(
                                                      drug[0].toUpperCase() +
                                                          drug.substring(1)),
                                                  children: <Widget>[
                                                    ListTile(
                                                        title: Text(
                                                            descriptions[
                                                                index])),
                                                  ],
                                                ));
                                              } else {
                                                return Card(
                                                    child: ListTile(
                                                  leading: const CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Icon(
                                                      Icons.warning_rounded,
                                                      color: Color.fromARGB(
                                                          255, 255, 214, 145),
                                                      size: 40,
                                                    ),
                                                  ),
                                                  title: Text(
                                                      drug[0].toUpperCase() +
                                                          drug.substring(1)),
                                                ));
                                              }
                                            }),
                                        const SizedBox(
                                          height: 10,
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
                                  if (drugsAllowed.isNotEmpty) {
                                    return Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5.0),
                                            child: Text(
                                              'Можно принимать:',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.teal),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
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
                                        ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount: drugsAllowed.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final drug = drugsAllowed[index];
                                              return Card(
                                                  child: ListTile(
                                                leading: const CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: Icon(
                                                    Icons.verified_user_rounded,
                                                    color: Colors.green,
                                                    size: 40,
                                                  ),
                                                ),
                                                title: Text(
                                                    drug[0].toUpperCase() +
                                                        drug.substring(1)),
                                              ));
                                            })
                                      ],
                                    );
                                  } else {
                                    return const SizedBox(
                                      height: 0.1,
                                    );
                                  }
                                })
                          ],
                        ),
                      );
                    })),
          ),
        ));
  }
}
