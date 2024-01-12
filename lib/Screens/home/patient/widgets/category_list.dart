import 'package:flutter/material.dart';
import 'package:wellness/theme/extention.dart';

import '../../../../theme/light_color.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Category", style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                "See All",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).primaryColor,
                ),
              ).paddingAll(8)
              // .ripple(() {})
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .28,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              CategoryCard(
                title: "Chemist & Drugist",
                subtitle: "350 + Stores",
                color: Colors.black,
                lightColor: Colors.lightGreen,
              ),
              CategoryCard(
                title: "Covid - 19 Specialist",
                subtitle: "899 Doctors",
                color: LightColor.skyBlue,
                lightColor: Colors.lightBlue,
              ),
              CategoryCard(
                title: "Cardiologists Specialist",
                subtitle: "500 + Doctors",
                color: Colors.orange,
                lightColor: LightColor.lightOrange,
              ),
              CategoryCard(
                title: "Dermatologist",
                subtitle: "300 + Doctors",
                color: Colors.green,
                lightColor: Colors.lightGreen,
              ),
              CategoryCard(
                title: "General Surgeon",
                subtitle: "500 + Doctors",
                color: LightColor.skyBlue,
                lightColor: Colors.lightBlue,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final Color lightColor;

  const CategoryCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.lightColor,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle =
        TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
    TextStyle subtitleStyle =
        TextStyle(fontWeight: FontWeight.bold, color: Colors.white);

    if (MediaQuery.of(context).size.width < 392) {
      titleStyle =
          TextStyle(fontWeight: FontWeight.normal, color: Colors.white);
      subtitleStyle =
          TextStyle(fontWeight: FontWeight.normal, color: Colors.white);
    }

    return AspectRatio(
      aspectRatio: 6 / 8,
      child: Container(
          height: 280,
          width: MediaQuery.of(context).size.width * .3,
          margin:
              const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
          decoration: BoxDecoration(
            color: color, // Use the specified color here
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: const Offset(4, 4),
                blurRadius: 10,
                color: lightColor.withOpacity(.8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Container(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -20,
                    left: -20,
                    child: CircleAvatar(
                      backgroundColor: lightColor,
                      radius: 60,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        child:
                            Text(title, style: titleStyle).paddingHorizontal(8),
                      ),
                      const SizedBox(height: 10),
                      Flexible(
                        child: Text(subtitle, style: subtitleStyle)
                            .paddingHorizontal(8),
                      ),
                    ],
                  ).paddingAll(16),
                ],
              ),
            ),
          )),
    );
  }
}

extension CustomPadding on Widget {
  Widget paddingHorizontal(double value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: value),
      child: this,
    );
  }

  Widget paddingAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }
}
