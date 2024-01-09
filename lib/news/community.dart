import '../../../../globals.dart' as globals;
import 'package:flutter/material.dart';

import 'comments/CardDetalsPage.dart';

// Позитивное воспитание ребенка: здоровый сон и правильный уход
// Проблемы, связанные с детским сном, воспитанием и развитием малыша волнуют нас с самого его рождения

// Красота и Медицина
// Красота и Медицина – это информационный ресурс, профессионально и доступно рассказывающий о том, что волнует каждого человека: о здоровье и обо всем, что помогает его сохранить

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final _formKey = GlobalKey<FormState>();
  var cards = [];

  final _cardName = TextEditingController();
  final _cardDescription = TextEditingController();

  String cardName = '';
  String cardDescription = '';

  late bool done;

  void awaiting() async {
    final allArticles = await allCardsOutput();
    setState(() {
      cards = allArticles;
      done = true;
    });
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
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          label: const Text('Создать тему'),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Создайте тему'),
                    content: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: _cardName,
                              decoration: const InputDecoration(
                                labelText: 'Название Темы',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Пожалуйста назовите тему';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _cardDescription,
                              decoration: const InputDecoration(
                                labelText: 'Описание темы',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Введите описание темы';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Закрыть'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Создать'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              done = false;
                            });
                            Navigator.of(context).pop();
                            final newCom = [
                              _cardName.text,
                              _cardDescription.text,
                              globals.userInfoFinal[2] +
                                  ' ' +
                                  globals.userInfoFinal[3],
                              globals.userInfoFinal[0],
                              0
                            ];
                            _formKey.currentState!.reset();
                            await insertCom(newCom);
                            awaiting();
                          }
                        },
                      ),
                    ],
                  );
                });
          },
        ),
        body: done
            ? cards[0].isEmpty
                ? const Center(child: Text('Сообщества еще не созданы'))
                : Column(
                    children: [
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: cards.isEmpty ? 0 : cards[0].length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    15.0), // set the border radius
                                side: const BorderSide(
                                    color: Color.fromRGBO(107, 182, 167, 0.553),
                                    width:
                                        2.0), // set the border width and color
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CardDetailsPage(
                                              card: [
                                                cards[0][index],
                                                cards[1][index],
                                                cards[2][index],
                                                cards[3][index],
                                                cards[4][index],
                                                cards[5][index],
                                              ],
                                            )),
                                  );
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: Text(
                                        cards[1][index],
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      subtitle: Text(cards[2][index]),
                                    ),
                                    ButtonBar(
                                      alignment: MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Icon(
                                          Icons.comment_rounded,
                                          color: Colors.grey,
                                          size: 17,
                                        ),
                                        Text(
                                            '${cards[5][index].toString()} комментария',
                                            style: const TextStyle(
                                                fontSize: 17,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  newCom(connection, comment) async {
    await connection.execute(
        "INSERT INTO communities (_title, _body, _author, _email, _comments, _date) VALUES ('${comment[0]}', '${comment[1]}', '${comment[2]}', '${comment[3]}', '${comment[4]}', now()::timestamp(0))");
  }

  insertCom(comment) async {
    var connection = globals.connection();

    await connection.open();

    await newCom(connection, comment);
  }

  listsOutput(connection) async {
    var communityID = [];
    var title = [];
    var body = [];
    var author = [];
    var email = [];
    var comments = [];
    //goes through each combination

    final amount = await advicesAmount(connection);

    for (var i = 1; i <= amount; i++) {
      var wholeRow = await querywholeRow(connection, i);
      communityID.add(wholeRow[0]);
      title.add(wholeRow[1]);
      body.add(wholeRow[2]);
      author.add(wholeRow[3]);
      email.add(wholeRow[4]);
      comments.add(wholeRow[5]);
      if (i == 10) break;
    }

    var allLists = [
      communityID,
      title,
      body,
      author,
      email,
      comments,
    ];
    return allLists;
  }

  advicesAmount(connection) async {
    var result = await connection.query("SELECT COUNT(*) FROM communities;");

    for (final row in result) {
      return row[0];
    }
  }

  querywholeRow(connection, i) async {
    var result = await connection.query(
        "select * from (select * from communities ORDER BY _id DESC LIMIT $i) as foo ORDER BY _id asc LIMIT 1");

    return result[0];
  }

  allCardsOutput() async {
    var connection = globals.connection();

    await connection.open();

    return await listsOutput(connection);
  }
}
