import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

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
              documents: documents);
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
      required this.documents})
      : super(key: key);

  final String title;
  final String subtitle;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;

  @override
  State<MathLesson> createState() => _MathLessonState();
}

class _MathLessonState extends State<MathLesson> {
  List<Item> _data = [];

  @override
  void initState() {
    super.initState();
    _data = List.castFrom(widget.documents)
        .map((e) => Item(
            headerValue: e.id,
            expandedValue: e
                .data()["units"]
                .map((key, value) => MapEntry(key, value.toString()))
                .cast<String, String>()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: CustomScrollView(
        slivers: <Widget>[
          Headertext(
            title: "Lezioni di ${widget.title}",
          ),
          SliverFillRemaining(
            child: ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                final item = _data[index];
                return ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      item.isExpanded = !isExpanded;
                    });
                  },
                  children: [
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(item.headerValue),
                        );
                      },
                      body: Column(
                        children: item.expandedValue.entries
                            .map(
                              (entry) => ListTile(
                                title: Text("Esercizio ${entry.key}"),
                                subtitle: Text(entry.value),
                                trailing: const Icon(Icons.delete),
                                onTap: () {
                                  setState(() {
                                    _data.removeAt(index);
                                  });
                                },
                              ),
                            )
                            .toList(),
                      ),
                      isExpanded: item.isExpanded,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  Map<String, String> expandedValue;
  String headerValue;
  bool isExpanded;
}
