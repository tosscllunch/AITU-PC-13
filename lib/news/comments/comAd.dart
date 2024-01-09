// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers, avoid_print

import 'package:comment_box/comment/comment.dart';
import '../../globals.dart' as globals;
import 'package:flutter/material.dart';

class ComAdv extends StatefulWidget {
  final int articleID;

  const ComAdv({
    super.key,
    required this.articleID,
  });

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<ComAdv> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List allArticles = [];

  late bool done;

  void awaiting(articleID) async {
    final articles = await allArticlesOutput(articleID);
    setState(() {
      allArticles = articles;
      done = true;
    });
  }

  @override
  void initState() {
    super.initState();
    awaiting(widget.articleID);
    done = false;
  }

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data[0].length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 3.0),
            child: ListTile(
              leading: Container(
                height: 50.0,
                width: 50.0,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: CircleAvatar(
                    radius: 50,
                    backgroundImage: CommentBox.commentImageParser(
                      imageURLorPath:
                          'https://thumbs.dreamstime.com/b/pretty-miss-14945393.jpg',
                    )),
              ),
              title: Text(
                data[0][i],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[2][i]),
              trailing: Text(data[3][i], style: const TextStyle(fontSize: 10)),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Комментарии"),
          backgroundColor: const Color.fromRGBO(13, 159, 130, 1.000),
        ),
        body: done
            ? Container(
                child: CommentBox(
                  userImage: CommentBox.commentImageParser(
                      imageURLorPath:
                          "https://thumbs.dreamstime.com/b/pretty-miss-14945393.jpg"),
                  labelText: 'Прокомментировать...',
                  errorText: 'Поле не должно быть пустым',
                  // withBorder: false,
                  sendButtonMethod: () async {
                    if (formKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => super.widget));
                      final newComment = [
                        widget.articleID,
                        globals.userInfoFinal[0],
                        commentController.text
                      ];
                      await insertComment(newComment);
                    }
                  },
                  formKey: formKey,
                  commentController: commentController,
                  backgroundColor: const Color.fromRGBO(13, 159, 130, 1.000),
                  textColor: Colors.white,
                  sendWidget: const Icon(Icons.send_sharp,
                      size: 30, color: Colors.white),
                  child: allArticles[0].length == 0
                      ? const Center(child: Text('No comments yet'))
                      : commentChild(allArticles),
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
      var userInfo = await allComments(connection, wholeRow[2]);
      message.add(wholeRow[3]);
      date.add(wholeRow[4]);
      authorName.add('${userInfo[3]} ${userInfo[4]}');
      authorImageUrl.add(userInfo[12]);
      if (i == 15) break;
    }

    var allLists = [authorName, authorImageUrl, message, date];
    return allLists;
  }

  allComments(connection, userinfo) async {
    var result = await connection
        .query("SELECT * FROM users WHERE _email = '$userinfo'");

    return result[0];
  }

  newComment(connection, comment) async {
    await connection.execute(
        "INSERT INTO commAdv (_articleID, _email, _message, _date) VALUES ('${comment[0]}', '${comment[1]}', '${comment[2]}', now()::timestamp(0))");
  }

  insertComment(comment) async {
    var connection = globals.connection();

    await connection.open();

    await newComment(connection, comment);
  }

  commentsAmount(connection, articleID) async {
    var result = await connection
        .query("SELECT COUNT(*) FROM commAdv WHERE _articleID = $articleID;");

    for (final row in result) {
      return row[0];
    }
  }

  querywholeRow(connection, articleID, i) async {
    var result = await connection.query(
        "SELECT * FROM (SELECT * FROM commAdv WHERE _articleID = $articleID ORDER BY _id DESC LIMIT $i) AS foo ORDER BY _id ASC LIMIT 1");

    return result[0];
  }

  allArticlesOutput(articleID) async {
    var connection = globals.connection();

    await connection.open();

    return await listsOutput(connection, articleID);
  }
}
