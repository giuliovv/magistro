import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'components/math_components.dart';

class GetLessonsInfo extends StatefulWidget {
  const GetLessonsInfo(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.area})
      : super(key: key);

  final String title;
  final String subtitle;
  final String area;

  @override
  State<StatefulWidget> createState() => _GetLessonsInfoState();
}

class _GetLessonsInfoState extends State<GetLessonsInfo> {
  late Future<QuerySnapshot<Map<String, dynamic>>>? topics;
  @override
  void initState() {
    super.initState();
    topics = FirebaseFirestore.instance
        .collection("subjects")
        .doc("matematica")
        .collection("areas")
        .doc(widget.area)
        .collection("topics")
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: topics,
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
          // return const Text("Something went wrong :(");
        }

        if (snapshot.data == null) {
          return const Text("Loading...");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
              snapshot.data!.docs;
          return MathLesson(
            title: widget.title,
            subtitle: widget.subtitle,
            units: documents.map((e) => e.id).toList(),
          );
        }

        return const Text("loading");
      },
    );
  }
}

class MathLesson extends StatefulWidget {
  const MathLesson(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.units})
      : super(key: key);

  final String title;
  final String subtitle;
  final List<dynamic> units;

  @override
  State<MathLesson> createState() => _MathLessonState();
}

class _MathLessonState extends State<MathLesson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: CustomScrollView(
        slivers: <Widget>[
          const CustomAppBar(),
          const CurvedSeparator(),
          Headertext(
            title: "${widget.title} lessons",
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              String title = "Lesson ${index + 1}";
              String subtitle = widget.units[index];

              return ListTileElement(
                title: title,
                subtitle: subtitle,
                color: Color.fromARGB(255, 230, 95, 95),
                image: NetworkImage(
                  'https://raw.githubusercontent.com/giuliovv/magistro/master/assets/math/statistics_logo.png',
                ),
                area: "",
              );
            },
            childCount: widget.units.length,
          )),
        ],
      ),
    );
  }
}
