import 'package:flutter/material.dart';

import 'components/math_components.dart';

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
          const Headertext(
            title: "Math lessons",
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
                units: [],
              );
            },
            childCount: widget.units.length,
          )),
        ],
      ),
    );
  }
}
