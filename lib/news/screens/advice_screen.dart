import '../../../../globals.dart' as globals;
import '../widgets/image_container.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_tag.dart';
import '../comments/comAd.dart';

class AdviceScreen extends StatefulWidget {
  final List advice;

  const AdviceScreen({
    Key? key,
    required this.advice,
  }) : super(key: key);

  @override
  State<AdviceScreen> createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen> {
  late bool done;
  var view = 0;

  void awaiting() async {
    final number = await addView(widget.advice[9]);
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
              imageUrl: widget.advice[7],
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
                      _NewsHeadline(advice: widget.advice),
                      _NewsBody(advice: widget.advice, view: view)
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
  final List advice;
  final int view;

  const _NewsBody({
    Key? key,
    required this.advice,
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
              children: [
                CustomTag(
                  backgroundColor: Colors.black,
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundImage: NetworkImage(
                        advice[4],
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      advice[3],
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
                              builder: (context) => ComAdv(
                                    articleID: advice[9],
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
              advice[0],
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              advice[2],
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
                    imageUrl: advice[7],
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
  const _NewsHeadline({
    Key? key,
    required this.advice,
  }) : super(key: key);

  final List advice;

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
                  advice[5].toString(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              advice[0],
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.25,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              advice[1],
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
