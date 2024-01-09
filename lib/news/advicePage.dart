import 'package:flutter_application_1/news/widgets/image_container.dart';
import '../../../../globals.dart' as globals;
import 'package:flutter/material.dart';

import 'screens/advice_screen.dart';

class AdvicePage extends StatefulWidget {
  const AdvicePage({Key? key}) : super(key: key);

  @override
  State<AdvicePage> createState() => _CategoryAdvicePage();
}

class _CategoryAdvicePage extends State<AdvicePage> {
  var advice = [];

  late bool done;

  void awaiting() async {
    final allArticles = await allArticlesOutput();
    setState(() {
      advice = allArticles;
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
    return DefaultTabController(
      initialIndex: 0,
      length: 1,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromARGB(255, 249, 249, 249),
            elevation: 0,
          ),
        ),
        body: done
        ? advice[0].isEmpty
                ? const Center(child: Text('Советы еще не добавлены'))
                : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: advice[0].length,
                      itemBuilder: ((context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 97,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdviceScreen(
                                              advice: [
                                                advice[0][index],
                                                advice[1][index],
                                                advice[2][index],
                                                advice[3][index],
                                                advice[4][index],
                                                advice[5][index],
                                                advice[6][index],
                                                advice[7][index],
                                                advice[8][index],
                                                advice[9][index]
                                              ],
                                            )),
                                  );
                                },
                                child: Row(
                                  children: [
                                    ImageContainer(
                                      width: 80,
                                      height: 80,
                                      margin: const EdgeInsets.all(10.0),
                                      borderRadius: 5,
                                      imageUrl: advice[7][index],
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            advice[0][index],
                                            maxLines: 2,
                                            overflow: TextOverflow.clip,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color.fromARGB(
                                                      255, 12, 134, 110),
                                                ),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.schedule,
                                                size: 18,
                                                color: Color.fromRGBO(
                                                    13, 159, 130, 1.000),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                advice[8][index],
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 89, 90, 89),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(
                              height: 10,
                              thickness: 2,
                              indent: 20,
                              endIndent: 20,
                              color: Color.fromRGBO(107, 182, 167, 0.553),
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  listsOutput(connection) async {
    var title = [];
    var subtitle = [];
    var body = [];
    var author = [];
    var authorImageUrl = [];
    var category = [];
    var views = [];
    var imageUrl = [];
    var createdAt = [];
    var adviceID = [];
    //goes through each combination

    final amount = await advicesAmount(connection);

    for (var i = 1; i <= amount; i++) {
      var wholeRow = await querywholeRow(connection, i);
      title.add(wholeRow[1]);
      subtitle.add(wholeRow[2]);
      body.add(wholeRow[3]);
      author.add(wholeRow[4]);
      authorImageUrl.add(wholeRow[5]);
      category.add(wholeRow[6]);
      views.add(wholeRow[7]);
      imageUrl.add(wholeRow[8]);
      createdAt.add(wholeRow[9]);
      adviceID.add(wholeRow[0]);
      if (i == 10) break;
    }

    var allLists = [
      title,
      subtitle,
      body,
      author,
      authorImageUrl,
      category,
      views,
      imageUrl,
      createdAt,
      adviceID
    ];
    return allLists;
  }

  advicesAmount(connection) async {
    var result = await connection.query("SELECT COUNT(*) FROM advices;");

    for (final row in result) {
      return row[0];
    }
  }

  querywholeRow(connection, i) async {
    var result = await connection.query(
        "select * from (select * from advices ORDER BY _id DESC LIMIT $i) as foo ORDER BY _id asc LIMIT 1");

    return result[0];
  }

  allArticlesOutput() async {
    var connection = globals.connection();

    await connection.open();

    return await listsOutput(connection);
  }
}
