import 'package:flutter/material.dart';
import 'package:wellness/navPages/CreatNewDatePage.dart';
import 'package:wellness/theme/light_color.dart';
import 'package:wellness/model/dactor_model.dart';
import 'package:wellness/theme/text_styles.dart';
import 'package:wellness/theme/theme.dart';
import 'package:wellness/theme/extention.dart';
import 'package:wellness/widgets/progress_widget.dart';
import 'package:wellness/widgets/rating_start.dart';

class DetailPage extends StatefulWidget {
  // DetailPage({required Key key, required this.model}) : super(key: key);
  DetailPage({key, required this.model}) : super(key: key);

  final model;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late DoctorModelHome model;
  @override
  void initState() {
    model = widget.model;
    super.initState();
  }

  Widget _appbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        BackButton(color: Theme.of(context).primaryColor),
        // IconButton(
        //     icon: Icon(
        //       model.isfavourite ? Icons.favorite : Icons.favorite_border,
        //       color: model.isfavourite ? Colors.red : LightColor.grey,
        //     ),
        //     onPressed: () {
        //       setState(() {
        //         model.isfavourite = !model.isfavourite;
        //       });
        //     })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyles.title.copyWith(fontSize: 25).bold;
    if (AppTheme.fullWidth(context) < 393) {
      titleStyle = TextStyles.title.copyWith(fontSize: 23).bold;
    }
    return Scaffold(
      backgroundColor: LightColor.extraLightBlue,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Image.asset("lib/assets/doctor.png"),
            DraggableScrollableSheet(
              maxChildSize: .8,
              initialChildSize: .6,
              minChildSize: .6,
              builder: (context, scrollController) {
                return Container(
                  height: AppTheme.fullHeight(context) * .5,
                  padding: const EdgeInsets.only(
                      left: 19,
                      right: 19,
                      top: 16), //symmetric(horizontal: 19, vertical: 16),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                model.name,
                                style: titleStyle,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.check_circle,
                                  size: 18,
                                  color: Theme.of(context).primaryColor),
                              const Spacer(),
                              RatingStar(
                                rating: 2,
                              )
                            ],
                          ),
                          subtitle: Text(
                            model.type,
                            style: TextStyles.bodySm.subTitleColor.bold,
                          ),
                        ),
                        const Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        Row(
                          children: <Widget>[
                            ProgressWidget(
                                value: 2,
                                totalValue: 100,
                                activeColor: LightColor.purpleExtraLight,
                                backgroundColor:
                                    LightColor.grey.withOpacity(.3),
                                title: "Good Review",
                                durationTime: 500),
                            ProgressWidget(
                                value: 2,
                                totalValue: 100,
                                activeColor: LightColor.purpleLight,
                                backgroundColor:
                                    LightColor.grey.withOpacity(.3),
                                title: "Total Score",
                                durationTime: 300),
                            ProgressWidget(
                                value: 2,
                                totalValue: 100,
                                activeColor: LightColor.purple,
                                backgroundColor:
                                    LightColor.grey.withOpacity(.3),
                                title: "Satisfaction",
                                durationTime: 800),
                          ],
                        ),
                        const Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        Text("About", style: titleStyle).vP16,
                        // Text(
                        //   model.description,
                        //   style: TextStyles.body.subTitleColor,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: LightColor.grey.withAlpha(150)),
                              child: const Icon(
                                Icons.call,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: LightColor.grey.withAlpha(150)),
                              child: const Icon(
                                Icons.chat_bubble,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              // child: Theme.of(context).primaryColor,

                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreatNewDatePage(
                                      'CreatNewDatePage',
                                      model: widget.model,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "Make an appointment",
                                style: TextStyles.titleNormal.white,
                              ).p(10),
                            ),
                          ],
                        ).vP16
                      ],
                    ),
                  ),
                );
              },
            ),
            _appbar(),
          ],
        ),
      ),
    );
  }
}
