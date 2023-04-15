import 'package:flutter/material.dart';

class MathSelection extends StatefulWidget {
  const MathSelection({super.key});

  @override
  State<MathSelection> createState() => _MathSelectionState();
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SliverAppBar(
      pinned: false,
      snap: false,
      floating: true,
      expandedHeight: height * 0.4,
      backgroundColor: const Color(0xfffcc299),
      flexibleSpace: const FlexibleSpaceBar(
          background: Image(
        image: AssetImage('assets/math/math_appbar.png'),
        fit: BoxFit.contain,
      )),
    );
  }
}

class CurvedSeparator extends StatelessWidget {
  const CurvedSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: const Color(0xfffcc299),
        height: 20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              height: 20,
              decoration: const BoxDecoration(
                color: Color(0xfff5f5f5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Headertext extends StatelessWidget {
  const Headertext({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    double cardWidth = width * 0.9 < 400 ? width * 0.9 : 400;
    return SliverToBoxAdapter(
        child: Container(
      margin: EdgeInsets.symmetric(
          horizontal: (width - cardWidth) / 2, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Math topics',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'A curated selection of topics to help you master math. From basic arithmetic to calculus and linear algebra there is something for everyone.',
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    ));
  }
}

class ListTileElement extends StatelessWidget {
  const ListTileElement(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.color,
      required this.image})
      : super(key: key);

  final String title;
  final String subtitle;
  final AssetImage image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    double cardWidth = width * 0.9 < 400 ? width * 0.9 : 400;
    return Container(
      height: height * 0.2,
      margin: EdgeInsets.symmetric(horizontal: (width - cardWidth) / 2),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        ),
        width: cardWidth,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: cardWidth * 0.05),
            Container(
              width: 0.4 * cardWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: cardWidth * 0.05),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: (height * 0.2 - height * 0.15) / 2),
              width: cardWidth * 0.4,
              height: height * 0.15,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                  image: image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
          const Headertext(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const ListTileElement(
                  title: "Algebra",
                  subtitle: "Fucking algebra",
                  color: Color(0xffAEC8E8),
                  image: AssetImage('assets/math/algebra_logo.png'),
                ),
                const SizedBox(height: 10),
                const ListTileElement(
                  title: "Statistics",
                  subtitle: "Fucking statistics",
                  color: Color(0xffB2A1C7),
                  image: AssetImage('assets/math/statistics_logo.png'),
                ),
                const SizedBox(height: 10),
                const ListTileElement(
                  title: "Some shit",
                  subtitle: "Fucking shit",
                  color: Color(0xffB0C4A4),
                  image: AssetImage('assets/math/algebra_logo.png'),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
