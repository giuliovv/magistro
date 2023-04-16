import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'components/math_components.dart';

class GetMathInfo extends StatefulWidget {
  const GetMathInfo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GetMathInfoState();
}

class _GetMathInfoState extends State<GetMathInfo> {
  late dynamic topics;
  @override
  void initState() {
    super.initState();
    topics = FirebaseFirestore.instance
        .collection("Argomenti")
        .where("subject", isEqualTo: "Matematica")
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
          return MathSelection(documents: documents);
        }

        return const Text("loading");
      },
    );
  }
}

class MathSelection extends StatefulWidget {
  const MathSelection({Key? key, required this.documents}) : super(key: key);

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;

  @override
  State<MathSelection> createState() => _MathSelectionState();
}

class _MathSelectionState extends State<MathSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: CustomScrollView(
        slivers: <Widget>[
          const CustomAppBar(),
          const CurvedSeparator(),
          const Headertext(
            title: "Math Topics",
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              Map<String, dynamic> data = widget.documents[index].data();

              String documentId = widget.documents[index].id;
              List<String> parts = documentId.split(" (");
              String title = parts[0];
              String subtitle = parts[1].replaceAll(")", "");

              return ListTileElement(
                title: title,
                subtitle: subtitle,
                color: Color(int.parse(data['color'], radix: 16)),
                image: NetworkImage(
                  data['logo'],
                ),
                units: data['units']
                    .values
                    .map((value) => value as String)
                    .toList(),
              );
            },
            childCount: widget.documents.length,
          )),
        ],
      ),
    );
  }
}
