import 'package:flutter_application_1/news/screens/article_screen.dart';
import 'package:flutter_application_1/news/widgets/custom_tag.dart';
import '../../../../globals.dart' as globals;
import 'package:flutter/material.dart';
import 'widgets/image_container.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  var article = [];

  late bool done;

  void awaiting() async {
    final allArticles = await allArticlesOutput();
    setState(() {
      article = allArticles;
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: done
            ? article[0].isEmpty
                ? const Center(child: Text('Новости еще не добавлены'))
                : ListView(padding: EdgeInsets.zero, children: [
                    //а тут добавь
                    _NewsOfTheDay(article: article),

                    //
                    //тут не добавляй новый артикл
                    _BreakingNews(articles: article),
                  ])
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
    var articleID = [];
    //goes through each combination

    final amount = await articlesAmount(connection);

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
      articleID.add(wholeRow[0]);
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
      articleID
    ];
    return allLists;
  }

  articlesAmount(connection) async {
    var result = await connection.query("SELECT COUNT(*) FROM articles;");

    for (final row in result) {
      return row[0];
    }
  }

  querywholeRow(connection, i) async {
    var result = await connection.query(
        "select * from (select * from articles ORDER BY _id DESC LIMIT $i) as foo ORDER BY _id asc LIMIT 1");

    return result[0];
  }

  allArticlesOutput() async {
    var connection = globals.connection();

    await connection.open();

    return await listsOutput(connection);
  }
}

class _NewsOfTheDay extends StatelessWidget {
  final List article;

  const _NewsOfTheDay({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: ImageContainer(
        height: MediaQuery.of(context).size.height * 0.45, //было 0.45
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        imageUrl: article[7][0],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTag(
              backgroundColor: Colors.grey.withAlpha(150),
              children: [
                Text(
                  'Новость Дня',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              article[0][0],
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                  color: Colors.white),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArticleScreen(
                            article: [
                              article[0][0],
                              article[1][0],
                              article[2][0],
                              article[3][0],
                              article[4][0],
                              article[5][0],
                              article[6][0],
                              article[7][0],
                              article[8][0],
                              article[9][0]
                            ],
                          )),
                );
              },
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Row(
                children: [
                  Text(
                    'Читать подробнее',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.arrow_right_alt,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BreakingNews extends StatelessWidget {
  final List articles;

  const _BreakingNews({
    Key? key,
    required this.articles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Главные Новости',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 12, 134, 110),
                            ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 5,
                  thickness: 2,
                  color: Color.fromRGBO(13, 159, 130, 1.000),
                  // color: Color.fromRGBO(174, 175, 175, 0.624),
                ),
                // const SizedBox(height: 10),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: articles[0].length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ArticleScreen(
                                          article: [
                                            articles[0][index],
                                            articles[1][index],
                                            articles[2][index],
                                            articles[3][index],
                                            articles[4][index],
                                            articles[5][index],
                                            articles[6][index],
                                            articles[7][index],
                                            articles[8][index],
                                            articles[9][index]
                                          ],
                                        )),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ImageContainer(
                                  width: 350,
                                  height: 190,
                                  imageUrl: articles[7][index],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  articles[0][index],
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        height: 1.5,
                                        color: const Color.fromARGB(
                                            255, 12, 134, 110),
                                      ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.schedule,
                                      size: 18,
                                      color:
                                          Color.fromRGBO(13, 159, 130, 1.000),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      '${articles[8][index]}',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    const SizedBox(width: 20),
                                    const SizedBox(width: 5),
                                    Text('от ${articles[3][index]}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          height: 10,
                          thickness: 2,
                          color: Color.fromRGBO(107, 182, 167, 0.553),
                          // color: Color.fromRGBO(174, 175, 175, 0.624),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
