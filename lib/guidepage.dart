import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'globals.dart' as globals;

// import 'package:alphabet_list_scroll/_view/alphabet_list_scroll_view.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  var ifoneDrug = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
  var customTileExpanded = <double>[];
  var customTileExpandedX = <double>[];
  var customTileExpandedX00 = <double>[];
  var customTileExpandedX00X = <double>[];
  var customTileExpandedX00XX = <double>[];
  var usertype = globals.userInfoFinal[5];
  bool iExpanded = false;
  var finalAmount = 0;
  var splittedgroup = [];
  var splitteddrugList = [];
  var splittedpd = [];
  var splittedpk = [];
  var splittedindications = [];
  var splittedsideEffects = [];
  var splittedcontraIndications = [];
  var splittedpregnancy = [];
  var splittedliver = [];
  var splittedkidney = [];
  var splittedchildren = [];
  var splittedelders = [];
  var splittednotice = [];
  var splittedoverdose = [];
  var drugList = [];
  var group = [];
  var pd = [];
  var pk = [];
  var indications = [];
  var sideEffects = [];
  var contraIndications = [];
  var pregnancy = [];
  var liver = [];
  var kidney = [];
  var children = [];
  var elders = [];
  var notice = [];
  var overdose = [];

  var qdrugList = [];
  var qgroup = [];
  var qpd = [];
  var qpk = [];
  var qindications = [];
  var qsideEffects = [];
  var qcontraIndications = [];
  var qpregnancy = [];
  var qliver = [];
  var qkidney = [];
  var qchildren = [];
  var qelders = [];
  var qnotice = [];
  var qoverdose = [];
  List openTiles = [];
  bool separated = false;

  final textController = TextEditingController();

  bool isLoading = false;

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

    setState(() {
      isLoading = false;
      autoCompleteData = jsonStringData;
    });
  }

  late bool done;

  void awaiting() async {
    final allLists = await allListsFinalOutput();
    setState(() {
      drugList = allLists[0];
      group = allLists[1];
      pd = allLists[2];
      pk = allLists[3];
      indications = allLists[4];
      sideEffects = allLists[5];
      contraIndications = allLists[6];
      pregnancy = allLists[7];
      liver = allLists[8];
      kidney = allLists[9];
      children = allLists[10];
      elders = allLists[11];
      notice = allLists[12];
      overdose = allLists[13];
      done = true;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAutoCompleteData();
    awaiting();
    done = false;
  }

  @override
  Widget build(BuildContext context) {
    if (done) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },       child: Scaffold(
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
                                    finalAmount = 1;
                                    for (var i = 0; i < drugList.length; i++) {
                                      if (option.toLowerCase() ==
                                          drugList[i].toLowerCase()) {
                                        customTileExpanded = [0.0];
                                        ifoneDrug[0] = drugList[i];
                                        ifoneDrug[1] = group[i];
                                        ifoneDrug[2] = pd[i];
                                        ifoneDrug[3] = pk[i];
                                        ifoneDrug[4] = indications[i];
                                        ifoneDrug[5] = sideEffects[i];
                                        ifoneDrug[6] = contraIndications[i];
                                        ifoneDrug[7] = pregnancy[i];
                                        ifoneDrug[8] = liver[i];
                                        ifoneDrug[9] = kidney[i];
                                        ifoneDrug[10] = children[i];
                                        ifoneDrug[11] = elders[i];
                                        ifoneDrug[12] = notice[i];
                                        ifoneDrug[13] = overdose[i];
                                        break;
                                      }
                                    }
                                    controller.clear();
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
                            hintText: "Название препарата...",
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

                                  // _focusNode.unfocus();
                                })),
                      );
                    },
                  )),
                  SizedBox(
                    width: 40,
                    child: RawMaterialButton(
                        shape: const CircleBorder(),
                        fillColor: finalAmount != 1
                            ? const Color.fromRGBO(13, 159, 130, 1.000)
                            : Colors.red,
                        onPressed: () {
                          if (finalAmount == 1) {
                            setState(() {
                              customTileExpanded[0] = 0.0;
                            });
                            if (usertype == 'specialist') {
                              setState(() {
                                finalAmount = qdrugList.length;
                                controller.clear();
                              });
                            } else {
                              setState(() {
                                finalAmount = drugList.length;
                                controller.clear();
                              });
                            }
                          } else {
                            if (autoCompleteData
                                .contains(controller.text.toLowerCase())) {
                              setState(() {
                                finalAmount = 1;
                                for (var i = 0; i < drugList.length; i++) {
                                  if (controller.text.toLowerCase() ==
                                      drugList[i].toLowerCase()) {
                                    customTileExpanded = [0.0];
                                    ifoneDrug[0] = drugList[i];
                                    ifoneDrug[1] = group[i];
                                    ifoneDrug[2] = pd[i];
                                    ifoneDrug[3] = pk[i];
                                    ifoneDrug[4] = indications[i];
                                    ifoneDrug[5] = sideEffects[i];
                                    ifoneDrug[6] = contraIndications[i];
                                    ifoneDrug[7] = pregnancy[i];
                                    ifoneDrug[8] = liver[i];
                                    ifoneDrug[9] = kidney[i];
                                    ifoneDrug[10] = children[i];
                                    ifoneDrug[11] = elders[i];
                                    ifoneDrug[12] = notice[i];
                                    ifoneDrug[13] = overdose[i];
                                    break;
                                  }
                                }
                                controller.clear();
                              });
                            }
                          }
                        },
                        child: Icon(
                          finalAmount != 1 ? Icons.add : Icons.arrow_back,
                        )),
                  )
                ],
              ),
            ),
            body: Stack(
              children: [
                Positioned(
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
                                customTileExpanded = [];
                                usertype = 'specialist';
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
                                customTileExpanded = [];
                                usertype = 'user';
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (usertype == 'specialist') {
                              if (finalAmount != 1) {
                                qgroup = [];
                                qdrugList = [];
                                qpd = [];
                                qpk = [];
                                qindications = [];
                                qsideEffects = [];
                                qcontraIndications = [];
                                qpregnancy = [];
                                qliver = [];
                                qkidney = [];
                                qchildren = [];
                                qelders = [];
                                qnotice = [];
                                qoverdose = [];
                                qgroup.addAll(group);
                                qdrugList.addAll(drugList);
                                qpd.addAll(pd);
                                qpk.addAll(pk);
                                qindications.addAll(indications);
                                qsideEffects.addAll(sideEffects);
                                qcontraIndications.addAll(contraIndications);
                                qpregnancy.addAll(pregnancy);
                                qliver.addAll(liver);
                                qkidney.addAll(kidney);
                                qchildren.addAll(children);
                                qelders.addAll(elders);
                                qnotice.addAll(notice);
                                qoverdose.addAll(overdose);
                                if (!separated) {
                                  for (var i = 0; i < qgroup.length; i++) {
                                    var groupTemp = qgroup[i].split(',');
                                    if (groupTemp.length > 1) {
                                      qgroup[i] =
                                          "${groupTemp[0]},${groupTemp[1]}";
                                      splitteddrugList.add(drugList[i]);
                                      splittedgroup
                                          .add("${groupTemp[1]},${groupTemp[0]}");
                                      splittedpd.add(qpd[i]);
                                      splittedpk.add(qpk[i]);
                                      splittedindications.add(qindications[i]);
                                      splittedsideEffects.add(qsideEffects[i]);
                                      splittedcontraIndications
                                          .add(qcontraIndications[i]);
                                      splittedpregnancy.add(qpregnancy[i]);
                                      splittedliver.add(qliver[i]);
                                      splittedkidney.add(qkidney[i]);
                                      splittedchildren.add(qchildren[i]);
                                      splittedelders.add(qelders[i]);
                                      splittednotice.add(qnotice[i]);
                                      splittedoverdose.add(qoverdose[i]);
                                    }
                                  }
                                  separated = true;
                                }
                                qgroup.addAll(splittedgroup);
                                qdrugList.addAll(splitteddrugList);
                                qpd.addAll(splittedpd);
                                qpk.addAll(splittedpk);
                                qindications.addAll(splittedindications);
                                qsideEffects.addAll(splittedsideEffects);
                                qcontraIndications
                                    .addAll(splittedcontraIndications);
                                qpregnancy.addAll(splittedpregnancy);
                                qliver.addAll(splittedliver);
                                qkidney.addAll(splittedkidney);
                                qchildren.addAll(splittedchildren);
                                qelders.addAll(splittedelders);
                                qnotice.addAll(splittednotice);
                                qoverdose.addAll(splittedoverdose);
        
                                int rows = qgroup.length, columns = 15;
                                List<List<String>> twoDimensionalArray =
                                    List.generate(rows, (row) {
                                  return List.generate(columns, (col) => '');
                                });
                                for (var i = 0; i < qgroup.length; i += 1) {
                                  twoDimensionalArray[i][0] = qgroup[i];
                                  twoDimensionalArray[i][1] = qdrugList[i];
                                  twoDimensionalArray[i][2] = qpd[i];
                                  twoDimensionalArray[i][3] = qpk[i];
                                  twoDimensionalArray[i][4] = qindications[i];
                                  twoDimensionalArray[i][5] = qsideEffects[i];
                                  twoDimensionalArray[i][6] =
                                      qcontraIndications[i];
                                  twoDimensionalArray[i][7] = qpregnancy[i];
                                  twoDimensionalArray[i][8] = qliver[i];
                                  twoDimensionalArray[i][9] = qkidney[i];
                                  twoDimensionalArray[i][10] = qchildren[i];
                                  twoDimensionalArray[i][11] = qelders[i];
                                  twoDimensionalArray[i][12] = qnotice[i];
                                  twoDimensionalArray[i][13] = qoverdose[i];
                                }
        
                                twoDimensionalArray
                                    .sort((a, b) => a[0].compareTo(b[0]));
        
                                for (var i = 0;
                                    i < twoDimensionalArray.length;
                                    i += 1) {
                                  qgroup[i] = twoDimensionalArray[i][0];
                                  qdrugList[i] = twoDimensionalArray[i][1];
                                  qpd[i] = twoDimensionalArray[i][2];
                                  qpk[i] = twoDimensionalArray[i][3];
                                  qindications[i] = twoDimensionalArray[i][4];
                                  qsideEffects[i] = twoDimensionalArray[i][5];
                                  qcontraIndications[i] =
                                      twoDimensionalArray[i][6];
                                  qpregnancy[i] = twoDimensionalArray[i][7];
                                  qliver[i] = twoDimensionalArray[i][8];
                                  qkidney[i] = twoDimensionalArray[i][9];
                                  qchildren[i] = twoDimensionalArray[i][10];
                                  qelders[i] = twoDimensionalArray[i][11];
                                  qnotice[i] = twoDimensionalArray[i][12];
                                  qoverdose[i] = twoDimensionalArray[i][13];
                                }
        
                                finalAmount = qdrugList.length;
                              }
                              if (customTileExpanded.length < qdrugList.length) {
                                for (var i = 0; i < qdrugList.length; i++) {
                                  customTileExpanded.add(0.0);
                                }
                              }
                              var letters = [];
                              var letters2 = [];
                              var letters3 = [];
                              var letters4 = [];
                              String listTileText(index) {
                                if (qgroup[index][0] == 'A') {
                                  return 'Пищеварительный тракт и обмен веществ';
                                } else if (qgroup[index][0] == 'B') {
                                  return 'Препараты, влияющие на кроветворение и кровь';
                                } else if (qgroup[index][0] == 'C') {
                                  return 'Для лечения заболеваний сердечно-сосудистой системы';
                                } else if (qgroup[index][0] == 'D') {
                                  return 'Препараты для лечения заболеваний кожи';
                                } else if (qgroup[index][0] == 'G') {
                                  return 'Против заболеваний урогенитальных органов и половые гормоны';
                                } else if (qgroup[index][0] == 'H') {
                                  return 'Гормональные препараты для системного использования';
                                } else if (qgroup[index][0] == 'J') {
                                  return 'Противомикробные препараты для системного использования';
                                } else if (qgroup[index][0] == 'L') {
                                  return 'Противоопухолевые препараты и иммуномодуляторы';
                                } else if (qgroup[index][0] == 'M') {
                                  return 'Для лечения заболеваний костно-мышечной системы';
                                } else if (qgroup[index][0] == 'N') {
                                  return 'Препараты для лечения заболеваний нервной системы';
                                } else if (qgroup[index][0] == 'P') {
                                  return 'Противопаразитарные препараты, инсектициды и репелленты';
                                } else if (qgroup[index][0] == 'R') {
                                  return 'Для лечения заболеваний респираторной системы';
                                } else if (qgroup[index][0] == 'S') {
                                  return 'Для лечения заболеваний органов чувств';
                                } else {
                                  return 'Прочие лекарственные препараты';
                                }
                              }
        
                              String listTileText2(index) {
                                if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'A01') {
                                  return 'Стоматологические препараты';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'A02') {
                                  return 'Препараты для лечения заболеваний, связанных с нарушением кислотности';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'A03') {
                                  return ' Препараты для лечения функциональных расстройств ЖКТ';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'A04') {
                                  return 'Противорвотные препараты';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'A05') {
                                  return 'Препараты для лечения заболеваний печени и желчевыводящих путей';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'A06') {
                                  return 'Слабительные препараты';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'A07') {
                                  return 'Противодиарейные, кишечные противовоспалительные и противомикробные препараты';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'A08') {
                                  return 'Препараты для лечения ожирения (исключая диетические продукты)';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'A09') {
                                  return 'Препараты, способствующие пищеварению (включая ферменты)';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'A10') {
                                  return 'Препараты для лечения сахарного диабета';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'A11') {
                                  return 'Витамины';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] == 'A12') {
                                  return 'Минеральные добавки';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] == 'A13') {
                                  return 'Общетонизирующие препараты';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] == 'A14') {
                                  return 'Анаболические средства для системного применения';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] == 'A15') {
                                  return 'Стимуляторы аппетита';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] == 'A16') {
                                  return 'Прочие препараты для лечения заболеваний ЖКТ и нарушений обмена веществ';
                                } //_B_
                                else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'B01') {
                                  return 'Антитромботические средства';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'B02') {
                                  return 'Гемостатические средства';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'B03') {
                                  return 'Антианемические препараты';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'B05') {
                                  return 'Кровезаменители и перфузионные растворы';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'B06') {
                                  return 'Прочие гематологические препараты';
                                } //_C_
                                else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'C01') {
                                  return 'Препараты для лечения заболеваний сердца';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'C02') {
                                  return 'Антигипертензивные средства';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'C03') {
                                  return 'Диуретики';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'C04') {
                                  return 'Периферические вазодилататоры';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'C05') {
                                  return 'Ангиопротекторы';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'C07') {
                                  return 'Бета-адреноблокаторы';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'C08') {
                                  return 'Блокаторы кальциевых каналов';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'C09') {
                                  return 'Средства, действующие на ренин-ангиотензиновую систему';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'C10') {
                                  return 'Гиполипидемические средства';
                                } //_D_
                                else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'D01') {
                                  return 'Противогрибковые препараты, применяемые в дерматологии';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'D02') {
                                  return 'Препараты со смягчающим и защитным действием';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'D03') {
                                  return 'Препараты для лечения ран и язв';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'D04') {
                                  return 'Препараты для лечения ран и язв';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'D05') {
                                  return 'Препараты для лечения псориаза';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'D06') {
                                  return 'Антибиотики и химиотерапевтические средства для дерматологического применения';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'D07') {
                                  return 'Кортикостероиды для дерматологического применения';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'D08') {
                                  return 'Антисептики и дезинфицирующие средства';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'D09') {
                                  return 'Перевязочные материалы';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'D10') {
                                  return 'Препараты для лечения угревой сыпи';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'D11') {
                                  return 'Другие дерматологические препараты';
                                } //__G
                                else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'G01') {
                                  return 'Противомикробные препараты и антисептики, применяемые в гинекологии';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'G02') {
                                  return 'Другие препараты, применяемые в гинекологии';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'G03') {
                                  return 'Половые гормоны и модуляторы функции половых органов';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'G04') {
                                  return 'Препараты для лечения урологических заболеваний';
                                } //_H_
                                else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'H01') {
                                  return 'Гормоны гипофиза и гипоталамуса и их аналоги';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'H02') {
                                  return 'Кортикостероиды системного действия';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'H03') {
                                  return 'Препараты для лечения заболеваний щитовидной железы';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'H04') {
                                  return 'Гормоны поджелудочной железы';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'H05') {
                                  return 'Препараты, регулирующие обмен кальция';
                                } //_j_
                                else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'J01') {
                                  return 'Антибактериальные препараты системного действия';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'J02') {
                                  return 'Противогрибковые препараты системного действия';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'J04') {
                                  return 'Препараты, активные в отношении микобактерий';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'J05') {
                                  return 'Противовирусные препараты системного действия';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'J06') {
                                  return 'Иммунные сыворотки и иммуноглобулины';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] ==
                                    'J07') {
                                  return 'Вакцины';
                                } else {
                                  return 'Не присвоен';
                                }
                              }
        
                              //
                              String listTileText3(index) {
                                if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'A01A') {
                                  return 'Стоматологические препараты';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'A02A') {
                                  return 'Антациды';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'A02B') {
                                  return 'Противоязвенные препараты и препараты для лечения гастроэзофагеального рефлюкса';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'A02X') {
                                  return 'Прочие препараты для лечения заболеваний, связанных с нарушением кислотности';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'A03A') {
                                  return 'Препараты для лечения функциональных расстройств кишечника';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'A03B') {
                                  return 'Белладонна и её производные';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'A03C') {
                                  return 'Спазмолитики в комбинации с психотропными препаратами';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'A03D') {
                                  return 'Спазмолитики в комбинации с анальгетиками';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'A03E') {
                                  return 'Спазмолитики и холиноблокаторы в комбинации с другими препаратами';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'A03F') {
                                  return 'Стимуляторы моторики ЖКТ';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'A04A') {
                                  return 'Противорвотные препараты';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A05A') {
                                  return 'Препараты для лечения заболеваний желчного пузыря';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A05B') {
                                  return 'Препараты для лечения заболеваний печени';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A05C') {
                                  return 'Комбинация препаратов для лечения заболеваний печени и желчевыводящих путей';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A06A') {
                                  return 'Слабительные';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A07A') {
                                  return 'Кишечные противомикробные и противовоспалительные препараты';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A07B') {
                                  return 'Кишечные адсорбенты';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A07C') {
                                  return 'Электролиты с углеводами';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A07D') {
                                  return 'Препараты, снижающие моторику ЖКТ';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A07E') {
                                  return 'Кишечные противовоспалительные препараты';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A07F') {
                                  return 'Антидиарейные микроорганизмы';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A07X') {
                                  return 'Прочие антидиарейные препараты';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A08A') {
                                  return 'Препараты для лечения ожирения (исключая диетические продукты)';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A09A') {
                                  return 'Препараты, способствующие пищеварению (включая ферментные препараты)';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A10A') {
                                  return 'Инсулины';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A10B') {
                                  return 'Инсулины';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A10X') {
                                  return 'Прочие лекарственные препараты для лечения сахарного диабета';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A11A') {
                                  return 'Поливитамины в комбинации с другими препаратами';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A11B') {
                                  return 'Поливитамины';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A11C') {
                                  return 'Витамины A и D и их комбинация';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A11D') {
                                  return 'Витамин B1 и его комбинация с витаминами B6 и B12';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A11E') {
                                  return 'Комплекс витаминов группы B, включая комбинации с другими препаратами';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A11G') {
                                  return 'Аскорбиновая кислота, включая комбинации с другими препаратами';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A11H') {
                                  return 'Другие витамины в чистом виде';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A11J') {
                                  return 'Другие комбинации витаминов ';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A12A') {
                                  return 'Препараты кальция';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A12B') {
                                  return 'Препараты калия';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A12C') {
                                  return 'Прочие минеральные вещества';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A13A') {
                                  return 'Общетонизирующие препараты ';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A14A') {
                                  return 'Анаболические стероидные препараты';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A14B') {
                                  return 'Прочие анаболические препараты';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'A16A') {
                                  return 'Прочие препараты для лечения заболеваний ЖКТ и нарушения обмена веществ';
                                } //_B_
                                else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] ==
                                    'B01A') {
                                  return 'Антитромботические средства';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'B02A') {
                                  return 'Антифибринолитические средства';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'B02B') {
                                  return 'Витамин K и другие гемостатики';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'B03A') {
                                  return 'Препараты железа';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'B03B') {
                                  return 'Витамин B12 и фолиевая кислота';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'B03X') {
                                  return 'Другие антианемические препараты';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'B05A') {
                                  return 'Кровь и препараты крови';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'B05B') {
                                  return 'Растворы для в/в введения';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'B05C') {
                                  return 'Ирригационные растворы';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'B05D') {
                                  return 'Растворы для перитонеального диализа';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'B05X') {
                                  return 'Добавки к растворам для в/в введения';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'B05Z') {
                                  return 'Гемодиализаты и гемофильтраты';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'B06A') {
                                  return 'Прочие гематологические препараты';
                                } //_C_
                                else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'C01A') {
                                  return 'Сердечные гликозиды';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'C01B') {
                                  return 'Антиаритмические препараты I и III классов';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'C01C') {
                                  return 'Кардиотонические средства, кроме сердечных гликозидов';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'C01D') {
                                  return 'Вазодилататоры для лечения заболеваний сердца';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'C01E') {
                                  return 'Другие препараты для лечения заболеваний сердца';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'C02A') {
                                  return 'Антиадренергические средства центрального действия';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'C02B') {
                                  return 'Ганглиоблокаторы';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'C02C') {
                                  return 'Антиадренергические препараты периферического действия';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'C02D') {
                                  return 'Препараты, действующие на гладкую мускулатуру артериол';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'C02K') {
                                  return 'Другие антигипертензивные препараты';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'C02L') {
                                  return 'Антигипертензивные препараты и диуретики в комбинации';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C02N') {
                                  return 'Антигипертензивные препараты, включенные в АТХ-группу C02, в комбинации';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C03A') {
                                  return 'Тиазидные диуретики';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C03B') {
                                  return 'Тиазидоподобные диуретики';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C03C') {
                                  return '«Петлевые» диуретики';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C03D') {
                                  return 'Калийсберегающие диуретики';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C03E') {
                                  return 'Комбинации диуретиков с калийсберегающими препаратами';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C03X') {
                                  return 'Прочие диуретики';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C04A') {
                                  return 'Периферические вазодилататоры';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C05A') {
                                  return 'Средства для лечения геморроя и анальных трещин для местного применения';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C05B') {
                                  return 'Препараты для лечения варикозного расширения вен';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C05C') {
                                  return 'Препараты, снижающие проницаемость капилляров';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C07A') {
                                  return 'Бета-адреноблокаторы';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C07B') {
                                  return 'Бета-адреноблокаторы в комбинации с тиазидами';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C07C') {
                                  return 'Бета-адреноблокаторы в комбинации с другими диуретиками';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C07D') {
                                  return 'Бета-адреноблокаторы в комбинации с тиазидами и другими диуретиками';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C07E') {
                                  return 'Бета-адреноблокаторы в комбинации с вазодилататорами';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C07F') {
                                  return 'Бета-адреноблокаторы в других комбинациях';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C08C') {
                                  return 'Селективные блокаторы кальциевых каналов с преимущественным действием на сосуды';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C08D') {
                                  return 'Селективные блокаторы кальциевых каналов с прямым действием на сердце';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C08E') {
                                  return 'Неселективные блокаторы кальциевых каналов';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C08G') {
                                  return 'Блокаторы кальциевых каналов в комбинации с диуретиками';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C09A') {
                                  return 'Ингибиторы АПФ';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C09B') {
                                  return 'Ингибиторы АПФ в комбинации с другими препаратами';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C09C') {
                                  return 'Антагонисти ангиотензина II';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C09D') {
                                  return 'Антагонисти ангиотензина II в комбинации с другими препаратами';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C09X') {
                                  return 'Прочие препараты, влияющие на систему ренин-ангиотензин';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C10A') {
                                  return 'Гиполипидемические средства';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'C10B') {
                                  return 'Гиполипидемические средства в комбинации с другими препаратами';
                                } //_Д_
                                else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'D01A') {
                                  return 'Противогрибковые препараты для местного применения';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'D01B') {
                                  return 'Противогрибковые препараты для системного применения';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'D02A') {
                                  return 'Препараты со смягчающим и защитным действием';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'D02B') {
                                  return 'Препараты, защищающие от УФ-излучения';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'D03A') {
                                  return 'Препараты, способствующие нормальному рубцеванию';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'D03B') {
                                  return 'Ферментные препараты';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'D04A') {
                                  return 'Препараты для лечения зуда, в т.ч. антигистаминные и анестетики';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'D05A') {
                                  return 'Препараты для лечения псориаза для местного применения';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'D05B') {
                                  return 'Препараты для лечения псориаза для системного применения';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'D06A') {
                                  return 'Антибиотики для местного назначения';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'D06B') {
                                  return 'Химиотерапевтические препараты для местного применени';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'D06C') {
                                  return 'Химиотерапевтические препараты для местного применени другие';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'D07A') {
                                  return 'Кортикостероиды';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'D07B') {
                                  return 'Кортикостероиды в комбинации с антисептиками';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'D07C') {
                                  return 'Кортикостероиды в комбинации с антибиотиками';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'D07X') {
                                  return 'Кортикостероиды в комбинации с другими препаратами';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'D08A') {
                                  return 'Антисептики и дезинфицирующие средства';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'D09A') {
                                  return 'Перевязочные материалы';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'D10A') {
                                  return 'Препараты для лечения угревой сыпи местного применения';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'D10B') {
                                  return 'Препараты для системного лечения угревой сыпи';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'D11A') {
                                  return 'Другие дерматологические препараты';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'D11A') {
                                  return 'Другие дерматологические препараты';
                                } //_G_
                                else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'G01A') {
                                  return 'Противомикробные препараты и антисептики, кроме комбинаций с кортикостероидами';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'G01B') {
                                  return 'Противомикробные препараты и антисептики в комбинации с кортикостероидами';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'G02A') {
                                  return 'Утеротонизирующие препараты';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'G02B') {
                                  return 'Контрацептивы для местного применения';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'G02C') {
                                  return 'Другие препараты, применяемые в гинекологии';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'G03A') {
                                  return 'Гормональные контрацептивы системного действия';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'G03B') {
                                  return 'Андрогены';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'G03C') {
                                  return 'Эстрогены';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'G03D') {
                                  return 'Прогестагены';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'G03E') {
                                  return 'Андрогены в комбинации с женскими половыми гормонами';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'G03F') {
                                  return 'Прогестагены в комбинации с эстрогенами';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'G03G') {
                                  return 'Гонадотропины и другие стимуляторы овуляции';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'G03H') {
                                  return 'Антиандрогены';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'G03X') {
                                  return 'Половые гормоны и модуляторы половой системы другие';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'G04B') {
                                  return 'Препараты для лечения урологических заболеваний';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'G04C') {
                                  return 'Препараты для лечения доброкачественной гиперплазии предстательной железы';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'G04C') {
                                  return 'Препараты для лечения доброкачественной гиперплазии предстательной железы';
                                } //_H_
                                else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] ==
                                    'H01A') {
                                  return 'Гормоны передней доли гипофиза и их аналоги';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'H01B') {
                                  return 'Гормоны задней доли гипофиза';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'H01C') {
                                  return 'Гормоны гипоталамуса';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'H02A') {
                                  return 'Кортикостероиды системного действия';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'H02B') {
                                  return 'Глюкокортикостероиды для системного назначения в комбинации';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'H02C') {
                                  return 'Препараты, подавляющие функцию коры надпочечников';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'H03A') {
                                  return 'Препараты щитовидной железы';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'H03B') {
                                  return 'Антитиреоидные препараты';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'H03C') {
                                  return 'Препараты йода';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'H04A') {
                                  return 'Гормоны, расщепляющие гликоген';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'H05A') {
                                  return 'Паратиреоидные гормоны и их аналоги';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'H05B') {
                                  return 'Антипаратиреоидные средства';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'H05B') {
                                  return 'Антипаратиреоидные средства';
                                } //_J_
                                else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'J01A') {
                                  return 'Тетрациклины';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'J01B') {
                                  return 'Амфениколы';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'J01C') {
                                  return 'Бета-лактамные антибактериальные препараты: пенициллины';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'J01D') {
                                  return 'Другие бета-лактамные антибактериальные препараты';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'J01E') {
                                  return 'Сульфаниламиды и триметоприм';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'J01F') {
                                  return 'Макролиды, линкозамиды и стрептограмины';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'J01G') {
                                  return 'Аминогликозиды';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'J01M') {
                                  return 'Антибактериальные препараты, производные хинолона';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'J01R') {
                                  return 'Противомикробные препараты в комбинации';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'J01X') {
                                  return 'Другие антибактериальные препараты';
                                } else if (qgroup[index][0] +
                                        qgroup[index][1] +
                                        qgroup[index][2] +
                                        qgroup[index][3] ==
                                    'J02A') {
                                  return 'Противогрибковые препараты системного действия';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'J04A') {
                                  return 'Противотуберкулезные препараты';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'J04B') {
                                  return 'Противолепрозные препараты';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'J05A') {
                                  return 'Противовирусные препараты прямого действия';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'J06A') {
                                  return 'Иммунные сыворотки';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'J06B') {
                                  return 'Иммуноглобулины';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'J07A') {
                                  return 'Вакцины бактериальные';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'J07B') {
                                  return 'Вакцины вирусные';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'J07C') {
                                  return 'Вакцины бактериальные и вирусные в комбинации';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'J07X') {
                                  return 'Вакцины прочие';
                                } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] == 'J07X') {
                                  return 'Вакцины прочие';
                                } else {
                                  return 'Не присвоен';
                                }
                              }
        
                              // ('${qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4].toUpperCase()} - ${listTileText4(index)}'),
                              // String listTileText4(index) {
                              //   if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'A01AA') {
                              //     return 'Противомикробные препараты для местного лечения заболеваний полости рта';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'A01AB') {
                              //     return 'Противомикробные препараты для местного лечения заболеваний полости рта ';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'A01AC') {
                              //     return 'Глюкокортикостероиды для местного лечения заболеваний полости рта';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'A01AD') {
                              //     return 'Прочие препараты для лечения заболеваний полости рта';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'A02AA') {
                              //     return 'Препараты магния';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'A02AB') {
                              //     return 'Препараты алюминия';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'A02AC') {
                              //     return 'Препараты кальция';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'A02AD') {
                              //     return 'Комбинация препаратов алюминия, кальция и магния';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'A02AF') {
                              //     return 'Антациды в сочетании с ветрогонными препаратами';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'A02AG') {
                              //     return 'Антациды в сочетании со спазмолитиками';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'A02AH') {
                              //     return 'Антациды в сочетании с натрия бикарбонатом';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A02AX') {
                              //     return 'Антациды в сочетании с другими препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A02BA') {
                              //     return 'Блокаторы H2-гистаминовых рецепторов';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A02BB') {
                              //     return 'Простагландины';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A02BC') {
                              //     return 'Ингибиторы протонового насоса';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A02BD') {
                              //     return 'Комбинации препаратов для эрадикации';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A02BX') {
                              //     return 'Прочие противоязвенные препараты и препараты для лечения гастроэзофагеального рефлюкса';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A03AA') {
                              //     return 'Синтетические холиноблокаторы — эфиры с третичной аминогруппой';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A03AB') {
                              //     return 'Синтетические холиноблокаторы — четвертичные аммониевые соединения';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A03AC') {
                              //     return 'Синтетические холиноблокаторы — амиды с третичной аминогруппой';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A03AD') {
                              //     return 'Папаверин и его производные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A03AE') {
                              //     return 'Препараты, действующие на серотониновые рецепторы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A03AX') {
                              //     return 'Другие препараты для лечения функциональных расстройств кишечника';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A03BA') {
                              //     return 'Алкалоиды белладонны, третичные амины';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A03BB') {
                              //     return 'Полусинтетические алкалоиды белладонны, четвертичные аммониевые соединения';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A03CA') {
                              //     return 'Синтетические холиноблокаторы в комбинации с психотропными препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A03CB') {
                              //     return 'Белладонна и её производные в комбинации с психотропными препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A03CC') {
                              //     return 'Прочие спазмолитики в комбинации с психотропными препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A03DA') {
                              //     return 'Синтетические холиноблокаторы в комбинации с анальгетиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A03DB') {
                              //     return 'Белладонна и её производные в комбинации с анальгетиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A03DC') {
                              //     return 'Прочие спазмолитики в комбинации с анальгетиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A03EA') {
                              //     return 'Спазмолитики, психотропные препараты и анальгетики в комбинации';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A03ED') {
                              //     return 'Спазмолитики в комбинации с прочими препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A03FA') {
                              //     return 'Стимуляторы моторики ЖКТ';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A04AA') {
                              //     return 'Антагонисты серотонина';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A04AD') {
                              //     return 'Прочие противорвотные препараты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A05AA') {
                              //     return 'Препараты для желчных кислот и их производные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A05AB') {
                              //     return 'Препараты для лечения заболеваний желчевыводящих путей';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A05AX') {
                              //     return 'Прочие препараты для лечения заболеваний желчевыводящих путей';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A05BA') {
                              //     return 'Препараты для лечения заболеваний печени';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A06AA') {
                              //     return 'Смягчаюшие препараты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A06AB') {
                              //     return 'Контактные слабительные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A06AC') {
                              //     return 'Слабительные, увеличивающие объём кишечного содержимого';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A06AD') {
                              //     return 'Осмотические слабительные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A06AG') {
                              //     return 'Слабительные препараты в клизмах';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A06AH') {
                              //     return 'Антагонисты периферических опиоидных рецепторов';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A06AX') {
                              //     return 'Прочие слабительные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A07AA') {
                              //     return 'Антибактериальные препараты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A07AB') {
                              //     return 'Сульфаниламиды';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A07AC') {
                              //     return 'Производные имидазола';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A07AX') {
                              //     return 'Прочие кишечные противомикробные препараты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A07BA') {
                              //     return 'Препараты угля';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A07BB') {
                              //     return 'Висмута субгалат';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A07BC') {
                              //     return 'Прочие кишечные адсорбенты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A07CA') {
                              //     return 'Регидратанты для перорального приёма';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A07DA') {
                              //     return 'Препараты, снижающие моторику ЖКТ';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A07EA') {
                              //     return 'Глюкокортикостероиды местного действия';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A07EB') {
                              //     return 'Антиаллергические препараты (исключая глюкокортикостероиды)';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A07EC') {
                              //     return 'Аминосалициловая кислота и аналогичные препараты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A07FA') {
                              //     return 'Антидиарейные микроорганизмы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A07XA') {
                              //     return 'Прочие антидиарейные препараты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A08AA') {
                              //     return 'Препараты для лечения ожирения центрального действия';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A08AB') {
                              //     return 'Препараты для лечения ожирения периферического действия';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A08AX') {
                              //     return 'Другие средства против ожирения';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A09AA') {
                              //     return 'Пищеварительные ферментные препараты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A09AB') {
                              //     return 'Кислоты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A09AC') {
                              //     return 'Комбинация пищеварительных ферментных препаратов и кислотосодержащих препаратов';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A10AB') {
                              //     return 'Инсулины быстрого действия для инъекций и их аналоги';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A10AC') {
                              //     return 'Инсулины среднего действия для инъекций и их аналоги';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A10AD') {
                              //     return 'Инсулины и их аналоги для инъекций: среднего или длительного действия в комбинации с инсулинами быстрого действия';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A10AE') {
                              //     return 'Инсулины длительного действия для инъекций и их аналоги';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A10AF') {
                              //     return 'Инсулины их их аналоги для ингаляций';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A10BA') {
                              //     return 'Бигуаниды';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A10BB') {
                              //     return 'Производные сульфонилмочевины';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A10BC') {
                              //     return 'Гетероциклические сульфонамиды';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A10BD') {
                              //     return 'Комбинации гипогликемических препаратов для приёма внутрь';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A10BF') {
                              //     return 'Ингибиторы альфа-глюкозидазы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A10BG') {
                              //     return 'Тиазолиндионы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A10BH') {
                              //     return 'Ингибиторы дипептидилпептидазы-4 (DPP-4)';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A10BJ') {
                              //     return 'Аналоги глюкагоноподобных пептидов-1 (GLP-1)';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A10BK') {
                              //     return 'Ингибиторы натрий-глюкозного котранспортера типа 2 (SGLT2)';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A10BX') {
                              //     return 'Прочие гипогликемические препараты, кроме инслинов';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A10XA') {
                              //     return 'Ингибиторы альдозоредуктазы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A11AA') {
                              //     return 'Поливитамины в комбинации с минеральными веществами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A11AB') {
                              //     return 'Поливитамины в комбинациях с другими препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A11BA') {
                              //     return 'Поливитамины';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A11CA') {
                              //     return 'Витамин A ';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A11CB') {
                              //     return 'Витамины A и D в комбинации';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A11CC') {
                              //     return 'Витамин D и его аналоги';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A11DA') {
                              //     return 'Витамин B1';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A11DB') {
                              //     return 'Витамин B1 в комбинации с витаминами B6 и/или B12';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A11EA') {
                              //     return 'Комплекс витаминов группы B';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A11EB') {
                              //     return 'Комплекс витаминов группы B в комбинации с витамином C';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A11EC') {
                              //     return 'Комплекс витаминов группы B в комбинации с минеральными веществами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A11ED') {
                              //     return 'КОмплекс витаминов группы B в комбинации с анаболическими стероидами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A11EX') {
                              //     return 'Витамины группы B, в комбинации с другими препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A11GA') {
                              //     return 'Аскорбиновая кислота (витамин C)';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A11GB') {
                              //     return 'Аскорбиновая кислота (витамин C) в комбинации с другими препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A11HA') {
                              //     return 'Другие витаминнные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A11JA') {
                              //     return 'Витамины в комбинации';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A11JB') {
                              //     return 'Витамины в комбинации с минеральными веществами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A11JC') {
                              //     return 'Витамины в комбинации с другими препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A12AA') {
                              //     return 'Препараты кальция';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A12AX') {
                              //     return 'Препараты кальция в комбинации с другими препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A12BA') {
                              //     return 'Препараты калия';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A12CA') {
                              //     return 'Препараты натрия';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A12CB') {
                              //     return 'Препараты цинка';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A12CC') {
                              //     return 'Препараты магния';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A12CD') {
                              //     return 'Препараты фтора';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A12CE') {
                              //     return 'Препараты селена';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A12CX') {
                              //     return 'Другие минеральные препараты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A14AA') {
                              //     return 'Производные андростана';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A14AB') {
                              //     return 'Производные эстрена';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A16AA') {
                              //     return 'Аминокислоты и их производные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A16AB') {
                              //     return 'Ферментные препараты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'A16AX') {
                              //     return 'Прочие препараты для лечения заболеваний ЖКТ и  нарушений обмена веществ';
                              //   } //_B_
                              //   else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'B01AA') {
                              //     return 'Антагонисты витамина K';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'B01AB') {
                              //     return 'Гепарин и его производные';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'B01AC') {
                              //     return 'Ингибиторы агрегации тромбоцитов, кроме гепарина';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'B01AD') {
                              //     return 'Ферментные препараты';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'B01AE') {
                              //     return 'Прямые ингибиторы тромбина';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'B01AF') {
                              //     return 'Прямые ингибиторы фактора Ха';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'B01AX') {
                              //     return 'Прочие антикоагулянты';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'B02AA') {
                              //     return 'Аминокислоты';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'B02AB') {
                              //     return 'Ингибиторы протеиназ плазмы';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'B02BA') {
                              //     return 'Витамин K';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'B02BB') {
                              //     return 'Фибриноген';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B02BC') {
                              //     return 'Местные гемостатики';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B02BD') {
                              //     return 'Факторы свертывания крови';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B02BX') {
                              //     return 'Другие системные гемостатики';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B03AA') {
                              //     return 'Пероральные препараты двухвалентного железа';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B03AB') {
                              //     return 'Пероральные препараты трехвалентного железа';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B03AC') {
                              //     return 'Парентеральные препараты трехвалентного железа';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B03AD') {
                              //     return 'Препараты железа в комбинации с фолиевой кислотой';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B03AE') {
                              //     return 'Препараты железа в комбинации с другими препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B03BA') {
                              //     return 'Витамин B12 (цианокобаламин и его аналоги)';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B03BB') {
                              //     return 'Фолиевая кислота и ее производные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B03XA') {
                              //     return 'Другие антианемические препараты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B05AA') {
                              //     return 'Кровезаменители и препараты плазмы крови';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B05AX') {
                              //     return 'Другие перпараты крови';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B05BA') {
                              //     return 'Растворы для парентерального питания';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B05BB') {
                              //     return 'Растворы, влияющие на водно-электролитный баланс';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B05BC') {
                              //     return 'Растворы с осмодиуретическим действием';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B05CA') {
                              //     return 'Противомикробные растворы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B05CB') {
                              //     return 'Солевые растворы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B05CX') {
                              //     return 'Другие ирригационные растворы ';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B05DA') {
                              //     return 'Изотонические растворы ';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B05DB') {
                              //     return 'Гипертонические растворы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B05XA') {
                              //     return 'Растворы электролитов';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B05XB') {
                              //     return 'Аминокислоты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B05XC') {
                              //     return 'Витамины';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B05XX') {
                              //     return 'Прочие добавки к растворам для в/в введения';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B05ZA') {
                              //     return 'Гемодиализаты (концентраты)';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B05ZB') {
                              //     return 'Растворы для гемофильтрации';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B06AA') {
                              //     return 'Ферментные препараты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B06AB') {
                              //     return 'Крови препараты другие';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'B06AC') {
                              //     return 'Препараты, применяемые при наследственном ангионевротическом отеке';
                              //   } //__С__
                              //   else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'C01AA') {
                              //     return 'Гликозиды наперстянки ';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'C01AB') {
                              //     return 'Гликозиды морского лука';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'C01AC') {
                              //     return 'Гликозиды строфанта';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'C01AX') {
                              //     return 'Прочие сердечные гликозиды';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'C01BA') {
                              //     return 'Антиаритмические препараты Iа класса';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'C01BB') {
                              //     return 'Антиаритмические препараты Ib класса';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'C01BC') {
                              //     return 'Антиаритмические препараты Ic класса';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'C01BD') {
                              //     return 'Антиаритмические препараты III класса';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'C01BG') {
                              //     return 'Прочие антиаритмические препараты I класса';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'C01CA') {
                              //     return 'Адренергические и дофаминергические средства';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'C01CE') {
                              //     return 'Ингибиторы фосфодиэстеразы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C01CX') {
                              //     return 'Другие кардиотонические средства';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C01DA') {
                              //     return 'Органические нитраты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C01DB') {
                              //     return 'Хинолоновые вазодилататоры';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C01DX') {
                              //     return 'Вазодилататоры, используемые для лечения заболеваний сердца, другие';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C01EA') {
                              //     return 'Простагландины';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C01EB') {
                              //     return 'Другие препараты для лечения заболеваний сердца';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C01EX') {
                              //     return 'Препараты для лечения заболеваний сердца комбинированные другие';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02AA') {
                              //     return 'Алкалоиды раувольфии';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02AB') {
                              //     return 'Метилдопа';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02AC') {
                              //     return 'Агонисты имидазолиновых рецепторов';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02BA') {
                              //     return 'Производные сульфония';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02BB') {
                              //     return 'Вторичные и третичные амины';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02BC') {
                              //     return 'Бисчетвертичные аммониевые соединения';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02CA') {
                              //     return ' Альфа-адреноблокаторы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02CC') {
                              //     return 'Производные гуанидина';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02DA') {
                              //     return 'Тиазидные производные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02DB') {
                              //     return 'Гидразинофталазиновые производные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02DC') {
                              //     return 'Пиримидиновые производные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02DD') {
                              //     return 'Нитроферрицианидные производные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02DG') {
                              //     return 'Производные гуанидина';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02KA') {
                              //     return 'Алкалоиды, кроме алкалоидов раувольфии';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02KB') {
                              //     return 'Тирозингидроксилазы ингибиторы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02KC') {
                              //     return 'Ингибиторы МАО';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02KD') {
                              //     return 'Серотонина антагонисты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02KX') {
                              //     return 'Антигипертензивные средства для лечения легочной артериальной гипертензии';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02LA') {
                              //     return 'Раувольфии алкалоиды в комбинации с диуретиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02LB') {
                              //     return 'Метилдопа в комбинации с диуретиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02LC') {
                              //     return 'Агонисты имидазолиновых рецепторов в комбинации с диуретиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02LE') {
                              //     return 'Альфа-адреноблокаторы в комбинации с диуретиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02LF') {
                              //     return 'Производные гуанидина в комбинации с диуретиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02LG') {
                              //     return 'Производные гидразинофталазина в комбинации с диуретиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02LK') {
                              //     return 'Алкалоиды, кроме алкалоидов раувольфии, в комбинации с диуретиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02LL') {
                              //     return 'Ингибиторы МАО в комбинации с диуретиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02LN') {
                              //     return 'Антагонисты серотонина в комбинации с диуретиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C02LX') {
                              //     return 'Прочие антигипертензивные препараты в комбинации с диуретиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C03AA') {
                              //     return 'Тиазиды';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C03AB') {
                              //     return 'Тиазиды в комбинации с солями калия';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C03AH') {
                              //     return 'Тиазиды в комбинации с психолептиками и/или анальгетиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C03AX') {
                              //     return 'Тиазиды в комбинации с другими препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C03BA') {
                              //     return 'Сульфонамиды';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C03BB') {
                              //     return 'Сульфонамиды в комбинации с солями калия';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C03BC') {
                              //     return 'Ртутьсодержащие диуретики';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C03BD') {
                              //     return 'Производные ксантина';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C03BK') {
                              //     return 'Сульфонамиды в комбинации с другими препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C03BX') {
                              //     return 'Другие тиазидоподобные диуретики';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C03CA') {
                              //     return 'Сульфонамиды';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C03CB') {
                              //     return 'Сульфонамиды в комбинации с солями калия';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C03CC') {
                              //     return 'Производные арилоксиуксусной кислоты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C03CD') {
                              //     return 'Производные пиразолона';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C03CX') {
                              //     return 'Другие петлевые диуретики';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C03DA') {
                              //     return 'Антагонисты альдостерона';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C03DB') {
                              //     return 'Другие калийсберегающие диуретики';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C03EA') {
                              //     return 'Тиазидоподобные диуретики в комбинации с калийсберегающими препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C03EB') {
                              //     return 'Диуретики «петлевые» в комбинации с калийсберегающими препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C03XA') {
                              //     return 'Антагонисты вазопрессина';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C04AA') {
                              //     return 'Производные 2-амино-1-фенилэтанола';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C04AB') {
                              //     return 'Производные имидазолина';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C04AC') {
                              //     return 'Никотиновая кислота и ее производные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C04AD') {
                              //     return 'Производные пурина';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C04AE') {
                              //     return 'Спорыньи алкалоиды';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C04AF') {
                              //     return 'Ферменты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C04AX') {
                              //     return 'Периферические вазодилататоры другие';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C05AA') {
                              //     return 'Кортикостероиды';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C05AB') {
                              //     return 'Антибиотики';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C05AD') {
                              //     return 'Местные анестетики';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C05AE') {
                              //     return 'Мышечные релаксанты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C05AX') {
                              //     return 'Препараты для лечения геморроя и анальных трещин для местного применения другие';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C05BA') {
                              //     return 'Гепарины или гепариноиды для местного применения';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C05BB') {
                              //     return 'Веносклерозирующие средства для локальных инъекций';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C05BX') {
                              //     return 'Веносклерозирующие препараты другие';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C05CA') {
                              //     return 'Биофлавоноиды';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C05CX') {
                              //     return 'Препараты, снижающие проницаемость капилляров, другие';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C07AA') {
                              //     return 'Неселективные бета-адреноблокаторы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C07AB') {
                              //     return 'Селективные бета-адреноблокаторы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C07AG') {
                              //     return 'Альфа- и бета-адреноблокаторы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C07BA') {
                              //     return 'Неселективные бета-адреноблокаторы в комбинации с тиазидами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C07BB') {
                              //     return 'Селективные бета-адреноблокаторы в комбинации с тиазидами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C07BG') {
                              //     return 'Альфа- и бета-адреноблокаторы в комбинации с тиазидами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C07CA') {
                              //     return 'Бета-адреноблокатры неселективные в комбинации с другими диуретиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C07CB') {
                              //     return 'Бета-адреноблокатры селективные в комбинации с другими диуретиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C07CG') {
                              //     return 'Альфа- и бета-адреноблокатры в комбинации с другими диуретиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C07DA') {
                              //     return 'Бета-адреноблокаторы неселективные в комбинации с тиазидами и другими диуретиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C07DB') {
                              //     return 'Бета-адреноблокаторы селективные в комбинации с тиазидами и другими диуретиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C07EA') {
                              //     return 'Бета-адреноблокаторы неселективные в комбинации с вазодилататорами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C07EB') {
                              //     return 'Бета-адреноблокаторы селективные в комбинации с вазодилататорами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C07FA') {
                              //     return 'Бета-адреноблокаторы неселективные в комбинации с другими антигипертензивными средствами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C07FB') {
                              //     return 'Бета-адреноблокаторы селективные в комбинации с блокаторами кальциевых каналов';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C07FX') {
                              //     return 'Бета-адреноблокаторы в других комбинациях';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C08CA') {
                              //     return 'Производные дигидропиридина';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C08CX') {
                              //     return 'Прочие селективные блокаторы кальциевых каналов с преимущественным влиянием на сосуды';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C08DA') {
                              //     return 'Производные фенилалкиламина';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C08DB') {
                              //     return 'Производные бензотиазепина';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C08EA') {
                              //     return 'Производные фенилалкиламина';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C08EX') {
                              //     return 'Другие неселективные блокаторы кальциевых каналов';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C08GA') {
                              //     return 'Блокаторы кальциевых каналов в комбинации с диуретиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C09AA') {
                              //     return 'Ингибиторы АПФ';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C09BA') {
                              //     return 'Ингибиторы АПФ в комбинации с диуретиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C09BB') {
                              //     return 'Ингибиторы АПФ в комбинации с блокаторами кальциевых каналов';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C09BX') {
                              //     return 'Ингибиторы АПФ в комбинации с другими препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C09CA') {
                              //     return 'Антагонисты ангиотензина II';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C09DA') {
                              //     return 'Антагонисты ангиотензина II в комбинации с диуретиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C09DB') {
                              //     return 'Антагонисты ангиотензина II в комбинации с БКК';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C09DX') {
                              //     return 'Антагонисты ангиотензина II в комбинации с другими препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C09XA') {
                              //     return 'Ингибиторы ренина';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C10AA') {
                              //     return 'Ингибиторы ГМГ-КоА-редуктазы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C10AB') {
                              //     return 'Фибраты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C10AC') {
                              //     return 'Препараты, связывающие желчные кислоты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C10AD') {
                              //     return 'Никотиновая кислота и ее производные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C10AX') {
                              //     return 'Гиполипидемические препараты другие';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C10BA') {
                              //     return 'ГМГ-КоА-редуктазы ингибиторы, в комбинации с другими гиполипидемическими препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'C10BX') {
                              //     return ' ГМГ-КоА-редуктазы ингибиторы в других комбинациях';
                              //   } //_Д_
                              //   else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'D01AA') {
                              //     return 'Противогрибковые антибиотики';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'D01AC') {
                              //     return 'Производные имидазола и триазола';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'D01AE') {
                              //     return 'Противогрибковые препараты для местного применения другие';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'D01BA') {
                              //     return 'Противогрибковые препараты для системного применения';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'D02AA') {
                              //     return 'Силиконсодержащие средства';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'D02AB') {
                              //     return 'Препараты цинка';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'D02AC') {
                              //     return 'Препараты, содержащие мягкий парафин и жиры';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'D02AD') {
                              //     return 'Жидкие пластыри';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'D02AE') {
                              //     return 'Препараты мочевины';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'D02AF') {
                              //     return 'Препараты салициловой кислоты';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'D02AX') {
                              //     return 'Дерматопротекторы другие';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D02BA') {
                              //     return 'Препараты, защищающие от УФ-излучения для местного применения';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D02BB') {
                              //     return 'Препараты, защищающие от УФ-излучения для системного применения';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D03AA') {
                              //     return 'Мази с рыбьим жиром';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D03AX') {
                              //     return 'Другие препараты, способствующие нормальному рубцеванию';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D03BA') {
                              //     return 'Протеолитические ферменты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D04AA') {
                              //     return 'Антигистаминные препараты для наружного применения';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D04AB') {
                              //     return 'Местные анестетики для наружного применения';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D04AX') {
                              //     return 'Противозудные препараты другие';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D05AA') {
                              //     return 'Деготь';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D05AC') {
                              //     return 'Производные антрацена';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D05AD') {
                              //     return 'Псоралены для местного применения';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D05AX') {
                              //     return 'Препараты для лечения псориаза для местного назначения другие';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D05BA') {
                              //     return 'Псоралены для системного применения';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D05BB') {
                              //     return 'Ретиноиды для лечения псориаза';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D05BX') {
                              //     return 'Препараты для лечения псориаза для системного назначения другие';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D06AA') {
                              //     return 'Тетрациклин и его производные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D06AX') {
                              //     return 'Антибиотики для местного назначения другие';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D06BA') {
                              //     return 'Сульфаниламиды';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D06BB') {
                              //     return 'Противовирусные препараты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D06BX') {
                              //     return 'Химиотерапевтические препараты для местного применения другие';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D07AA') {
                              //     return 'Кортикостероиды с низкой активностью (группа I)';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D07AB') {
                              //     return 'Кортикостероиды с умеренной активностью (группа II)';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D07AC') {
                              //     return 'Кортикостероиды с высокой активностью (группа III)';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D07AD') {
                              //     return 'Кортикостероиды с очень высокой активностью (группа IV)';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D07BA') {
                              //     return 'Кортикостероиды слабоактивные в комбинации с антисептиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D07BB') {
                              //     return 'Кортикостероиды умеренноактивные в комбинации с антисептиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D07BC') {
                              //     return 'Кортикостероиды активные в комбинации с антисептиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D07BD') {
                              //     return 'Кортикостероиды высокоактивные в комбинации с антисептиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D07CA') {
                              //     return 'Кортикостероиды слабоактивные в комбинации с антибиотиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D07CB') {
                              //     return 'Кортикостероиды умеренно активные в комбинации с антибиотиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D07CC') {
                              //     return 'Кортикостероиды высокоактивные в комбинации с антибиотиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D07CD') {
                              //     return 'Кортикостероиды очень активные в комбинации с антибиотиками';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D07XA') {
                              //     return 'Кортикостероиды слабоактивные в комбинации с другими препаратам';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D07XB') {
                              //     return 'Кортикостероиды умеренноактивные в комбинации с другими препаратам';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D07XC') {
                              //     return 'Кортикостероиды с высокой активностью в комбинации с другими препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D07XD') {
                              //     return 'Кортикостероиды с очень высокой активностью в комбинации с другими препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D08AA') {
                              //     return 'Производные акридина';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D08AB') {
                              //     return 'Препараты алюминия';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D08AC') {
                              //     return 'Бигуаниды и амидины';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D08AD') {
                              //     return 'Борная кислота и ее препараты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D08AE') {
                              //     return 'Фенол и его производные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D08AF') {
                              //     return 'Нитрофурана производные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D08AG') {
                              //     return 'Препараты йода';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D08AH') {
                              //     return 'Хинолина производные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D08AJ') {
                              //     return 'Четвертичные аммониевые соединения';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D08AK') {
                              //     return 'Ртутьсодержащие препараты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D08AL') {
                              //     return 'Соединения серебра';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D08AX') {
                              //     return 'Другие антисептики и дезинфицирующие средства';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D09AA') {
                              //     return 'Перевязочные материалы, пропитанные противомикробными препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D09AB') {
                              //     return 'Цинковые повязки';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D09AX') {
                              //     return 'Вазелиновые повязки';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D10AA') {
                              //     return 'Кортикостероиды в комбинации с другими препаратами для лечения угревой сыпи';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D10AB') {
                              //     return 'Серосодержащие препараты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D10AD') {
                              //     return 'Ретиноиды для местного лечения угревой сыпи';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D10AE') {
                              //     return 'Перекиси';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D10AF') {
                              //     return 'Противомикробные препараты для лечения угревой сыпи';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D10AX') {
                              //     return 'Препараты для лечения угревой сыпи для местного назначения другие';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D10BA') {
                              //     return 'Ретиноиды для системного лечения угревой сыпи';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D10BX') {
                              //     return 'Препараты для системного лечения угревой сыпи другие';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D11AA') {
                              //     return 'Препараты, уменьшающие потоотделение';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D11AC') {
                              //     return 'Шампуни лечебного действия';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D11AE') {
                              //     return 'Андрогены для местного применения';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D11AF') {
                              //     return 'Препараты для лечения омозолелости и бородавок';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D11AH') {
                              //     return 'Средства для лечения дерматита, кроме кортикостероидов';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'D11AX') {
                              //     return 'Препараты для лечения заболеваний кожи другие';
                              //   } //_G_
                              //   else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'G01AA') {
                              //     return 'Антибиотики';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'G01AB') {
                              //     return 'Соединения мышьяка';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'G01AC') {
                              //     return 'Производные хинолина';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'G01AD') {
                              //     return 'Органические кислоты';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'G01AE') {
                              //     return 'Сульфонамиды';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'G01AF') {
                              //     return 'Производные имидазола';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'G01AG') {
                              //     return 'Производные триазола';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'G01AX') {
                              //     return 'Противомикробные препараты и антисептики другие';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'G01BA') {
                              //     return 'Антибактериальные препараты в комбинации с кортикостероидами';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'G01BC') {
                              //     return 'Производные хинолина в комбинации с кортикостероидами';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'G01BD') {
                              //     return 'Антисептики в комбинации с кортикостероидами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G01BE') {
                              //     return 'Сульфонамиды в комбинации с кортикостероидами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G01BF') {
                              //     return 'Производные имидазола в комбинации с кортикостероидами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G02AB') {
                              //     return 'Алкалоиды спорыньи';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G02AC') {
                              //     return 'Алкалоиды спорыньи в комбинации с окситоцином, включая его аналоги';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G02AD') {
                              //     return 'Простагландины';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G02AX') {
                              //     return 'Утеротонизирующие препараты другие';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G02BA') {
                              //     return 'Контрацептивы внутриматочные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G02BB') {
                              //     return 'Контрацептивы интравагинальные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G02CA') {
                              //     return 'Адреномиметики, токолитические средства';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G02CB') {
                              //     return 'Ингибиторы пролактина';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G02CC') {
                              //     return 'Противовоспалительные препараты для интравагинального применения';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G02CX') {
                              //     return 'Прочие препараты, применяемые в гинекологии';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03AA') {
                              //     return 'Прогестагены и эстрогены (фиксированные сочетания)';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03AB') {
                              //     return 'Прогестагены и эстрогены (для последовательного приема)';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03AC') {
                              //     return 'Прогестагены';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03AD') {
                              //     return 'Препараты для экстренной контрацепции';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03BA') {
                              //     return 'Производные 3-оксоандрост-4-ена';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03BB') {
                              //     return 'Производные 5-андростан-3-она';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03CA') {
                              //     return 'Природные и полусинтетические эстрогены';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03CB') {
                              //     return 'Синтетические эстрогены';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03CC') {
                              //     return 'Эстрогены в комбинации с другими препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03CX') {
                              //     return 'Другие эстрогены';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03DA') {
                              //     return 'Производные прегн-4-ена';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03DB') {
                              //     return 'Производные прегнадиена';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03DC') {
                              //     return 'Производные эстрена';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03EA') {
                              //     return 'Андрогены и эстрогены';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03EB') {
                              //     return 'Андрогены в комбинации с прогестагенами и эстрагенами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03EK') {
                              //     return 'Андрогены и женские половые гормоны в комбинации с другими препаратами';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03FA') {
                              //     return 'Прогестагены и эстрогены (фиксированные комбинации)';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03FB') {
                              //     return 'Прогестагены в комбинации с эстрогенами (для последовательного приема)';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03GB') {
                              //     return 'Гонадотропины';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03GA') {
                              //     return 'Синтетические стимуляторы овуляции';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03HA') {
                              //     return 'Антиандрогены';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03HB') {
                              //     return 'Антиандрогены и эстрогены';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03XA') {
                              //     return 'Антигонадотропины и подобные средства';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03XB') {
                              //     return 'Антигестагены';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03XC') {
                              //     return 'Селективные модуляторы эстрогенных рецепторов';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G03XC') {
                              //     return 'Селективные модуляторы эстрогенных рецепторов';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G04BA') {
                              //     return 'Препараты, подкисляющие мочу';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G04BC') {
                              //     return 'Препараты для лечения нефроуролитиаза';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G04BD') {
                              //     return 'Средства для лечения учащенного мочеиспускания и недержания мочи';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G04BE') {
                              //     return 'Препараты для лечения эректильной дисфункции';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G04BX') {
                              //     return 'Препараты для лечения урологических заболеваний другие';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G04CA') {
                              //     return 'Альфа-адреноблокаторы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G04CB') {
                              //     return 'Ингибиторы тестостерон-5-альфа-редуктазы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'G04CX') {
                              //     return 'Препараты для лечения доброкачественной гипертрофии предстательной железы другие';
                              //   } //_H_
                              //   else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'H01AA') {
                              //     return 'АКТГ';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'H01AB') {
                              //     return 'Тиреотропный гормон';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'H01AC') {
                              //     return 'Соматропин и его агонисты';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'H01AX') {
                              //     return 'Гормоны передней доли гипофиза и их аналоги другие';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'H01BA') {
                              //     return 'Вазопрессин и его аналоги';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'H01BB') {
                              //     return 'Окситоцин и его аналоги';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'H01CA') {
                              //     return 'Гонадотропин-рилизинг гормоны';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'H01CB') {
                              //     return 'Соматостатин и аналоги';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'H01CC') {
                              //     return 'Антигонадотропин-рилизинг гормоны';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'H02AA') {
                              //     return 'Минералокортикоиды';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'H02AB') {
                              //     return 'Глюкокортикоиды';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'H02BX') {
                              //     return 'Глюкокортикостероиды для системного назначения в комбинации';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'H02CA') {
                              //     return 'Антикортикостероиды';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'H03AA') {
                              //     return 'Гормоны щитовидной железы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'H03BA') {
                              //     return 'Производные тиоурацила';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'H03BB') {
                              //     return 'Серосодержащие производные имидазола';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'H03BC') {
                              //     return 'Перхлораты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'H03BX') {
                              //     return 'Прочие антитиреоидные препараты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'H03CA') {
                              //     return 'Препараты йода';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'H04AA') {
                              //     return 'Гормоны, расщепляющие гликоген';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'H05AA') {
                              //     return 'Паратиреоидные гормоны и их аналоги';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'H05BA') {
                              //     return 'Препараты кальцитонина';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'H05BX') {
                              //     return 'Прочие антипаратиреоидные препараты';
                              //   } //_J_
                              //   else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'J01AA') {
                              //     return 'Тетрациклины';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'J01BA') {
                              //     return 'Амфениколы';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'J01CA') {
                              //     return 'Пенициллины широкого спектра действия';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'J01CE') {
                              //     return 'Пенициллины, чувствительные к бета-лактамазам';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'J01CF') {
                              //     return 'Пенициллины, устойчивые к бета-лактамазам';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'J01CG') {
                              //     return 'Ингибиторы бета-лактамаз';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'J01CR') {
                              //     return 'Комбинации пенициллинов, включая ингибиторы бета-лактамаз';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'J01DB') {
                              //     return 'Цефалоспорины первого поколения';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'J01DC') {
                              //     return 'Цефалоспорины второго поколения';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'J01DD') {
                              //     return 'Цефалоспорины третьего поколения';
                              //   } else if (qgroup[index][0] +
                              //           qgroup[index][1] +
                              //           qgroup[index][2] +
                              //           qgroup[index][3] +
                              //           qgroup[index][4] ==
                              //       'J01DE') {
                              //     return 'Цефалоспорины четвертого поколения';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01DF') {
                              //     return 'Монобактамы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01DH') {
                              //     return 'Карбапенемы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01DI') {
                              //     return 'Другие цефалоспорины и пенемы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01EA') {
                              //     return 'Триметоприм и его производные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01EB') {
                              //     return 'Сульфаниламиды короткого действия';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01EC') {
                              //     return 'Сульфаниламиды средней продолжительности действия';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01ED') {
                              //     return 'Сульфаниламиды длительного действия';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01EE') {
                              //     return 'Комбинированные препараты сульфаниламидов и триметоприма, включая производные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01FA') {
                              //     return 'Макролиды';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01FF') {
                              //     return 'Линкозамиды';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01FG') {
                              //     return 'Стрептограмины';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01GA') {
                              //     return 'Стрептомицины';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01GB') {
                              //     return 'Другие аминогликозиды';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01MA') {
                              //     return 'Фторхинолоны';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01MB') {
                              //     return 'Хинолоны другие';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01RA') {
                              //     return 'Противомикробные препараты в комбинации';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01XA') {
                              //     return 'Антибиотики гликопептидной структуры';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01XB') {
                              //     return 'Полимиксин';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01XC') {
                              //     return 'Антибиотики стероидной структуры';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01XD') {
                              //     return 'Производные имидазола';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01XE') {
                              //     return 'Производные нитрофурана';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J01XX') {
                              //     return 'Прочие антибактериальные препараты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J02AA') {
                              //     return 'Антибиотики';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J02AB') {
                              //     return 'Производные имидазола';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J02AC') {
                              //     return 'Производные триазола и тетразола';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J02AX') {
                              //     return 'Другие противогрибковые препараты системного действия';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J04AA') {
                              //     return 'Аминосалициловая кислота и ее производные';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J04AB') {
                              //     return 'Антибиотики';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J04AC') {
                              //     return 'Гидразиды';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J04AD') {
                              //     return 'Производные тиокарбамида';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J04AK') {
                              //     return 'Другие противотуберкулезные препараты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J04AM') {
                              //     return 'Комбинированные противотуберкулезные препараты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J04BA') {
                              //     return 'Противолепрозные препараты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J05AA') {
                              //     return 'Тиосемикарбазоны';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J05AB') {
                              //     return 'Нуклеозиды и нуклеотиды, кроме ингибиторов обратной транскриптазы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J05AC') {
                              //     return 'Циклические амины';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J05AD') {
                              //     return 'Производные фосфоновой кислоты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J05AE') {
                              //     return 'Ингибиторы протеаз';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J05AF') {
                              //     return 'Нуклеозиды и нуклеотиды — ингибиторы обратной транскриптазы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J05AG') {
                              //     return 'Ненуклеозидные ингибиторы обратной транскриптазы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J05AH') {
                              //     return 'Ингибиторы нейраминидазы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J05AJ') {
                              //     return 'Ингибиторы интегразы';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J05AP') {
                              //     return 'Противовирусные препараты для лечения ВГС-инфекции';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J05AR') {
                              //     return 'Комбинированные противовирусные препараты для лечения ВИЧ-инфекции';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J05AX') {
                              //     return 'Прочие противовирусные препараты';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J06AA') {
                              //     return 'Иммунные сыворотки';
                              //   } else if (qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3] + qgroup[index][4] == 'J06BA') {
                              //     return 'Иммуноглобулины, нормальные человеческие';
                              //   } else {
                              //     return 'Не присвоен';
                              //   }
                              // }
        
                              //
                              return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: finalAmount,
                                  itemBuilder: (BuildContext context, int index) {
                                    if (finalAmount == 1) {
                                      return Card(
                                        child: ExpansionTile(
                                          title: Text(
                                              ifoneDrug[0][0].toUpperCase() +
                                                  ifoneDrug[0].substring(1)),
                                          subtitle:
                                              Text('Группа ${ifoneDrug[1]}'),
                                          trailing: AnimatedRotation(
                                            duration:
                                                const Duration(milliseconds: 200),
                                            turns: customTileExpanded[index],
                                            child:
                                                const Icon(Icons.arrow_downward),
                                          ),
                                          onExpansionChanged: (bool expanded) {
                                            if (expanded == true) {
                                              setState(() =>
                                                  customTileExpanded[index] +=
                                                      0.5);
                                            } else {
                                              setState(() =>
                                                  customTileExpanded[index] -=
                                                      0.5);
                                            }
                                          },
                                          children: <Widget>[
                                            ifoneDrug[2] != ''
                                                ? ExpansionTile(
                                                    title: const Text(
                                                        'Фармакодинамика'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[2]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[3] != ''
                                                ? ExpansionTile(
                                                    title: const Text(
                                                        'Фармакокинетика'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[3]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[4] != ''
                                                ? ExpansionTile(
                                                    title:
                                                        const Text('Показания'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[4]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[5] != ''
                                                ? ExpansionTile(
                                                    title: const Text(
                                                        'Побочные Эффекты'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[5]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[6] != ''
                                                ? ExpansionTile(
                                                    title: const Text(
                                                        'Противопоказания'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[6]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[7] != ''
                                                ? ExpansionTile(
                                                    title: const Text(
                                                        'Беременность'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[7]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[8] != ''
                                                ? ExpansionTile(
                                                    title: const Text('Печень'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[8]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[9] != ''
                                                ? ExpansionTile(
                                                    title: const Text('Почки'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[9]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[10] != ''
                                                ? ExpansionTile(
                                                    title:
                                                        const Text('Для детей'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[10]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[11] != ''
                                                ? ExpansionTile(
                                                    title: const Text(
                                                        'Для пожилых людей'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[11]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[12] != ''
                                                ? ExpansionTile(
                                                    title:
                                                        const Text('Замечания'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[12]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[13] != ''
                                                ? ExpansionTile(
                                                    title: const Text(
                                                        'Передозировка препарата'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[13]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                
                                                : Container(),
                                          ],
                                        ),
                                      );
                                    } else {
                                      customTileExpandedX.add(0.0);
                                      customTileExpandedX00.add(0.0);
                                      customTileExpandedX00X.add(0.0);
                                      customTileExpandedX00XX.add(0.0);
                                      if (letters.isEmpty) {
                                        letters = [qgroup[0][0]];
                                        letters2 = [
                                          qgroup[0][0] +
                                              qgroup[0][1] +
                                              qgroup[0][2]
                                        ];
                                        letters3 = [
                                          qgroup[0][0] +
                                              qgroup[0][1] +
                                              qgroup[0][2] +
                                              qgroup[0][3]
                                        ];
                                        letters4 = [
                                          qgroup[0][0] +
                                              qgroup[0][1] +
                                              qgroup[0][2] +
                                              qgroup[0][3] +
                                              qgroup[0][4]
                                        ];
                                        return Column(children: [
                                          ListTile(
                                            shape: const Border(
                                              bottom: BorderSide(
                                                  width: 2, color: Colors.teal),
                                            ),
                                            title: Text(
                                              "${qgroup[index][0].toUpperCase()} - ${listTileText(index)}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.teal),
                                            ),
                                            trailing: AnimatedRotation(
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              turns: customTileExpandedX[index],
                                              child: const Icon(
                                                  Icons.arrow_downward),
                                            ),
                                            onTap: () {
                                              if (openTiles
                                                  .contains(qgroup[index][0])) {
                                                setState(() {
                                                  openTiles
                                                      .remove(qgroup[index][0]);
                                                  customTileExpandedX[index] -=
                                                      0.5;
                                                });
                                              } else {
                                                setState(() {
                                                  openTiles.add(qgroup[index][0]);
                                                  customTileExpandedX[index] +=
                                                      0.5;
                                                });
                                              }
                                            },
                                            visualDensity:
                                                const VisualDensity(vertical: 0),
                                          ),
                                          openTiles.contains(qgroup[index][0])
                                              ? Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 15),
                                                  child: ListTile(
                                                    shape: const Border(
                                                      bottom: BorderSide(
                                                          width: 2,
                                                          color: Colors.teal),
                                                    ),
                                                    title: Text(
                                                      ('${qgroup[index][0] + qgroup[index][1] + qgroup[index][2].toUpperCase()} - ${listTileText2(index)}'),
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.teal),
                                                    ),
                                                    trailing: AnimatedRotation(
                                                      duration: const Duration(
                                                          milliseconds: 200),
                                                      turns:
                                                          customTileExpandedX00[
                                                              index],
                                                      child: const Icon(
                                                          Icons.arrow_downward),
                                                    ),
                                                    onTap: () {
                                                      if (openTiles.contains(
                                                          qgroup[index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2])) {
                                                        setState(() {
                                                          openTiles.remove(
                                                              qgroup[index][0] +
                                                                  qgroup[index]
                                                                      [1] +
                                                                  qgroup[index]
                                                                      [2]);
                                                          customTileExpandedX00[
                                                              index] -= 0.5;
                                                        });
                                                      } else {
                                                        setState(() {
                                                          openTiles.add(
                                                              qgroup[index][0] +
                                                                  qgroup[index]
                                                                      [1] +
                                                                  qgroup[index]
                                                                      [2]);
                                                          customTileExpandedX00[
                                                              index] += 0.5;
                                                        });
                                                      }
                                                    },
                                                    visualDensity:
                                                        const VisualDensity(
                                                            vertical: -4),
                                                  ),
                                                )
                                              : Container(),
                                          openTiles.contains(qgroup[index][0]) &&
                                                  openTiles.contains(qgroup[index]
                                                          [0] +
                                                      qgroup[index][1] +
                                                      qgroup[index][2])
                                              ? Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 40),
                                                  child: ListTile(
                                                    shape: const Border(
                                                      bottom: BorderSide(
                                                          width: 2,
                                                          color: Colors.teal),
                                                    ),
                                                    title: Text(
                                                      // ('${qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3].toUpperCase()} - ${listTileText3(index)}'),
        
                                                      ('${qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3].toUpperCase()} - ${listTileText3(index)}'),
        
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.teal),
                                                    ),
                                                    trailing: AnimatedRotation(
                                                      duration: const Duration(
                                                          milliseconds: 200),
                                                      turns:
                                                          customTileExpandedX00X[
                                                              index],
                                                      child: const Icon(
                                                          Icons.arrow_downward),
                                                    ),
                                                    onTap: () {
                                                      if (openTiles.contains(
                                                          qgroup[index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2] +
                                                              qgroup[index][3])) {
                                                        setState(() {
                                                          openTiles.remove(
                                                              qgroup[index][0] +
                                                                  qgroup[index]
                                                                      [1] +
                                                                  qgroup[index]
                                                                      [2] +
                                                                  qgroup[index]
                                                                      [3]);
                                                          customTileExpandedX00X[
                                                              index] -= 0.5;
                                                        });
                                                      } else {
                                                        setState(() {
                                                          openTiles.add(
                                                              qgroup[index][0] +
                                                                  qgroup[index]
                                                                      [1] +
                                                                  qgroup[index]
                                                                      [2] +
                                                                  qgroup[index]
                                                                      [3]);
                                                          customTileExpandedX00X[
                                                              index] += 0.5;
                                                        });
                                                      }
                                                    },
                                                    visualDensity:
                                                        const VisualDensity(
                                                            vertical: -4),
                                                  ),
                                                )
                                              : Container(),
                                          openTiles.contains(qgroup[index][0]) &&
                                                  openTiles.contains(qgroup[index]
                                                          [0] +
                                                      qgroup[index][1] +
                                                      qgroup[index][2]) &&
                                                  openTiles.contains(qgroup[index]
                                                          [0] +
                                                      qgroup[index][1] +
                                                      qgroup[index][2] +
                                                      qgroup[index][3])
                                              ? Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 65),
                                                  child: ListTile(
                                                    shape: const Border(
                                                      bottom: BorderSide(
                                                          width: 2,
                                                          color: Colors.teal),
                                                    ),
                                                    title: Text(
(qgroup[index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2] +
                                                              qgroup[index][3] +
                                                              qgroup[index][4])
                                                          .toUpperCase(),                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.teal),
                                                    ),
                                                    trailing: AnimatedRotation(
                                                      duration: const Duration(
                                                          milliseconds: 200),
                                                      turns:
                                                          customTileExpandedX00XX[
                                                              index],
                                                      child: const Icon(
                                                          Icons.arrow_downward),
                                                    ),
                                                    onTap: () {
                                                      if (openTiles.contains(
                                                          qgroup[index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2] +
                                                              qgroup[index][3] +
                                                              qgroup[index][4])) {
                                                        setState(() {
                                                          openTiles.remove(qgroup[
                                                                  index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2] +
                                                              qgroup[index][3] +
                                                              qgroup[index][4]);
                                                          customTileExpandedX00XX[
                                                              index] -= 0.5;
                                                        });
                                                      } else {
                                                        setState(() {
                                                          openTiles.add(qgroup[
                                                                  index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2] +
                                                              qgroup[index][3] +
                                                              qgroup[index][4]);
                                                          customTileExpandedX00XX[
                                                              index] += 0.5;
                                                        });
                                                      }
                                                    },
                                                    visualDensity:
                                                        const VisualDensity(
                                                            vertical: -4),
                                                  ),
                                                )
                                              : Container(),
                                          openTiles.contains(qgroup[index][0]) &&
                                                  openTiles.contains(qgroup[index]
                                                          [0] +
                                                      qgroup[index][1] +
                                                      qgroup[index][2]) &&
                                                  openTiles.contains(qgroup[index]
                                                          [0] +
                                                      qgroup[index][1] +
                                                      qgroup[index][2] +
                                                      qgroup[index][3]) &&
                                                  openTiles.contains(qgroup[index]
                                                          [0] +
                                                      qgroup[index][1] +
                                                      qgroup[index][2] +
                                                      qgroup[index][3] +
                                                      qgroup[index][4])
                                              ? Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 60),
                                                  child: Card(
                                                    child: ExpansionTile(
                                                      title: Text(qdrugList[index]
                                                                  [0]
                                                              .toUpperCase() +
                                                          qdrugList[index]
                                                              .substring(1)),
                                                      subtitle: Text(
                                                          'Группа ${qgroup[index]}'),
                                                      trailing: AnimatedRotation(
                                                        duration: const Duration(
                                                            milliseconds: 200),
                                                        turns: customTileExpanded[
                                                            index],
                                                        child: const Icon(
                                                            Icons.arrow_downward),
                                                      ),
                                                      onExpansionChanged:
                                                          (bool expanded) {
                                                        if (expanded == true) {
                                                          setState(() =>
                                                              customTileExpanded[
                                                                  index] += 0.5);
                                                        } else {
                                                          setState(() =>
                                                              customTileExpanded[
                                                                  index] -= 0.5);
                                                        }
                                                      },
                                                      children: <Widget>[
                                                        qpd[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Фармакодинамика'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qpd[index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qpk[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Фармакокинетика'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qpk[index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qindications[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Показания'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qindications[
                                                                            index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qsideEffects[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Побочные Эффекты'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qsideEffects[
                                                                            index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qcontraIndications[
                                                                    index] !=
                                                                ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Противопоказания'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qcontraIndications[
                                                                            index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qpregnancy[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Беременность'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qpregnancy[
                                                                            index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qliver[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Печень'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qliver[index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qkidney[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Почки'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qkidney[index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qchildren[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Для детей'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qchildren[
                                                                            index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qelders[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Для пожилых людей'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qelders[index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qnotice[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Замечания'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qnotice[index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qoverdose[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Передозировка препарата'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qoverdose[
                                                                            index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            
                                                            : Container(),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        ]);
                                      } else if (letters[letters.length - 1]
                                              .toLowerCase() !=
                                          qgroup[index][0].toLowerCase()) {
                                        letters.add(qgroup[index][0]);
                                        letters2.add(qgroup[index][0] +
                                            qgroup[index][1] +
                                            qgroup[index][2]);
                                        letters3.add(qgroup[index][0] +
                                            qgroup[index][1] +
                                            qgroup[index][2] +
                                            qgroup[index][3]);
                                        letters4.add(qgroup[index][0] +
                                            qgroup[index][1] +
                                            qgroup[index][2] +
                                            qgroup[index][3] +
                                            qgroup[index][4]);
                                        return Column(children: [
                                          ListTile(
                                            shape: const Border(
                                              bottom: BorderSide(
                                                  width: 2, color: Colors.teal),
                                            ),
                                            title: Text(
                                              "${qgroup[index][0].toUpperCase()} - ${listTileText(index)}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.teal),
                                            ),
                                            trailing: AnimatedRotation(
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              turns: customTileExpandedX[index],
                                              child: const Icon(
                                                  Icons.arrow_downward),
                                            ),
                                            onTap: () {
                                              if (openTiles
                                                  .contains(qgroup[index][0])) {
                                                setState(() {
                                                  openTiles
                                                      .remove(qgroup[index][0]);
                                                  customTileExpandedX[index] -=
                                                      0.5;
                                                });
                                              } else {
                                                setState(() {
                                                  openTiles.add(qgroup[index][0]);
                                                  customTileExpandedX[index] +=
                                                      0.5;
                                                });
                                              }
                                            },
                                            visualDensity:
                                                const VisualDensity(vertical: 2),
                                          ),
                                          openTiles.contains(qgroup[index][0])
                                              ? Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 15),
                                                  child: ListTile(
                                                    shape: const Border(
                                                      bottom: BorderSide(
                                                          width: 2,
                                                          color: Colors.teal),
                                                    ),
                                                    title: Text(
                                                      ('${qgroup[index][0] + qgroup[index][1] + qgroup[index][2].toUpperCase()} - ${listTileText2(index)}'),
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.teal),
                                                    ),
                                                    trailing: AnimatedRotation(
                                                      duration: const Duration(
                                                          milliseconds: 200),
                                                      turns:
                                                          customTileExpandedX00[
                                                              index],
                                                      child: const Icon(
                                                          Icons.arrow_downward),
                                                    ),
                                                    onTap: () {
                                                      if (openTiles.contains(
                                                          qgroup[index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2])) {
                                                        setState(() {
                                                          openTiles.remove(
                                                              qgroup[index][0] +
                                                                  qgroup[index]
                                                                      [1] +
                                                                  qgroup[index]
                                                                      [2]);
                                                          customTileExpandedX00[
                                                              index] -= 0.5;
                                                        });
                                                      } else {
                                                        setState(() {
                                                          openTiles.add(
                                                              qgroup[index][0] +
                                                                  qgroup[index]
                                                                      [1] +
                                                                  qgroup[index]
                                                                      [2]);
                                                          customTileExpandedX00[
                                                              index] += 0.5;
                                                        });
                                                      }
                                                    },
                                                    visualDensity:
                                                        const VisualDensity(
                                                            vertical: -4),
                                                  ),
                                                )
                                              : Container(),
                                          openTiles.contains(qgroup[index][0]) &&
                                                  openTiles.contains(qgroup[index]
                                                          [0] +
                                                      qgroup[index][1] +
                                                      qgroup[index][2])
                                              ? Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 40),
                                                  child: ListTile(
                                                    shape: const Border(
                                                      bottom: BorderSide(
                                                          width: 2,
                                                          color: Colors.teal),
                                                    ),
                                                    title: Text(
                                                      ('${qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3].toUpperCase()} - ${listTileText3(index)}'),
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.teal),
                                                    ),
                                                    trailing: AnimatedRotation(
                                                      duration: const Duration(
                                                          milliseconds: 200),
                                                      turns:
                                                          customTileExpandedX00X[
                                                              index],
                                                      child: const Icon(
                                                          Icons.arrow_downward),
                                                    ),
                                                    onTap: () {
                                                      if (openTiles.contains(
                                                          qgroup[index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2] +
                                                              qgroup[index][3])) {
                                                        setState(() {
                                                          openTiles.remove(
                                                              qgroup[index][0] +
                                                                  qgroup[index]
                                                                      [1] +
                                                                  qgroup[index]
                                                                      [2] +
                                                                  qgroup[index]
                                                                      [3]);
                                                          customTileExpandedX00X[
                                                              index] -= 0.5;
                                                        });
                                                      } else {
                                                        setState(() {
                                                          openTiles.add(
                                                              qgroup[index][0] +
                                                                  qgroup[index]
                                                                      [1] +
                                                                  qgroup[index]
                                                                      [2] +
                                                                  qgroup[index]
                                                                      [3]);
                                                          customTileExpandedX00X[
                                                              index] += 0.5;
                                                        });
                                                      }
                                                    },
                                                    visualDensity:
                                                        const VisualDensity(
                                                            vertical: -4),
                                                  ),
                                                )
                                              : Container(),
                                          openTiles.contains(qgroup[index][0]) &&
                                                  openTiles.contains(qgroup[index]
                                                          [0] +
                                                      qgroup[index][1] +
                                                      qgroup[index][2]) &&
                                                  openTiles.contains(qgroup[index]
                                                          [0] +
                                                      qgroup[index][1] +
                                                      qgroup[index][2] +
                                                      qgroup[index][3])
                                              ? Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 65),
                                                  child: ListTile(
                                                    shape: const Border(
                                                      bottom: BorderSide(
                                                          width: 2,
                                                          color: Colors.teal),
                                                    ),
                                                    title: Text(
(qgroup[index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2] +
                                                              qgroup[index][3] +
                                                              qgroup[index][4])
                                                          .toUpperCase(),                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.teal),
                                                    ),
                                                    trailing: AnimatedRotation(
                                                      duration: const Duration(
                                                          milliseconds: 200),
                                                      turns:
                                                          customTileExpandedX00XX[
                                                              index],
                                                      child: const Icon(
                                                          Icons.arrow_downward),
                                                    ),
                                                    onTap: () {
                                                      if (openTiles.contains(
                                                          qgroup[index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2] +
                                                              qgroup[index][3] +
                                                              qgroup[index][4])) {
                                                        setState(() {
                                                          openTiles.remove(qgroup[
                                                                  index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2] +
                                                              qgroup[index][3] +
                                                              qgroup[index][4]);
                                                          customTileExpandedX00XX[
                                                              index] -= 0.5;
                                                        });
                                                      } else {
                                                        setState(() {
                                                          openTiles.add(qgroup[
                                                                  index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2] +
                                                              qgroup[index][3] +
                                                              qgroup[index][4]);
                                                          customTileExpandedX00XX[
                                                              index] += 0.5;
                                                        });
                                                      }
                                                    },
                                                    visualDensity:
                                                        const VisualDensity(
                                                            vertical: -4),
                                                  ),
                                                )
                                              : Container(),
                                          openTiles.contains(qgroup[index][0]) &&
                                                  openTiles.contains(qgroup[index]
                                                          [0] +
                                                      qgroup[index][1] +
                                                      qgroup[index][2]) &&
                                                  openTiles.contains(qgroup[index]
                                                          [0] +
                                                      qgroup[index][1] +
                                                      qgroup[index][2] +
                                                      qgroup[index][3]) &&
                                                  openTiles.contains(qgroup[index]
                                                          [0] +
                                                      qgroup[index][1] +
                                                      qgroup[index][2] +
                                                      qgroup[index][3] +
                                                      qgroup[index][4])
                                              ? Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 60),
                                                  child: Card(
                                                    child: ExpansionTile(
                                                      title: Text(qdrugList[index]
                                                                  [0]
                                                              .toUpperCase() +
                                                          qdrugList[index]
                                                              .substring(1)),
                                                      subtitle: Text(
                                                          'Группа ${qgroup[index]}'),
                                                      trailing: AnimatedRotation(
                                                        duration: const Duration(
                                                            milliseconds: 200),
                                                        turns: customTileExpanded[
                                                            index],
                                                        child: const Icon(
                                                            Icons.arrow_downward),
                                                      ),
                                                      onExpansionChanged:
                                                          (bool expanded) {
                                                        if (expanded == true) {
                                                          setState(() =>
                                                              customTileExpanded[
                                                                  index] += 0.5);
                                                        } else {
                                                          setState(() =>
                                                              customTileExpanded[
                                                                  index] -= 0.5);
                                                        }
                                                      },
                                                      children: <Widget>[
                                                        qpd[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Фармакодинамика'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qpd[index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qpk[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Фармакокинетика'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qpk[index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qindications[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Показания'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qindications[
                                                                            index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qsideEffects[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Побочные Эффекты'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qsideEffects[
                                                                            index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qcontraIndications[
                                                                    index] !=
                                                                ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Противопоказания'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qcontraIndications[
                                                                            index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qpregnancy[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Беременность'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qpregnancy[
                                                                            index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qliver[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Печень'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qliver[index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qkidney[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Почки'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qkidney[index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qchildren[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Для детей'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qchildren[
                                                                            index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qelders[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Для пожилых людей'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qelders[index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qnotice[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Замечания'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qnotice[index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            : Container(),
                                                        qoverdose[index] != ''
                                                            ? ExpansionTile(
                                                                title: const Text(
                                                                    'Передозировка препарата'),
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                    qoverdose[
                                                                            index]
                                                                        .replaceAll(
                                                                            RegExp(
                                                                                ' +'),
                                                                            " ")
                                                                        .replaceAll(
                                                                            "\t", "")
                                                                        .replaceAll(
                                                                            "\f", "")
                                                                        .replaceAll(
                                                                            "\r",
                                                                            "")
                                                                        .replaceAll(
                                                                            "\n ",
                                                                            "\n")
                                                                        .replaceAll(
                                                                            "\n",
                                                                            "\n\n")
                                                                        .trim(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  )),
                                                                ],
                                                              )
                                                            
                                                            : Container(),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        ]);
                                      } else {
                                        if (letters2[letters2.length - 1]
                                                .toLowerCase() !=
                                            (qgroup[index][0] +
                                                    qgroup[index][1] +
                                                    qgroup[index][2])
                                                .toLowerCase()) {
                                          letters2.add(qgroup[index][0] +
                                              qgroup[index][1] +
                                              qgroup[index][2]);
                                          letters3.add(qgroup[index][0] +
                                              qgroup[index][1] +
                                              qgroup[index][2] +
                                              qgroup[index][3]);
                                          letters4.add(qgroup[index][0] +
                                              qgroup[index][1] +
                                              qgroup[index][2] +
                                              qgroup[index][3] +
                                              qgroup[index][4]);
                                          return Column(children: [
                                            openTiles.contains(qgroup[index][0])
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: ListTile(
                                                      shape: const Border(
                                                        bottom: BorderSide(
                                                            width: 2,
                                                            color: Colors.teal),
                                                      ),
                                                      title: Text(
                                                        ('${qgroup[index][0] + qgroup[index][1] + qgroup[index][2].toUpperCase()} - ${listTileText2(index)}'),
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.teal),
                                                      ),
                                                      trailing: AnimatedRotation(
                                                        duration: const Duration(
                                                            milliseconds: 200),
                                                        turns:
                                                            customTileExpandedX00[
                                                                index],
                                                        child: const Icon(
                                                            Icons.arrow_downward),
                                                      ),
                                                      onTap: () {
                                                        if (openTiles.contains(
                                                            qgroup[index][0] +
                                                                qgroup[index][1] +
                                                                qgroup[index]
                                                                    [2])) {
                                                          setState(() {
                                                            openTiles.remove(
                                                                qgroup[index][0] +
                                                                    qgroup[index]
                                                                        [1] +
                                                                    qgroup[index]
                                                                        [2]);
                                                            customTileExpandedX00[
                                                                index] -= 0.5;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            openTiles.add(
                                                                qgroup[index][0] +
                                                                    qgroup[index]
                                                                        [1] +
                                                                    qgroup[index]
                                                                        [2]);
                                                            customTileExpandedX00[
                                                                index] += 0.5;
                                                          });
                                                        }
                                                      },
                                                      visualDensity:
                                                          const VisualDensity(
                                                              vertical: -4),
                                                    ),
                                                  )
                                                : Container(),
                                            openTiles.contains(
                                                        qgroup[index][0]) &&
                                                    openTiles.contains(
                                                        qgroup[index][0] +
                                                            qgroup[index][1] +
                                                            qgroup[index][2])
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 40),
                                                    child: ListTile(
                                                      shape: const Border(
                                                        bottom: BorderSide(
                                                            width: 2,
                                                            color: Colors.teal),
                                                      ),
                                                      title: Text(
                                                        ('${qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3].toUpperCase()} - ${listTileText3(index)}'),
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.teal),
                                                      ),
                                                      trailing: AnimatedRotation(
                                                        duration: const Duration(
                                                            milliseconds: 200),
                                                        turns:
                                                            customTileExpandedX00X[
                                                                index],
                                                        child: const Icon(
                                                            Icons.arrow_downward),
                                                      ),
                                                      onTap: () {
                                                        if (openTiles.contains(
                                                            qgroup[index][0] +
                                                                qgroup[index][1] +
                                                                qgroup[index][2] +
                                                                qgroup[index]
                                                                    [3])) {
                                                          setState(() {
                                                            openTiles.remove(
                                                                qgroup[index][0] +
                                                                    qgroup[index]
                                                                        [1] +
                                                                    qgroup[index]
                                                                        [2] +
                                                                    qgroup[index]
                                                                        [3]);
                                                            customTileExpandedX00X[
                                                                index] -= 0.5;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            openTiles.add(
                                                                qgroup[index][0] +
                                                                    qgroup[index]
                                                                        [1] +
                                                                    qgroup[index]
                                                                        [2] +
                                                                    qgroup[index]
                                                                        [3]);
                                                            customTileExpandedX00X[
                                                                index] += 0.5;
                                                          });
                                                        }
                                                      },
                                                      visualDensity:
                                                          const VisualDensity(
                                                              vertical: -4),
                                                    ),
                                                  )
                                                : Container(),
                                            openTiles.contains(
                                                        qgroup[index][0]) &&
                                                    openTiles.contains(
                                                        qgroup[index][0] +
                                                            qgroup[index][1] +
                                                            qgroup[index][2]) &&
                                                    openTiles.contains(
                                                        qgroup[index][0] +
                                                            qgroup[index][1] +
                                                            qgroup[index][2] +
                                                            qgroup[index][3])
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 65),
                                                    child: ListTile(
                                                      shape: const Border(
                                                        bottom: BorderSide(
                                                            width: 2,
                                                            color: Colors.teal),
                                                      ),
                                                      title: Text(
(qgroup[index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2] +
                                                              qgroup[index][3] +
                                                              qgroup[index][4])
                                                          .toUpperCase(),                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.teal),
                                                      ),
                                                      trailing: AnimatedRotation(
                                                        duration: const Duration(
                                                            milliseconds: 200),
                                                        turns:
                                                            customTileExpandedX00XX[
                                                                index],
                                                        child: const Icon(
                                                            Icons.arrow_downward),
                                                      ),
                                                      onTap: () {
                                                        if (openTiles.contains(
                                                            qgroup[index][0] +
                                                                qgroup[index][1] +
                                                                qgroup[index][2] +
                                                                qgroup[index][3] +
                                                                qgroup[index]
                                                                    [4])) {
                                                          setState(() {
                                                            openTiles.remove(
                                                                qgroup[index][0] +
                                                                    qgroup[index]
                                                                        [1] +
                                                                    qgroup[index]
                                                                        [2] +
                                                                    qgroup[index]
                                                                        [3] +
                                                                    qgroup[index]
                                                                        [4]);
                                                            customTileExpandedX00XX[
                                                                index] -= 0.5;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            openTiles.add(qgroup[
                                                                    index][0] +
                                                                qgroup[index][1] +
                                                                qgroup[index][2] +
                                                                qgroup[index][3] +
                                                                qgroup[index][4]);
                                                            customTileExpandedX00XX[
                                                                index] += 0.5;
                                                          });
                                                        }
                                                      },
                                                      visualDensity:
                                                          const VisualDensity(
                                                              vertical: -4),
                                                    ),
                                                  )
                                                : Container(),
                                            openTiles.contains(
                                                        qgroup[index][0]) &&
                                                    openTiles.contains(
                                                        qgroup[index][0] +
                                                            qgroup[index][1] +
                                                            qgroup[index][2]) &&
                                                    openTiles.contains(
                                                        qgroup[index][0] +
                                                            qgroup[index][1] +
                                                            qgroup[index][2] +
                                                            qgroup[index][3]) &&
                                                    openTiles.contains(
                                                        qgroup[index][0] +
                                                            qgroup[index][1] +
                                                            qgroup[index][2] +
                                                            qgroup[index][3] +
                                                            qgroup[index][4])
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 60),
                                                    child: Card(
                                                      child: ExpansionTile(
                                                        title: Text(qdrugList[
                                                                    index][0]
                                                                .toUpperCase() +
                                                            qdrugList[index]
                                                                .substring(1)),
                                                        subtitle: Text(
                                                            'Группа ${qgroup[index]}'),
                                                        trailing:
                                                            AnimatedRotation(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      200),
                                                          turns:
                                                              customTileExpanded[
                                                                  index],
                                                          child: const Icon(Icons
                                                              .arrow_downward),
                                                        ),
                                                        onExpansionChanged:
                                                            (bool expanded) {
                                                          if (expanded == true) {
                                                            setState(() =>
                                                                customTileExpanded[
                                                                        index] +=
                                                                    0.5);
                                                          } else {
                                                            setState(() =>
                                                                customTileExpanded[
                                                                        index] -=
                                                                    0.5);
                                                          }
                                                        },
                                                        children: <Widget>[
                                                          qpd[index] != ''
                                                              ? ExpansionTile(
                                                                  title: const Text(
                                                                      'Фармакодинамика'),
                                                                  children: [
                                                                    ListTile(
                                                                        title:
                                                                            Text(
                                                                      qpd[index]
                                                                          .replaceAll(
                                                                              RegExp(
                                                                                  ' +'),
                                                                              " ")
                                                                          .replaceAll(
                                                                              "\t", "")
                                                                          .replaceAll(
                                                                              "\f", "")
                                                                          .replaceAll(
                                                                              "\r", "")
                                                                          .replaceAll(
                                                                              "\n ",
                                                                              "\n")
                                                                          .replaceAll(
                                                                              "\n",
                                                                              "\n\n")
                                                                          .trim(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .justify,
                                                                    )),
                                                                  ],
                                                                )
                                                              : Container(),
                                                          qpk[index] != ''
                                                              ? ExpansionTile(
                                                                  title: const Text(
                                                                      'Фармакокинетика'),
                                                                  children: [
                                                                    ListTile(
                                                                        title:
                                                                            Text(
                                                                      qpk[index]
                                                                          .replaceAll(
                                                                              RegExp(
                                                                                  ' +'),
                                                                              " ")
                                                                          .replaceAll(
                                                                              "\t", "")
                                                                          .replaceAll(
                                                                              "\f", "")
                                                                          .replaceAll(
                                                                              "\r", "")
                                                                          .replaceAll(
                                                                              "\n ",
                                                                              "\n")
                                                                          .replaceAll(
                                                                              "\n",
                                                                              "\n\n")
                                                                          .trim(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .justify,
                                                                    )),
                                                                  ],
                                                                )
                                                              : Container(),
                                                          qindications[index] !=
                                                                  ''
                                                              ? ExpansionTile(
                                                                  title: const Text(
                                                                      'Показания'),
                                                                  children: [
                                                                    ListTile(
                                                                        title:
                                                                            Text(
                                                                      qindications[
                                                                              index]
                                                                          .replaceAll(
                                                                              RegExp(
                                                                                  ' +'),
                                                                              " ")
                                                                          .replaceAll(
                                                                              "\t", "")
                                                                          .replaceAll(
                                                                              "\f", "")
                                                                          .replaceAll(
                                                                              "\r", "")
                                                                          .replaceAll(
                                                                              "\n ",
                                                                              "\n")
                                                                          .replaceAll(
                                                                              "\n",
                                                                              "\n\n")
                                                                          .trim(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .justify,
                                                                    )),
                                                                  ],
                                                                )
                                                              : Container(),
                                                          qsideEffects[index] !=
                                                                  ''
                                                              ? ExpansionTile(
                                                                  title: const Text(
                                                                      'Побочные Эффекты'),
                                                                  children: [
                                                                    ListTile(
                                                                        title:
                                                                            Text(
                                                                      qsideEffects[
                                                                              index]
                                                                          .replaceAll(
                                                                              RegExp(
                                                                                  ' +'),
                                                                              " ")
                                                                          .replaceAll(
                                                                              "\t", "")
                                                                          .replaceAll(
                                                                              "\f", "")
                                                                          .replaceAll(
                                                                              "\r", "")
                                                                          .replaceAll(
                                                                              "\n ",
                                                                              "\n")
                                                                          .replaceAll(
                                                                              "\n",
                                                                              "\n\n")
                                                                          .trim(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .justify,
                                                                    )),
                                                                  ],
                                                                )
                                                              : Container(),
                                                          qcontraIndications[
                                                                      index] !=
                                                                  ''
                                                              ? ExpansionTile(
                                                                  title: const Text(
                                                                      'Противопоказания'),
                                                                  children: [
                                                                    ListTile(
                                                                        title:
                                                                            Text(
                                                                      qcontraIndications[
                                                                              index]
                                                                          .replaceAll(
                                                                              RegExp(
                                                                                  ' +'),
                                                                              " ")
                                                                          .replaceAll(
                                                                              "\t", "")
                                                                          .replaceAll(
                                                                              "\f", "")
                                                                          .replaceAll(
                                                                              "\r", "")
                                                                          .replaceAll(
                                                                              "\n ",
                                                                              "\n")
                                                                          .replaceAll(
                                                                              "\n",
                                                                              "\n\n")
                                                                          .trim(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .justify,
                                                                    )),
                                                                  ],
                                                                )
                                                              : Container(),
                                                          qpregnancy[index] != ''
                                                              ? ExpansionTile(
                                                                  title: const Text(
                                                                      'Беременность'),
                                                                  children: [
                                                                    ListTile(
                                                                        title:
                                                                            Text(
                                                                      qpregnancy[
                                                                              index]
                                                                          .replaceAll(
                                                                              RegExp(
                                                                                  ' +'),
                                                                              " ")
                                                                          .replaceAll(
                                                                              "\t", "")
                                                                          .replaceAll(
                                                                              "\f", "")
                                                                          .replaceAll(
                                                                              "\r", "")
                                                                          .replaceAll(
                                                                              "\n ",
                                                                              "\n")
                                                                          .replaceAll(
                                                                              "\n",
                                                                              "\n\n")
                                                                          .trim(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .justify,
                                                                    )),
                                                                  ],
                                                                )
                                                              : Container(),
                                                          qliver[index] != ''
                                                              ? ExpansionTile(
                                                                  title: const Text(
                                                                      'Печень'),
                                                                  children: [
                                                                    ListTile(
                                                                        title:
                                                                            Text(
                                                                      qliver[index]
                                                                          .replaceAll(
                                                                              RegExp(
                                                                                  ' +'),
                                                                              " ")
                                                                          .replaceAll(
                                                                              "\t", "")
                                                                          .replaceAll(
                                                                              "\f", "")
                                                                          .replaceAll(
                                                                              "\r", "")
                                                                          .replaceAll(
                                                                              "\n ",
                                                                              "\n")
                                                                          .replaceAll(
                                                                              "\n",
                                                                              "\n\n")
                                                                          .trim(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .justify,
                                                                    )),
                                                                  ],
                                                                )
                                                              : Container(),
                                                          qkidney[index] != ''
                                                              ? ExpansionTile(
                                                                  title:
                                                                      const Text(
                                                                          'Почки'),
                                                                  children: [
                                                                    ListTile(
                                                                        title:
                                                                            Text(
                                                                      qkidney[index]
                                                                          .replaceAll(
                                                                              RegExp(
                                                                                  ' +'),
                                                                              " ")
                                                                          .replaceAll(
                                                                              "\t", "")
                                                                          .replaceAll(
                                                                              "\f", "")
                                                                          .replaceAll(
                                                                              "\r", "")
                                                                          .replaceAll(
                                                                              "\n ",
                                                                              "\n")
                                                                          .replaceAll(
                                                                              "\n",
                                                                              "\n\n")
                                                                          .trim(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .justify,
                                                                    )),
                                                                  ],
                                                                )
                                                              : Container(),
                                                          qchildren[index] != ''
                                                              ? ExpansionTile(
                                                                  title: const Text(
                                                                      'Для детей'),
                                                                  children: [
                                                                    ListTile(
                                                                        title:
                                                                            Text(
                                                                      qchildren[
                                                                              index]
                                                                          .replaceAll(
                                                                              RegExp(
                                                                                  ' +'),
                                                                              " ")
                                                                          .replaceAll(
                                                                              "\t", "")
                                                                          .replaceAll(
                                                                              "\f", "")
                                                                          .replaceAll(
                                                                              "\r", "")
                                                                          .replaceAll(
                                                                              "\n ",
                                                                              "\n")
                                                                          .replaceAll(
                                                                              "\n",
                                                                              "\n\n")
                                                                          .trim(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .justify,
                                                                    )),
                                                                  ],
                                                                )
                                                              : Container(),
                                                          qelders[index] != ''
                                                              ? ExpansionTile(
                                                                  title: const Text(
                                                                      'Для пожилых людей'),
                                                                  children: [
                                                                    ListTile(
                                                                        title:
                                                                            Text(
                                                                      qelders[index]
                                                                          .replaceAll(
                                                                              RegExp(
                                                                                  ' +'),
                                                                              " ")
                                                                          .replaceAll(
                                                                              "\t", "")
                                                                          .replaceAll(
                                                                              "\f", "")
                                                                          .replaceAll(
                                                                              "\r", "")
                                                                          .replaceAll(
                                                                              "\n ",
                                                                              "\n")
                                                                          .replaceAll(
                                                                              "\n",
                                                                              "\n\n")
                                                                          .trim(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .justify,
                                                                    )),
                                                                  ],
                                                                )
                                                              : Container(),
                                                          qnotice[index] != ''
                                                              ? ExpansionTile(
                                                                  title: const Text(
                                                                      'Замечания'),
                                                                  children: [
                                                                    ListTile(
                                                                        title:
                                                                            Text(
                                                                      qnotice[index]
                                                                          .replaceAll(
                                                                              RegExp(
                                                                                  ' +'),
                                                                              " ")
                                                                          .replaceAll(
                                                                              "\t", "")
                                                                          .replaceAll(
                                                                              "\f", "")
                                                                          .replaceAll(
                                                                              "\r", "")
                                                                          .replaceAll(
                                                                              "\n ",
                                                                              "\n")
                                                                          .replaceAll(
                                                                              "\n",
                                                                              "\n\n")
                                                                          .trim(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .justify,
                                                                    )),
                                                                  ],
                                                                )
                                                              : Container(),
                                                          qoverdose[index] != ''
                                                              ? ExpansionTile(
                                                                  title: const Text(
                                                                      'Передозировка препарата'),
                                                                  children: [
                                                                    ListTile(
                                                                        title:
                                                                            Text(
                                                                      qoverdose[
                                                                              index]
                                                                          .replaceAll(
                                                                              RegExp(
                                                                                  ' +'),
                                                                              " ")
                                                                          .replaceAll(
                                                                              "\t", "")
                                                                          .replaceAll(
                                                                              "\f", "")
                                                                          .replaceAll(
                                                                              "\r", "")
                                                                          .replaceAll(
                                                                              "\n ",
                                                                              "\n")
                                                                          .replaceAll(
                                                                              "\n",
                                                                              "\n\n")
                                                                          .trim(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .justify,
                                                                    )),
                                                                  ],
                                                                )
                                                              
                                                              : Container(),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                          ]);
                                        } else {
                                          if (letters3[letters3.length - 1]
                                                  .toLowerCase() !=
                                              (qgroup[index][0] +
                                                      qgroup[index][1] +
                                                      qgroup[index][2] +
                                                      qgroup[index][3])
                                                  .toLowerCase()) {
                                            letters3.add(qgroup[index][0] +
                                                qgroup[index][1] +
                                                qgroup[index][2] +
                                                qgroup[index][3]);
                                            letters4.add(qgroup[index][0] +
                                                qgroup[index][1] +
                                                qgroup[index][2] +
                                                qgroup[index][3] +
                                                qgroup[index][4]);
                                            return Column(children: [
                                              openTiles.contains(
                                                          qgroup[index][0]) &&
                                                      openTiles.contains(
                                                          qgroup[index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2])
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 40),
                                                      child: ListTile(
                                                        shape: const Border(
                                                          bottom: BorderSide(
                                                              width: 2,
                                                              color: Colors.teal),
                                                        ),
                                                        title: Text(
                                                          ('${qgroup[index][0] + qgroup[index][1] + qgroup[index][2] + qgroup[index][3].toUpperCase()} - ${listTileText3(index)}'),
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Colors.teal),
                                                        ),
                                                        trailing:
                                                            AnimatedRotation(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      200),
                                                          turns:
                                                              customTileExpandedX00X[
                                                                  index],
                                                          child: const Icon(Icons
                                                              .arrow_downward),
                                                        ),
                                                        onTap: () {
                                                          if (openTiles.contains(
                                                              qgroup[index][0] +
                                                                  qgroup[index]
                                                                      [1] +
                                                                  qgroup[index]
                                                                      [2] +
                                                                  qgroup[index]
                                                                      [3])) {
                                                            setState(() {
                                                              openTiles.remove(
                                                                  qgroup[index]
                                                                          [0] +
                                                                      qgroup[index]
                                                                          [1] +
                                                                      qgroup[index]
                                                                          [2] +
                                                                      qgroup[index]
                                                                          [3]);
                                                              customTileExpandedX00X[
                                                                  index] -= 0.5;
                                                            });
                                                          } else {
                                                            setState(() {
                                                              openTiles.add(qgroup[
                                                                      index][0] +
                                                                  qgroup[index]
                                                                      [1] +
                                                                  qgroup[index]
                                                                      [2] +
                                                                  qgroup[index]
                                                                      [3]);
                                                              customTileExpandedX00X[
                                                                  index] += 0.5;
                                                            });
                                                          }
                                                        },
                                                        visualDensity:
                                                            const VisualDensity(
                                                                vertical: -4),
                                                      ),
                                                    )
                                                  : Container(),
                                              openTiles.contains(
                                                          qgroup[index][0]) &&
                                                      openTiles.contains(
                                                          qgroup[index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2]) &&
                                                      openTiles.contains(
                                                          qgroup[index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2] +
                                                              qgroup[index][3])
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 65),
                                                      child: ListTile(
                                                        shape: const Border(
                                                          bottom: BorderSide(
                                                              width: 2,
                                                              color: Colors.teal),
                                                        ),
                                                        title: Text(
(qgroup[index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2] +
                                                              qgroup[index][3] +
                                                              qgroup[index][4])
                                                          .toUpperCase(),                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Colors.teal),
                                                        ),
                                                        trailing:
                                                            AnimatedRotation(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      200),
                                                          turns:
                                                              customTileExpandedX00XX[
                                                                  index],
                                                          child: const Icon(Icons
                                                              .arrow_downward),
                                                        ),
                                                        onTap: () {
                                                          if (openTiles.contains(
                                                              qgroup[index][0] +
                                                                  qgroup[index]
                                                                      [1] +
                                                                  qgroup[index]
                                                                      [2] +
                                                                  qgroup[index]
                                                                      [3] +
                                                                  qgroup[index]
                                                                      [4])) {
                                                            setState(() {
                                                              openTiles.remove(
                                                                  qgroup[index]
                                                                          [0] +
                                                                      qgroup[index]
                                                                          [1] +
                                                                      qgroup[index]
                                                                          [2] +
                                                                      qgroup[index]
                                                                          [3] +
                                                                      qgroup[index]
                                                                          [4]);
                                                              customTileExpandedX00XX[
                                                                  index] -= 0.5;
                                                            });
                                                          } else {
                                                            setState(() {
                                                              openTiles.add(qgroup[
                                                                      index][0] +
                                                                  qgroup[index]
                                                                      [1] +
                                                                  qgroup[index]
                                                                      [2] +
                                                                  qgroup[index]
                                                                      [3] +
                                                                  qgroup[index]
                                                                      [4]);
                                                              customTileExpandedX00XX[
                                                                  index] += 0.5;
                                                            });
                                                          }
                                                        },
                                                        visualDensity:
                                                            const VisualDensity(
                                                                vertical: -4),
                                                      ),
                                                    )
                                                  : Container(),
                                              openTiles.contains(
                                                          qgroup[index][0]) &&
                                                      openTiles.contains(
                                                          qgroup[index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2]) &&
                                                      openTiles.contains(
                                                          qgroup[index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2] +
                                                              qgroup[index][3]) &&
                                                      openTiles.contains(
                                                          qgroup[index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2] +
                                                              qgroup[index][3] +
                                                              qgroup[index][4])
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 60),
                                                      child: Card(
                                                        child: ExpansionTile(
                                                          title: Text(qdrugList[
                                                                      index][0]
                                                                  .toUpperCase() +
                                                              qdrugList[index]
                                                                  .substring(1)),
                                                          subtitle: Text(
                                                              'Группа ${qgroup[index]}'),
                                                          trailing:
                                                              AnimatedRotation(
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        200),
                                                            turns:
                                                                customTileExpanded[
                                                                    index],
                                                            child: const Icon(Icons
                                                                .arrow_downward),
                                                          ),
                                                          onExpansionChanged:
                                                              (bool expanded) {
                                                            if (expanded ==
                                                                true) {
                                                              setState(() =>
                                                                  customTileExpanded[
                                                                          index] +=
                                                                      0.5);
                                                            } else {
                                                              setState(() =>
                                                                  customTileExpanded[
                                                                          index] -=
                                                                      0.5);
                                                            }
                                                          },
                                                          children: <Widget>[
                                                            qpd[index] != ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Фармакодинамика'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qpd[index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qpk[index] != ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Фармакокинетика'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qpk[index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qindications[index] !=
                                                                    ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Показания'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qindications[
                                                                                index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qsideEffects[index] !=
                                                                    ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Побочные Эффекты'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qsideEffects[
                                                                                index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qcontraIndications[
                                                                        index] !=
                                                                    ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Противопоказания'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qcontraIndications[
                                                                                index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qpregnancy[index] !=
                                                                    ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Беременность'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qpregnancy[
                                                                                index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qliver[index] != ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Печень'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qliver[index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qkidney[index] != ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Почки'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qkidney[index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qchildren[index] != ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Для детей'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qchildren[
                                                                                index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qelders[index] != ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Для пожилых людей'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qelders[index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qnotice[index] != ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Замечания'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qnotice[index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qoverdose[index] != ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Передозировка препарата'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qoverdose[
                                                                                index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                
                                                                : Container(),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                            ]);
                                          } else {
                                            if (letters4[letters4.length - 1]
                                                    .toLowerCase() !=
                                                (qgroup[index][0] +
                                                        qgroup[index][1] +
                                                        qgroup[index][2] +
                                                        qgroup[index][3] +
                                                        qgroup[index][4])
                                                    .toLowerCase()) {
                                              letters4.add(qgroup[index][0] +
                                                  qgroup[index][1] +
                                                  qgroup[index][2] +
                                                  qgroup[index][3] +
                                                  qgroup[index][4]);
                                              return Column(children: [
                                                openTiles.contains(
                                                            qgroup[index][0]) &&
                                                        openTiles.contains(
                                                            qgroup[index][0] +
                                                                qgroup[index][1] +
                                                                qgroup[index]
                                                                    [2]) &&
                                                        openTiles.contains(
                                                            qgroup[index][0] +
                                                                qgroup[index][1] +
                                                                qgroup[index][2] +
                                                                qgroup[index][3])
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                left: 65),
                                                        child: ListTile(
                                                          shape: const Border(
                                                            bottom: BorderSide(
                                                                width: 2,
                                                                color:
                                                                    Colors.teal),
                                                          ),
                                                          title: Text(
(qgroup[index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2] +
                                                              qgroup[index][3] +
                                                              qgroup[index][4])
                                                          .toUpperCase(),                                                            style:
                                                                const TextStyle(
                                                                    fontSize: 18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .teal),
                                                          ),
                                                          trailing:
                                                              AnimatedRotation(
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        200),
                                                            turns:
                                                                customTileExpandedX00XX[
                                                                    index],
                                                            child: const Icon(Icons
                                                                .arrow_downward),
                                                          ),
                                                          onTap: () {
                                                            if (openTiles
                                                                .contains(qgroup[
                                                                            index]
                                                                        [0] +
                                                                    qgroup[index]
                                                                        [1] +
                                                                    qgroup[index]
                                                                        [2] +
                                                                    qgroup[index]
                                                                        [3] +
                                                                    qgroup[index]
                                                                        [4])) {
                                                              setState(() {
                                                                openTiles.remove(qgroup[
                                                                            index]
                                                                        [0] +
                                                                    qgroup[index]
                                                                        [1] +
                                                                    qgroup[index]
                                                                        [2] +
                                                                    qgroup[index]
                                                                        [3] +
                                                                    qgroup[index]
                                                                        [4]);
                                                                customTileExpandedX00XX[
                                                                    index] -= 0.5;
                                                              });
                                                            } else {
                                                              setState(() {
                                                                openTiles.add(qgroup[
                                                                            index]
                                                                        [0] +
                                                                    qgroup[index]
                                                                        [1] +
                                                                    qgroup[index]
                                                                        [2] +
                                                                    qgroup[index]
                                                                        [3] +
                                                                    qgroup[index]
                                                                        [4]);
                                                                customTileExpandedX00XX[
                                                                    index] += 0.5;
                                                              });
                                                            }
                                                          },
                                                          visualDensity:
                                                              const VisualDensity(
                                                                  vertical: -4),
                                                        ),
                                                      )
                                                    : Container(),
                                                openTiles.contains(
                                                            qgroup[index][0]) &&
                                                        openTiles.contains(
                                                            qgroup[index][0] +
                                                                qgroup[index][1] +
                                                                qgroup[index]
                                                                    [2]) &&
                                                        openTiles.contains(
                                                            qgroup[index][0] +
                                                                qgroup[index][1] +
                                                                qgroup[index][2] +
                                                                qgroup[index]
                                                                    [3]) &&
                                                        openTiles.contains(
                                                            qgroup[index][0] +
                                                                qgroup[index][1] +
                                                                qgroup[index][2] +
                                                                qgroup[index][3] +
                                                                qgroup[index][4])
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                left: 60),
                                                        child: Card(
                                                          child: ExpansionTile(
                                                            title: Text(qdrugList[
                                                                        index][0]
                                                                    .toUpperCase() +
                                                                qdrugList[index]
                                                                    .substring(
                                                                        1)),
                                                            subtitle: Text(
                                                                'Группа ${qgroup[index]}'),
                                                            trailing:
                                                                AnimatedRotation(
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          200),
                                                              turns:
                                                                  customTileExpanded[
                                                                      index],
                                                              child: const Icon(Icons
                                                                  .arrow_downward),
                                                            ),
                                                            onExpansionChanged:
                                                                (bool expanded) {
                                                              if (expanded ==
                                                                  true) {
                                                                setState(() =>
                                                                    customTileExpanded[
                                                                            index] +=
                                                                        0.5);
                                                              } else {
                                                                setState(() =>
                                                                    customTileExpanded[
                                                                            index] -=
                                                                        0.5);
                                                              }
                                                            },
                                                            children: <Widget>[
                                                              qpd[index] != ''
                                                                  ? ExpansionTile(
                                                                      title: const Text(
                                                                          'Фармакодинамика'),
                                                                      children: [
                                                                        ListTile(
                                                                            title:
                                                                                Text(
                                                                          qpd[index]
                                                                              .replaceAll(
                                                                                  RegExp(
                                                                                      ' +'),
                                                                                  " ")
                                                                              .replaceAll("\t",
                                                                                  "")
                                                                              .replaceAll("\f",
                                                                                  "")
                                                                              .replaceAll("\r",
                                                                                  "")
                                                                              .replaceAll("\n ",
                                                                                  "\n")
                                                                              .replaceAll("\n",
                                                                                  "\n\n")
                                                                              .trim(),
                                                                          textAlign:
                                                                              TextAlign.justify,
                                                                        )),
                                                                      ],
                                                                    )
                                                                  : Container(),
                                                              qpk[index] != ''
                                                                  ? ExpansionTile(
                                                                      title: const Text(
                                                                          'Фармакокинетика'),
                                                                      children: [
                                                                        ListTile(
                                                                            title:
                                                                                Text(
                                                                          qpk[index]
                                                                              .replaceAll(
                                                                                  RegExp(
                                                                                      ' +'),
                                                                                  " ")
                                                                              .replaceAll("\t",
                                                                                  "")
                                                                              .replaceAll("\f",
                                                                                  "")
                                                                              .replaceAll("\r",
                                                                                  "")
                                                                              .replaceAll("\n ",
                                                                                  "\n")
                                                                              .replaceAll("\n",
                                                                                  "\n\n")
                                                                              .trim(),
                                                                          textAlign:
                                                                              TextAlign.justify,
                                                                        )),
                                                                      ],
                                                                    )
                                                                  : Container(),
                                                              qindications[
                                                                          index] !=
                                                                      ''
                                                                  ? ExpansionTile(
                                                                      title: const Text(
                                                                          'Показания'),
                                                                      children: [
                                                                        ListTile(
                                                                            title:
                                                                                Text(
                                                                          qindications[index]
                                                                              .replaceAll(
                                                                                  RegExp(
                                                                                      ' +'),
                                                                                  " ")
                                                                              .replaceAll("\t",
                                                                                  "")
                                                                              .replaceAll("\f",
                                                                                  "")
                                                                              .replaceAll("\r",
                                                                                  "")
                                                                              .replaceAll("\n ",
                                                                                  "\n")
                                                                              .replaceAll("\n",
                                                                                  "\n\n")
                                                                              .trim(),
                                                                          textAlign:
                                                                              TextAlign.justify,
                                                                        )),
                                                                      ],
                                                                    )
                                                                  : Container(),
                                                              qsideEffects[
                                                                          index] !=
                                                                      ''
                                                                  ? ExpansionTile(
                                                                      title: const Text(
                                                                          'Побочные Эффекты'),
                                                                      children: [
                                                                        ListTile(
                                                                            title:
                                                                                Text(
                                                                          qsideEffects[index]
                                                                              .replaceAll(
                                                                                  RegExp(
                                                                                      ' +'),
                                                                                  " ")
                                                                              .replaceAll("\t",
                                                                                  "")
                                                                              .replaceAll("\f",
                                                                                  "")
                                                                              .replaceAll("\r",
                                                                                  "")
                                                                              .replaceAll("\n ",
                                                                                  "\n")
                                                                              .replaceAll("\n",
                                                                                  "\n\n")
                                                                              .trim(),
                                                                          textAlign:
                                                                              TextAlign.justify,
                                                                        )),
                                                                      ],
                                                                    )
                                                                  : Container(),
                                                              qcontraIndications[
                                                                          index] !=
                                                                      ''
                                                                  ? ExpansionTile(
                                                                      title: const Text(
                                                                          'Противопоказания'),
                                                                      children: [
                                                                        ListTile(
                                                                            title:
                                                                                Text(
                                                                          qcontraIndications[index]
                                                                              .replaceAll(
                                                                                  RegExp(
                                                                                      ' +'),
                                                                                  " ")
                                                                              .replaceAll("\t",
                                                                                  "")
                                                                              .replaceAll("\f",
                                                                                  "")
                                                                              .replaceAll("\r",
                                                                                  "")
                                                                              .replaceAll("\n ",
                                                                                  "\n")
                                                                              .replaceAll("\n",
                                                                                  "\n\n")
                                                                              .trim(),
                                                                          textAlign:
                                                                              TextAlign.justify,
                                                                        )),
                                                                      ],
                                                                    )
                                                                  : Container(),
                                                              qpregnancy[index] !=
                                                                      ''
                                                                  ? ExpansionTile(
                                                                      title: const Text(
                                                                          'Беременность'),
                                                                      children: [
                                                                        ListTile(
                                                                            title:
                                                                                Text(
                                                                          qpregnancy[index]
                                                                              .replaceAll(
                                                                                  RegExp(
                                                                                      ' +'),
                                                                                  " ")
                                                                              .replaceAll("\t",
                                                                                  "")
                                                                              .replaceAll("\f",
                                                                                  "")
                                                                              .replaceAll("\r",
                                                                                  "")
                                                                              .replaceAll("\n ",
                                                                                  "\n")
                                                                              .replaceAll("\n",
                                                                                  "\n\n")
                                                                              .trim(),
                                                                          textAlign:
                                                                              TextAlign.justify,
                                                                        )),
                                                                      ],
                                                                    )
                                                                  : Container(),
                                                              qliver[index] != ''
                                                                  ? ExpansionTile(
                                                                      title: const Text(
                                                                          'Печень'),
                                                                      children: [
                                                                        ListTile(
                                                                            title:
                                                                                Text(
                                                                          qliver[index]
                                                                              .replaceAll(
                                                                                  RegExp(
                                                                                      ' +'),
                                                                                  " ")
                                                                              .replaceAll("\t",
                                                                                  "")
                                                                              .replaceAll("\f",
                                                                                  "")
                                                                              .replaceAll("\r",
                                                                                  "")
                                                                              .replaceAll("\n ",
                                                                                  "\n")
                                                                              .replaceAll("\n",
                                                                                  "\n\n")
                                                                              .trim(),
                                                                          textAlign:
                                                                              TextAlign.justify,
                                                                        )),
                                                                      ],
                                                                    )
                                                                  : Container(),
                                                              qkidney[index] != ''
                                                                  ? ExpansionTile(
                                                                      title: const Text(
                                                                          'Почки'),
                                                                      children: [
                                                                        ListTile(
                                                                            title:
                                                                                Text(
                                                                          qkidney[index]
                                                                              .replaceAll(
                                                                                  RegExp(
                                                                                      ' +'),
                                                                                  " ")
                                                                              .replaceAll("\t",
                                                                                  "")
                                                                              .replaceAll("\f",
                                                                                  "")
                                                                              .replaceAll("\r",
                                                                                  "")
                                                                              .replaceAll("\n ",
                                                                                  "\n")
                                                                              .replaceAll("\n",
                                                                                  "\n\n")
                                                                              .trim(),
                                                                          textAlign:
                                                                              TextAlign.justify,
                                                                        )),
                                                                      ],
                                                                    )
                                                                  : Container(),
                                                              qchildren[index] !=
                                                                      ''
                                                                  ? ExpansionTile(
                                                                      title: const Text(
                                                                          'Для детей'),
                                                                      children: [
                                                                        ListTile(
                                                                            title:
                                                                                Text(
                                                                          qchildren[index]
                                                                              .replaceAll(
                                                                                  RegExp(
                                                                                      ' +'),
                                                                                  " ")
                                                                              .replaceAll("\t",
                                                                                  "")
                                                                              .replaceAll("\f",
                                                                                  "")
                                                                              .replaceAll("\r",
                                                                                  "")
                                                                              .replaceAll("\n ",
                                                                                  "\n")
                                                                              .replaceAll("\n",
                                                                                  "\n\n")
                                                                              .trim(),
                                                                          textAlign:
                                                                              TextAlign.justify,
                                                                        )),
                                                                      ],
                                                                    )
                                                                  : Container(),
                                                              qelders[index] != ''
                                                                  ? ExpansionTile(
                                                                      title: const Text(
                                                                          'Для пожилых людей'),
                                                                      children: [
                                                                        ListTile(
                                                                            title:
                                                                                Text(
                                                                          qelders[index]
                                                                              .replaceAll(
                                                                                  RegExp(
                                                                                      ' +'),
                                                                                  " ")
                                                                              .replaceAll("\t",
                                                                                  "")
                                                                              .replaceAll("\f",
                                                                                  "")
                                                                              .replaceAll("\r",
                                                                                  "")
                                                                              .replaceAll("\n ",
                                                                                  "\n")
                                                                              .replaceAll("\n",
                                                                                  "\n\n")
                                                                              .trim(),
                                                                          textAlign:
                                                                              TextAlign.justify,
                                                                        )),
                                                                      ],
                                                                    )
                                                                  : Container(),
                                                              qnotice[index] != ''
                                                                  ? ExpansionTile(
                                                                      title: const Text(
                                                                          'Замечания'),
                                                                      children: [
                                                                        ListTile(
                                                                            title:
                                                                                Text(
                                                                          qnotice[index]
                                                                              .replaceAll(
                                                                                  RegExp(
                                                                                      ' +'),
                                                                                  " ")
                                                                              .replaceAll("\t",
                                                                                  "")
                                                                              .replaceAll("\f",
                                                                                  "")
                                                                              .replaceAll("\r",
                                                                                  "")
                                                                              .replaceAll("\n ",
                                                                                  "\n")
                                                                              .replaceAll("\n",
                                                                                  "\n\n")
                                                                              .trim(),
                                                                          textAlign:
                                                                              TextAlign.justify,
                                                                        )),
                                                                      ],
                                                                    )
                                                                  : Container(),
                                                              qoverdose[index] !=
                                                                      ''
                                                                  ? ExpansionTile(
                                                                      title: const Text(
                                                                          'Передозировка препарата'),
                                                                      children: [
                                                                        ListTile(
                                                                            title:
                                                                                Text(
                                                                          qoverdose[index]
                                                                              .replaceAll(
                                                                                  RegExp(
                                                                                      ' +'),
                                                                                  " ")
                                                                              .replaceAll("\t",
                                                                                  "")
                                                                              .replaceAll("\f",
                                                                                  "")
                                                                              .replaceAll("\r",
                                                                                  "")
                                                                              .replaceAll("\n ",
                                                                                  "\n")
                                                                              .replaceAll("\n",
                                                                                  "\n\n")
                                                                              .trim(),
                                                                          textAlign:
                                                                              TextAlign.justify,
                                                                        )),
                                                                      ],
                                                                    )
                                                                  
                                                                  : Container(),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : Container(),
                                              ]);
                                            } else {
                                              return openTiles.contains(
                                                          qgroup[index][0]) &&
                                                      openTiles.contains(
                                                          qgroup[index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2]) &&
                                                      openTiles.contains(
                                                          qgroup[index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2] +
                                                              qgroup[index][3]) &&
                                                      openTiles.contains(
                                                          qgroup[index][0] +
                                                              qgroup[index][1] +
                                                              qgroup[index][2] +
                                                              qgroup[index][3] +
                                                              qgroup[index][4])
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 60),
                                                      child: Card(
                                                        child: ExpansionTile(
                                                          title: Text(qdrugList[
                                                                      index][0]
                                                                  .toUpperCase() +
                                                              qdrugList[index]
                                                                  .substring(1)),
                                                          subtitle: Text(
                                                              'Группа ${qgroup[index]}'),
                                                          trailing:
                                                              AnimatedRotation(
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        200),
                                                            turns:
                                                                customTileExpanded[
                                                                    index],
                                                            child: const Icon(Icons
                                                                .arrow_downward),
                                                          ),
                                                          onExpansionChanged:
                                                              (bool expanded) {
                                                            if (expanded ==
                                                                true) {
                                                              setState(() =>
                                                                  customTileExpanded[
                                                                          index] +=
                                                                      0.5);
                                                            } else {
                                                              setState(() =>
                                                                  customTileExpanded[
                                                                          index] -=
                                                                      0.5);
                                                            }
                                                          },
                                                          children: <Widget>[
                                                            qpd[index] != ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Фармакодинамика'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qpd[index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qpk[index] != ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Фармакокинетика'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qpk[index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qindications[index] !=
                                                                    ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Показания'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qindications[
                                                                                index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qsideEffects[index] !=
                                                                    ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Побочные Эффекты'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qsideEffects[
                                                                                index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qcontraIndications[
                                                                        index] !=
                                                                    ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Противопоказания'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qcontraIndications[
                                                                                index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qpregnancy[index] !=
                                                                    ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Беременность'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qpregnancy[
                                                                                index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qliver[index] != ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Печень'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qliver[index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qkidney[index] != ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Почки'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qkidney[index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qchildren[index] != ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Для детей'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qchildren[
                                                                                index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qelders[index] != ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Для пожилых людей'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qelders[index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qnotice[index] != ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Замечания'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qnotice[index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                            qoverdose[index] != ''
                                                                ? ExpansionTile(
                                                                    title: const Text(
                                                                        'Передозировка препарата'),
                                                                    children: [
                                                                      ListTile(
                                                                          title:
                                                                              Text(
                                                                        qoverdose[
                                                                                index]
                                                                            .replaceAll(
                                                                                RegExp(
                                                                                    ' +'),
                                                                                " ")
                                                                            .replaceAll(
                                                                                "\t",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\f",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\r",
                                                                                "")
                                                                            .replaceAll(
                                                                                "\n ",
                                                                                "\n")
                                                                            .replaceAll(
                                                                                "\n",
                                                                                "\n\n")
                                                                            .trim(),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                      )),
                                                                    ],
                                                                  )
                                                                
                                                                : Container(),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : Container();
                                            }
                                          }
                                        }
                                      }
                                    }
                                  });
                            } else {
                              qgroup = group;
                              qdrugList = drugList;
                              qpd = pd;
                              qpk = pk;
                              qindications = indications;
                              qsideEffects = sideEffects;
                              qcontraIndications = contraIndications;
                              qpregnancy = pregnancy;
                              qliver = liver;
                              qkidney = kidney;
                              qchildren = children;
                              qelders = elders;
                              qnotice = notice;
                              qoverdose = overdose;
                              if (finalAmount != 1) {
                                int rows = qgroup.length, columns = 15;
                                List<List<String>> twoDimensionalArray =
                                    List.generate(rows, (row) {
                                  return List.generate(columns, (col) => '');
                                });
                                for (var i = 0; i < qgroup.length; i += 1) {
                                  twoDimensionalArray[i][0] = qgroup[i];
                                  twoDimensionalArray[i][1] = qdrugList[i];
                                  twoDimensionalArray[i][2] = qpd[i];
                                  twoDimensionalArray[i][3] = qpk[i];
                                  twoDimensionalArray[i][4] = qindications[i];
                                  twoDimensionalArray[i][5] = qsideEffects[i];
                                  twoDimensionalArray[i][6] =
                                      qcontraIndications[i];
                                  twoDimensionalArray[i][7] = qpregnancy[i];
                                  twoDimensionalArray[i][8] = qliver[i];
                                  twoDimensionalArray[i][9] = qkidney[i];
                                  twoDimensionalArray[i][10] = qchildren[i];
                                  twoDimensionalArray[i][11] = qelders[i];
                                  twoDimensionalArray[i][12] = qnotice[i];
                                  twoDimensionalArray[i][13] = qoverdose[i];
                                }
        
                                twoDimensionalArray.sort((a, b) => a[1]
                                    .toUpperCase()
                                    .compareTo(b[1].toUpperCase()));
        
                                for (var i = 0;
                                    i < twoDimensionalArray.length;
                                    i += 1) {
                                  qgroup[i] = twoDimensionalArray[i][0];
                                  qdrugList[i] = twoDimensionalArray[i][1];
                                  qpd[i] = twoDimensionalArray[i][2];
                                  qpk[i] = twoDimensionalArray[i][3];
                                  qindications[i] = twoDimensionalArray[i][4];
                                  qsideEffects[i] = twoDimensionalArray[i][5];
                                  qcontraIndications[i] =
                                      twoDimensionalArray[i][6];
                                  qpregnancy[i] = twoDimensionalArray[i][7];
                                  qliver[i] = twoDimensionalArray[i][8];
                                  qkidney[i] = twoDimensionalArray[i][9];
                                  qchildren[i] = twoDimensionalArray[i][10];
                                  qelders[i] = twoDimensionalArray[i][11];
                                  qnotice[i] = twoDimensionalArray[i][12];
                                  qoverdose[i] = twoDimensionalArray[i][13];
                                }
                                finalAmount = qdrugList.length;
                              }
                              if (customTileExpanded.length < qdrugList.length) {
                                for (var i = 0; i < qdrugList.length; i++) {
                                  customTileExpanded.add(0.0);
                                }
                              }
                              final letters = [];
                              return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: finalAmount,
                                  itemBuilder: (BuildContext context, int index) {
                                    if (finalAmount == 1) {
                                      return Card(
                                        child: ExpansionTile(
                                          title: Text(
                                              ifoneDrug[0][0].toUpperCase() +
                                                  ifoneDrug[0].substring(1)),
                                          trailing: AnimatedRotation(
                                            duration:
                                                const Duration(milliseconds: 200),
                                            turns: customTileExpanded[index],
                                            child:
                                                const Icon(Icons.arrow_downward),
                                          ),
                                          onExpansionChanged: (bool expanded) {
                                            if (expanded == true) {
                                              setState(() =>
                                                  customTileExpanded[index] +=
                                                      0.5);
                                            } else {
                                              setState(() =>
                                                  customTileExpanded[index] -=
                                                      0.5);
                                            }
                                          },
                                          children: <Widget>[
                                            ifoneDrug[2] != ''
                                                ? ExpansionTile(
                                                    title: const Text(
                                                        'Фармакодинамика'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[2]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[3] != ''
                                                ? ExpansionTile(
                                                    title: const Text(
                                                        'Фармакокинетика'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[3]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[4] != ''
                                                ? ExpansionTile(
                                                    title:
                                                        const Text('Показания'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[4]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[5] != ''
                                                ? ExpansionTile(
                                                    title: const Text(
                                                        'Побочные Эффекты'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[5]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[6] != ''
                                                ? ExpansionTile(
                                                    title: const Text(
                                                        'Противопоказания'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[6]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[7] != ''
                                                ? ExpansionTile(
                                                    title: const Text(
                                                        'Беременность'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[7]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[8] != ''
                                                ? ExpansionTile(
                                                    title: const Text('Печень'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[8]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[9] != ''
                                                ? ExpansionTile(
                                                    title: const Text('Почки'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[9]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[10] != ''
                                                ? ExpansionTile(
                                                    title:
                                                        const Text('Для детей'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[10]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[11] != ''
                                                ? ExpansionTile(
                                                    title: const Text(
                                                        'Для пожилых людей'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[11]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[12] != ''
                                                ? ExpansionTile(
                                                    title:
                                                        const Text('Замечания'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[12]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                : Container(),
                                            ifoneDrug[13] != ''
                                                ? ExpansionTile(
                                                    title: const Text(
                                                        'Передозировка препарата'),
                                                    children: [
                                                      ListTile(
                                                          title: Text(
                                                        ifoneDrug[13]
                                                            .replaceAll(
                                                                RegExp(' +'), " ")
                                                            .replaceAll("\t", "")
                                                            .replaceAll("\f", "")
                                                            .replaceAll("\r", "")
                                                            .replaceAll(
                                                                "\n ", "\n")
                                                            .replaceAll(
                                                                "\n", "\n\n")
                                                            .trim(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      )),
                                                    ],
                                                  )
                                                
                                                : Container(),
                                          ],
                                        ),
                                      );
                                    } else {
                                      if (letters.isEmpty) {
                                        letters.add(qdrugList[0][0]);
                                        return Column(
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: Text(
                                                  qdrugList[0][0].toUpperCase(),
                                                  style: const TextStyle(
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
                                            Card(
                                              child: ExpansionTile(
                                                title: Text(qdrugList[index][0]
                                                        .toUpperCase() +
                                                    qdrugList[index]
                                                        .substring(1)),
                                                trailing: AnimatedRotation(
                                                  duration: const Duration(
                                                      milliseconds: 200),
                                                  turns:
                                                      customTileExpanded[index],
                                                  child: const Icon(
                                                      Icons.arrow_downward),
                                                ),
                                                onExpansionChanged:
                                                    (bool expanded) {
                                                  if (expanded == true) {
                                                    setState(() =>
                                                        customTileExpanded[
                                                            index] += 0.5);
                                                  } else {
                                                    setState(() =>
                                                        customTileExpanded[
                                                            index] -= 0.5);
                                                  }
                                                },
                                                children: <Widget>[
                                                  qpd[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Фармакодинамика'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qpd[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qpk[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Фармакокинетика'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qpk[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qindications[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Показания'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qindications[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qsideEffects[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Побочные Эффекты'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qsideEffects[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qcontraIndications[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Противопоказания'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qcontraIndications[
                                                                      index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qpregnancy[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Беременность'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qpregnancy[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qliver[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Печень'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qliver[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qkidney[index] != ''
                                                      ? ExpansionTile(
                                                          title:
                                                              const Text('Почки'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qkidney[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qchildren[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Для детей'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qchildren[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qelders[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Для пожилых людей'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qelders[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qnotice[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Замечания'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qnotice[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qoverdose[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Передозировка препарата'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qoverdose[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      
                                                      : Container(),
                                                ],
                                              ),
                                            )
                                          ],
                                        );
                                      } else if (letters[letters.length - 1]
                                              .toLowerCase() !=
                                          qdrugList[index][0].toLowerCase()) {
                                        letters.add(qdrugList[index][0]);
                                        return Column(
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: Text(
                                                  qdrugList[index][0]
                                                      .toUpperCase(),
                                                  style: const TextStyle(
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
                                            Card(
                                              child: ExpansionTile(
                                                title: Text(qdrugList[index][0]
                                                        .toUpperCase() +
                                                    qdrugList[index]
                                                        .substring(1)),
                                                trailing: AnimatedRotation(
                                                  duration: const Duration(
                                                      milliseconds: 200),
                                                  turns:
                                                      customTileExpanded[index],
                                                  child: const Icon(
                                                      Icons.arrow_downward),
                                                ),
                                                onExpansionChanged:
                                                    (bool expanded) {
                                                  if (expanded == true) {
                                                    setState(() =>
                                                        customTileExpanded[
                                                            index] += 0.5);
                                                  } else {
                                                    setState(() =>
                                                        customTileExpanded[
                                                            index] -= 0.5);
                                                  }
                                                },
                                                children: <Widget>[
                                                  qpd[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Фармакодинамика'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qpd[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qpk[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Фармакокинетика'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qpk[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qindications[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Показания'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qindications[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qsideEffects[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Побочные Эффекты'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qsideEffects[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qcontraIndications[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Противопоказания'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qcontraIndications[
                                                                      index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qpregnancy[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Беременность'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qpregnancy[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qliver[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Печень'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qliver[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qkidney[index] != ''
                                                      ? ExpansionTile(
                                                          title:
                                                              const Text('Почки'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qkidney[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qchildren[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Для детей'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qchildren[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qelders[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Для пожилых людей'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qelders[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qnotice[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Замечания'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qnotice[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      : Container(),
                                                  qoverdose[index] != ''
                                                      ? ExpansionTile(
                                                          title: const Text(
                                                              'Передозировка препарата'),
                                                          children: [
                                                            ListTile(
                                                                title: Text(
                                                              qoverdose[index]
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          ' +'),
                                                                      " ")
                                                                  .replaceAll(
                                                                      "\t", "")
                                                                  .replaceAll(
                                                                      "\f", "")
                                                                  .replaceAll(
                                                                      "\r", "")
                                                                  .replaceAll(
                                                                      "\n ", "\n")
                                                                  .replaceAll(
                                                                      "\n",
                                                                      "\n\n")
                                                                  .trim(),
                                                              textAlign: TextAlign
                                                                  .justify,
                                                            )),
                                                          ],
                                                        )
                                                      
                                                      : Container(),
                                                ],
                                              ),
                                            )
                                          ],
                                        );
                                      } else {
                                        return Card(
                                          child: ExpansionTile(
                                            title: Text(qdrugList[index][0]
                                                    .toUpperCase() +
                                                qdrugList[index].substring(1)),
                                            trailing: AnimatedRotation(
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              turns: customTileExpanded[index],
                                              child: const Icon(
                                                  Icons.arrow_downward),
                                            ),
                                            onExpansionChanged: (bool expanded) {
                                              if (expanded == true) {
                                                setState(() =>
                                                    customTileExpanded[index] +=
                                                        0.5);
                                              } else {
                                                setState(() =>
                                                    customTileExpanded[index] -=
                                                        0.5);
                                              }
                                            },
                                            children: <Widget>[
                                              qpd[index] != ''
                                                  ? ExpansionTile(
                                                      title: const Text(
                                                          'Фармакодинамика'),
                                                      children: [
                                                        ListTile(
                                                            title: Text(
                                                          qpd[index]
                                                              .replaceAll(
                                                                  RegExp(' +'),
                                                                  " ")
                                                              .replaceAll(
                                                                  "\t", "")
                                                              .replaceAll(
                                                                  "\f", "")
                                                              .replaceAll(
                                                                  "\r", "")
                                                              .replaceAll(
                                                                  "\n ", "\n")
                                                              .replaceAll(
                                                                  "\n", "\n\n")
                                                              .trim(),
                                                          textAlign:
                                                              TextAlign.justify,
                                                        )),
                                                      ],
                                                    )
                                                  : Container(),
                                              qpk[index] != ''
                                                  ? ExpansionTile(
                                                      title: const Text(
                                                          'Фармакокинетика'),
                                                      children: [
                                                        ListTile(
                                                            title: Text(
                                                          qpk[index]
                                                              .replaceAll(
                                                                  RegExp(' +'),
                                                                  " ")
                                                              .replaceAll(
                                                                  "\t", "")
                                                              .replaceAll(
                                                                  "\f", "")
                                                              .replaceAll(
                                                                  "\r", "")
                                                              .replaceAll(
                                                                  "\n ", "\n")
                                                              .replaceAll(
                                                                  "\n", "\n\n")
                                                              .trim(),
                                                          textAlign:
                                                              TextAlign.justify,
                                                        )),
                                                      ],
                                                    )
                                                  : Container(),
                                              qindications[index] != ''
                                                  ? ExpansionTile(
                                                      title:
                                                          const Text('Показания'),
                                                      children: [
                                                        ListTile(
                                                            title: Text(
                                                          qindications[index]
                                                              .replaceAll(
                                                                  RegExp(' +'),
                                                                  " ")
                                                              .replaceAll(
                                                                  "\t", "")
                                                              .replaceAll(
                                                                  "\f", "")
                                                              .replaceAll(
                                                                  "\r", "")
                                                              .replaceAll(
                                                                  "\n ", "\n")
                                                              .replaceAll(
                                                                  "\n", "\n\n")
                                                              .trim(),
                                                          textAlign:
                                                              TextAlign.justify,
                                                        )),
                                                      ],
                                                    )
                                                  : Container(),
                                              qsideEffects[index] != ''
                                                  ? ExpansionTile(
                                                      title: const Text(
                                                          'Побочные Эффекты'),
                                                      children: [
                                                        ListTile(
                                                            title: Text(
                                                          qsideEffects[index]
                                                              .replaceAll(
                                                                  RegExp(' +'),
                                                                  " ")
                                                              .replaceAll(
                                                                  "\t", "")
                                                              .replaceAll(
                                                                  "\f", "")
                                                              .replaceAll(
                                                                  "\r", "")
                                                              .replaceAll(
                                                                  "\n ", "\n")
                                                              .replaceAll(
                                                                  "\n", "\n\n")
                                                              .trim(),
                                                          textAlign:
                                                              TextAlign.justify,
                                                        )),
                                                      ],
                                                    )
                                                  : Container(),
                                              qcontraIndications[index] != ''
                                                  ? ExpansionTile(
                                                      title: const Text(
                                                          'Противопоказания'),
                                                      children: [
                                                        ListTile(
                                                            title: Text(
                                                          qcontraIndications[
                                                                  index]
                                                              .replaceAll(
                                                                  RegExp(' +'),
                                                                  " ")
                                                              .replaceAll(
                                                                  "\t", "")
                                                              .replaceAll(
                                                                  "\f", "")
                                                              .replaceAll(
                                                                  "\r", "")
                                                              .replaceAll(
                                                                  "\n ", "\n")
                                                              .replaceAll(
                                                                  "\n", "\n\n")
                                                              .trim(),
                                                          textAlign:
                                                              TextAlign.justify,
                                                        )),
                                                      ],
                                                    )
                                                  : Container(),
                                              qpregnancy[index] != ''
                                                  ? ExpansionTile(
                                                      title: const Text(
                                                          'Беременность'),
                                                      children: [
                                                        ListTile(
                                                            title: Text(
                                                          qpregnancy[index]
                                                              .replaceAll(
                                                                  RegExp(' +'),
                                                                  " ")
                                                              .replaceAll(
                                                                  "\t", "")
                                                              .replaceAll(
                                                                  "\f", "")
                                                              .replaceAll(
                                                                  "\r", "")
                                                              .replaceAll(
                                                                  "\n ", "\n")
                                                              .replaceAll(
                                                                  "\n", "\n\n")
                                                              .trim(),
                                                          textAlign:
                                                              TextAlign.justify,
                                                        )),
                                                      ],
                                                    )
                                                  : Container(),
                                              qliver[index] != ''
                                                  ? ExpansionTile(
                                                      title: const Text('Печень'),
                                                      children: [
                                                        ListTile(
                                                            title: Text(
                                                          qliver[index]
                                                              .replaceAll(
                                                                  RegExp(' +'),
                                                                  " ")
                                                              .replaceAll(
                                                                  "\t", "")
                                                              .replaceAll(
                                                                  "\f", "")
                                                              .replaceAll(
                                                                  "\r", "")
                                                              .replaceAll(
                                                                  "\n ", "\n")
                                                              .replaceAll(
                                                                  "\n", "\n\n")
                                                              .trim(),
                                                          textAlign:
                                                              TextAlign.justify,
                                                        )),
                                                      ],
                                                    )
                                                  : Container(),
                                              qkidney[index] != ''
                                                  ? ExpansionTile(
                                                      title: const Text('Почки'),
                                                      children: [
                                                        ListTile(
                                                            title: Text(
                                                          qkidney[index]
                                                              .replaceAll(
                                                                  RegExp(' +'),
                                                                  " ")
                                                              .replaceAll(
                                                                  "\t", "")
                                                              .replaceAll(
                                                                  "\f", "")
                                                              .replaceAll(
                                                                  "\r", "")
                                                              .replaceAll(
                                                                  "\n ", "\n")
                                                              .replaceAll(
                                                                  "\n", "\n\n")
                                                              .trim(),
                                                          textAlign:
                                                              TextAlign.justify,
                                                        )),
                                                      ],
                                                    )
                                                  : Container(),
                                              qchildren[index] != ''
                                                  ? ExpansionTile(
                                                      title:
                                                          const Text('Для детей'),
                                                      children: [
                                                        ListTile(
                                                            title: Text(
                                                          qchildren[index]
                                                              .replaceAll(
                                                                  RegExp(' +'),
                                                                  " ")
                                                              .replaceAll(
                                                                  "\t", "")
                                                              .replaceAll(
                                                                  "\f", "")
                                                              .replaceAll(
                                                                  "\r", "")
                                                              .replaceAll(
                                                                  "\n ", "\n")
                                                              .replaceAll(
                                                                  "\n", "\n\n")
                                                              .trim(),
                                                          textAlign:
                                                              TextAlign.justify,
                                                        )),
                                                      ],
                                                    )
                                                  : Container(),
                                              qelders[index] != ''
                                                  ? ExpansionTile(
                                                      title: const Text(
                                                          'Для пожилых людей'),
                                                      children: [
                                                        ListTile(
                                                            title: Text(
                                                          qelders[index]
                                                              .replaceAll(
                                                                  RegExp(' +'),
                                                                  " ")
                                                              .replaceAll(
                                                                  "\t", "")
                                                              .replaceAll(
                                                                  "\f", "")
                                                              .replaceAll(
                                                                  "\r", "")
                                                              .replaceAll(
                                                                  "\n ", "\n")
                                                              .replaceAll(
                                                                  "\n", "\n\n")
                                                              .trim(),
                                                          textAlign:
                                                              TextAlign.justify,
                                                        )),
                                                      ],
                                                    )
                                                  : Container(),
                                              qnotice[index] != ''
                                                  ? ExpansionTile(
                                                      title:
                                                          const Text('Замечания'),
                                                      children: [
                                                        ListTile(
                                                            title: Text(
                                                          qnotice[index]
                                                              .replaceAll(
                                                                  RegExp(' +'),
                                                                  " ")
                                                              .replaceAll(
                                                                  "\t", "")
                                                              .replaceAll(
                                                                  "\f", "")
                                                              .replaceAll(
                                                                  "\r", "")
                                                              .replaceAll(
                                                                  "\n ", "\n")
                                                              .replaceAll(
                                                                  "\n", "\n\n")
                                                              .trim(),
                                                          textAlign:
                                                              TextAlign.justify,
                                                        )),
                                                      ],
                                                    )
                                                  : Container(),
                                              qoverdose[index] != ''
                                                  ? ExpansionTile(
                                                      title: const Text(
                                                          'Передозировка препарата'),
                                                      children: [
                                                        ListTile(
                                                            title: Text(
                                                          qoverdose[index]
                                                              .replaceAll(
                                                                  RegExp(' +'),
                                                                  " ")
                                                              .replaceAll(
                                                                  "\t", "")
                                                              .replaceAll(
                                                                  "\f", "")
                                                              .replaceAll(
                                                                  "\r", "")
                                                              .replaceAll(
                                                                  "\n ", "\n")
                                                              .replaceAll(
                                                                  "\n", "\n\n")
                                                              .trim(),
                                                          textAlign:
                                                              TextAlign.justify,
                                                        )),
                                                      ],
                                                    )
                                                  
                                                  : Container(),
                                            ],
                                          ),
                                        );
                                      }
                                    }
                                  });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
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
                    return const Iterable<String>.empty();
                  },
                  optionsViewBuilder:
                      (context, Function(String) onSelected, options) {
                    return Container();
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
                          hintText: "Название препарата...",
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
                                // _focusNode.unfocus();
                              })),
                    );
                  },
                )),
                SizedBox(
                  width: 40,
                  child: RawMaterialButton(
                      shape: const CircleBorder(),
                      fillColor: const Color.fromRGBO(13, 159, 130, 1.000),
                      onPressed: () {},
                      child: const Icon(Icons.add)),
                )
              ],
            ),
          ),
          body: const Center(child: CircularProgressIndicator()),
        ),
      );
    }
  }

  listsOutput(connection) async {
    // ignore: prefer_typing_uninitialized_variables
    var group = [];
    var drugList = [];
    var pd = [];
    var pk = [];
    var indications = [];
    var sideEffects = [];
    var contraIndications = [];
    var pregnancy = [];
    var liver = [];
    var kidney = [];
    var children = [];
    var elders = [];
    var notice = [];
    var overdose = [];

    // ignore: non_constant_identifier_names
    int amount = await drugAmount(connection);

    for (var i = 1; i <= amount; i++) {
      //goes through each combination

      var wholeRow = await querywholeRow(connection, i);
      var drugListResult = wholeRow[2];
      var groupResult = wholeRow[6];
      var pdResult = wholeRow[7];
      var pkResult = wholeRow[8];
      var indicationsResult = wholeRow[9];
      var sideEffectssResult = wholeRow[10];
      var contraIndicationsResult = wholeRow[11];
      var pregnancyResult = wholeRow[12];
      var liverResult = wholeRow[13];
      var kidneyResult = wholeRow[14];
      var childrenResult = wholeRow[15];
      var eldersResult = wholeRow[16];
      var noticeResult = wholeRow[17];
      var overdoseResult = wholeRow[19];
      if (groupResult != null) {
        groupResult = groupResult.replaceAll("ATC", "");
        groupResult = groupResult.replaceAll(" ", "");
        drugList.add(drugListResult);
        group.add(groupResult);
        if (groupResult == null) {
          pd.add('');
        } else {
          pd.add(pdResult);
        }
        if (pkResult == null) {
          pk.add('');
        } else {
          pk.add(pkResult);
        }
        if (indicationsResult == null) {
          indications.add('');
        } else {
          indications.add(indicationsResult);
        }
        if (sideEffectssResult == null) {
          sideEffects.add('');
        } else {
          sideEffects.add(sideEffectssResult);
        }
        if (contraIndicationsResult == null) {
          contraIndications.add('');
        } else {
          contraIndications.add(contraIndicationsResult);
        }
        if (pregnancyResult == null) {
          pregnancy.add('');
        } else {
          pregnancy.add(pregnancyResult);
        }
        if (liverResult == null) {
          liver.add('');
        } else {
          liver.add(liverResult);
        }
        if (kidneyResult == null) {
          kidney.add('');
        } else {
          kidney.add(kidneyResult);
        }
        if (childrenResult == null) {
          children.add('');
        } else {
          children.add(childrenResult);
        }
        if (eldersResult == null) {
          elders.add('');
        } else {
          elders.add(eldersResult);
        }
        if (noticeResult == null) {
          notice.add('');
        } else {
          notice.add(noticeResult);
        }
        if (overdoseResult == null) {
          overdose.add('');
        } else {
          overdose.add(overdoseResult);
        }
        
      } else {
        drugList.add(drugListResult);
        group.add('ZisIsYou');
        if (groupResult == null) {
          pd.add('');
        } else {
          pd.add(pdResult);
        }
        if (pkResult == null) {
          pk.add('');
        } else {
          pk.add(pkResult);
        }
        if (indicationsResult == null) {
          indications.add('');
        } else {
          indications.add(indicationsResult);
        }
        if (sideEffectssResult == null) {
          sideEffects.add('');
        } else {
          sideEffects.add(sideEffectssResult);
        }
        if (contraIndicationsResult == null) {
          contraIndications.add('');
        } else {
          contraIndications.add(contraIndicationsResult);
        }
        if (pregnancyResult == null) {
          pregnancy.add('');
        } else {
          pregnancy.add(pregnancyResult);
        }
        if (liverResult == null) {
          liver.add('');
        } else {
          liver.add(liverResult);
        }
        if (kidneyResult == null) {
          kidney.add('');
        } else {
          kidney.add(kidneyResult);
        }
        if (childrenResult == null) {
          children.add('');
        } else {
          children.add(childrenResult);
        }
        if (eldersResult == null) {
          elders.add('');
        } else {
          elders.add(eldersResult);
        }
        if (noticeResult == null) {
          notice.add('');
        } else {
          notice.add(noticeResult);
        }
        if (overdoseResult == null) {
          overdose.add('');
        } else {
          overdose.add(overdoseResult);
        }
        
      }
    }

    var allLists = [
      drugList,
      group,
      pd,
      pk,
      indications,
      sideEffects,
      contraIndications,
      pregnancy,
      liver,
      kidney,
      children,
      elders,
      notice,
      overdose,
    
    ];
    return allLists;
  }

  drugAmount(connection) async {
    var result = await connection.query("SELECT COUNT(*) FROM catalogue;");

    for (final row in result) {
      return row[0];
    }
  }

  querywholeRow(connection, i) async {
    var result =
        await connection.query("SELECT * FROM catalogue WHERE _id = $i");

    return result[0];
  }

  allListsFinalOutput() async {
    var connection = globals.connection();

    await connection.open();

    return await listsOutput(connection);
  }
}
