import '../../../../globals.dart' as globals;
import '../widgets/image_container.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_tag.dart';
import '../comments/comart.dart';

class ArticleScreen extends StatefulWidget {
  final List article;

  const ArticleScreen({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late bool done;
  var view = 0;

  void awaiting() async {
    final number = await addView(widget.article[9]);
    setState(() {
      view = number;
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
      child: done
          ? ImageContainer(
              width: double.infinity,
              imageUrl: widget.article[7],
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    iconTheme: const IconThemeData(color: Colors.white),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  extendBodyBehindAppBar: true,
                  body: ListView(
                    children: [
                      _NewsHeadline(article: widget.article),
                      _NewsBody(article: widget.article, view: view)
                    ],
                  )),
            )
          : const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }

  addView(i) async {
    var connection = globals.connection();
    await connection.open();

    await connection
        .execute("UPDATE articles SET _views = _views + 1 WHERE _id = $i;");

    final result =
        await connection.query("select _views from articles WHERE _id = $i;");

    return result[0][0];
  }
}

class _NewsBody extends StatelessWidget {
  final List article;
  final int view;

  const _NewsBody({
    Key? key,
    required this.article,
    required this.view,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTag(
                  backgroundColor: Colors.black,
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundImage: NetworkImage(
                        article[4],
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      article[3],
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
                const SizedBox(width: 5),
                CustomTag(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.add_comment_rounded,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Comments(
                                    articleID: article[9],
                                  )),
                        );
                      },
                    ),
                    const SizedBox(width: 1),
                  ],
                ),
                CustomTag(
                  backgroundColor: Colors.grey.shade200,
                  children: [
                    const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$view',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              article[0],
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              article[2],
              style:
                  Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.5),
            ),
            const SizedBox(height: 20),
            GridView.builder(
                shrinkWrap: true,
                itemCount: 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.75,
                ),
                itemBuilder: (context, index) {
                  return ImageContainer(
                    width: MediaQuery.of(context).size.width * 0.42,
                    imageUrl: article[7],
                    margin: const EdgeInsets.only(right: 5.0, bottom: 5.0),
                  );
                })
          ],
        ),
      ),
    );
  }
}

class _NewsHeadline extends StatelessWidget {
  final List article;

  const _NewsHeadline({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            CustomTag(
              backgroundColor: Colors.grey.withAlpha(150),
              children: [
                Text(
                  article[5].toString(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              article[0],
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.25,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              article[1],
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
