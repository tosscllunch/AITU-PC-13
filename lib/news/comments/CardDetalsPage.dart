import '../../../../globals.dart' as globals;
import 'package:flutter/material.dart';

class CardDetailsPage extends StatefulWidget {
  final List card;

  const CardDetailsPage({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  _CardDetailsPageState createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  final _commentController = TextEditingController();
  List allComments = [];

  late bool done;

  void awaiting(articleID) async {
    final articles = await allArticlesOutput(articleID);
    setState(() {
      allComments = articles;
      done = true;
    });
  }

  @override
  void initState() {
    super.initState();
    awaiting(widget.card[0]);
    done = false;
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Обсуждение',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: done
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.card[1],
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: const Color.fromARGB(255, 0, 82, 74)),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.card[1],
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 1, 104, 93)),
                    ),
                    const SizedBox(height: 20),
                    const Divider(
                      thickness: 2,
                      color: Colors.teal,
                    ),
                    const Text(
                      'Обсуждение:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: allComments[0].isEmpty
                          ? const Center(
                              child: Text('Здесь пока нет комментариев'))
                          : ListView.builder(
                              itemCount: allComments[0].length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://thumbs.dreamstime.com/b/pretty-miss-14945393.jpg"),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: ListTile(
                                                title: Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        allComments[0][index],
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        allComments[3][index],
                                                        style: const TextStyle(
                                                            fontSize: 11),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                subtitle:
                                                    Text(allComments[2][index]),
                                              ),
                                            ),
                                            const Divider(
                                              height: 10,
                                              thickness: 2,
                                              color: Color.fromRGBO(
                                                  107, 182, 167, 0.553),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Добавить комментарий',
                      ),
                      onSubmitted: (text) async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    super.widget));
                        final newComment = [
                          widget.card[0],
                          globals.userInfoFinal[0],
                          _commentController.text
                        ];
                        await insertComment(newComment);
                      },
                    ),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  listsOutput(connection, articleID) async {
    var message = [];
    var date = [];
    var authorImageUrl = [];
    var authorName = [];
    //goes through each combination

    final amount = await commentsAmount(connection, articleID);

    for (var i = 1; i <= amount; i++) {
      var wholeRow = await querywholeRow(connection, articleID, i);
      var userInfo = await comments(connection, wholeRow[2]);
      message.add(wholeRow[3]);
      date.add(wholeRow[4]);
      authorName.add('${userInfo[3]} ${userInfo[4]}');
      if (i == 15) break;
    }

    var allLists = [authorName, authorImageUrl, message, date];
    return allLists;
  }

  comments(connection, userinfo) async {
    var result = await connection
        .query("SELECT * FROM users WHERE _email = '$userinfo'");

    return result[0];
  }

  newComment(connection, comment) async {
    await connection.execute(
        "INSERT INTO commCom (_articleID, _email, _message, _date) VALUES ('${comment[0]}', '${comment[1]}', '${comment[2]}', now()::timestamp(0))");
  }

  addComment(connection, comment) async {
    await connection.execute(
        "UPDATE communities SET _comments = _comments + 1 WHERE _id = ${comment[0]};");
  }

  insertComment(comment) async {
    var connection = globals.connection();

    await connection.open();

    await newComment(connection, comment);
    await addComment(connection, comment);
  }

  commentsAmount(connection, articleID) async {
    var result = await connection
        .query("SELECT COUNT(*) FROM commCom WHERE _articleID = $articleID;");

    for (final row in result) {
      return row[0];
    }
  }

  querywholeRow(connection, articleID, i) async {
    var result = await connection.query(
        "SELECT * FROM (SELECT * FROM commCom WHERE _articleID = $articleID ORDER BY _id DESC LIMIT $i) AS foo ORDER BY _id ASC LIMIT 1");

    return result[0];
  }

  allArticlesOutput(articleID) async {
    var connection = globals.connection();

    await connection.open();

    return await listsOutput(connection, articleID);
  }
}
