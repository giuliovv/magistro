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
        .collection("subjects")
        .doc("matematica")
        .collection("areas")
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

          documents
              .sort((a, b) => a.data()['index'].compareTo(b.data()['index']));

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
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      // Check if the screen width is greater than 600 (desktop view)
      bool isDesktop = constraints.maxWidth > 600;
      if (isDesktop) {
        // Render the desktop UI
        return Scaffold(
          backgroundColor: Color(0xfff5f5f5),
          body: Row(children: [
            SizedBox(
              width: constraints.maxWidth * 0.2,
              child: RotatedBox(
                quarterTurns: -1,
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: const Center(
                    child: Text(
                      'MATH',
                      style: TextStyle(
                        fontSize: 200,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Container(
                    child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> data = widget.documents[index].data();

                    String documentId = widget.documents[index].id;
                    List<String> parts = documentId.split(" (");
                    String title = parts[0];
                    String subtitle = parts[1].replaceAll(")", "");

                    return ListTileElement(
                      title: title,
                      subtitle: subtitle,
                      color: Colors
                          .red, // Color(int.parse(data['color'], radix: 16)),
                      image: const NetworkImage(
                        "https://raw.githubusercontent.com/giuliovv/magistro_app/master/assets/assets/math/algebra_logo.png",
                      ),
                      area: documentId,
                    );
                  },
                  itemCount: widget.documents.length,
                  shrinkWrap: true,
                )),
              ),
            ),
          ]),
        );
      } else {
        // Render the mobile UI
        return Scaffold(
          backgroundColor: Color(0xfff5f5f5),
          body: Column(
            children: [
              const SizedBox(
                height: 120.0,
                child: Center(
                  child: Text(
                    'MATH',
                    style: TextStyle(
                      fontSize: 100,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(height: 20, color: Color(0xfff5f5f5)),
              Expanded(
                child: Center(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> data =
                          widget.documents[index].data();

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
                        area: documentId,
                      );
                    },
                    itemCount: widget.documents.length,
                    shrinkWrap: true,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
