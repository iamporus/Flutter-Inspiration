import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseBuilderWidget.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';

class ProfileDraggableCardWidget extends StatefulWidget {
  const ProfileDraggableCardWidget({
    Key key,
  }) : super(key: key);

  @override
  _ProfileDraggableCardWidgetState createState() =>
      _ProfileDraggableCardWidgetState();
}

class _ProfileDraggableCardWidgetState
    extends State<ProfileDraggableCardWidget> {
  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(builder: (context, screenSizeInfo) {
      return Material(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              height: screenSizeInfo.screenHeight * 0.08,
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(screenSizeInfo.paddingLarge),
                  topLeft: Radius.circular(screenSizeInfo.paddingLarge),
                ),
                color: Colors.black.withOpacity(0.05),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SocialInfoWidget(
                    title: "869",
                    subtitle: "followers",
                  ),
                  SocialInfoWidget(
                    title: "135",
                    subtitle: "posts",
                  ),
                  SocialInfoWidget(
                    title: "485",
                    subtitle: "following",
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(screenSizeInfo.paddingLarge),
                  topLeft: Radius.circular(screenSizeInfo.paddingLarge),
                ),
              ),
              height: screenSizeInfo.screenHeight * 0.45,
              width: screenSizeInfo.screenWidth,
              padding: EdgeInsets.all(screenSizeInfo.paddingMedium),
              margin: EdgeInsets.all(screenSizeInfo.paddingSmall * 0.5),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ProfileWidget(
                        name: "Lori Perez",
                        location: "France, Nantes",
                      ),
                      Spacer(),
                      FollowButtonWidget()
                    ],
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.all(screenSizeInfo.paddingSmall * 1.5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Photos",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.5),
                            fontSize: screenSizeInfo.textSizeSmall * 1.5),
                      ),
                    ),
                  ),
                  Container(
                    height: screenSizeInfo.screenHeight * 0.10,
                    width: screenSizeInfo.screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.fromLTRB(
                        screenSizeInfo.paddingSmall * 1.5, 0, 0, 0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        SizedBox(
                          height: 150,
                          width: 90,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child:
                                Image.asset("assets/ivana_cajina_unsplash.jpg"),
                          ),
                        ),
                        SizedBox(width: 10,),
                        SizedBox(
                          height: 150,
                          width: 90,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child:
                                Image.asset("assets/ivana_cajina_unsplash.jpg"),
                          ),
                        ),
                        SizedBox(width: 10,),
                        SizedBox(
                          height: 150,
                          width: 90,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child:
                                Image.asset("assets/ivana_cajina_unsplash.jpg"),
                          ),
                        ),
                        SizedBox(width: 10,),
                        SizedBox(
                          height: 150,
                          width: 90,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child:
                            Image.asset("assets/ivana_cajina_unsplash.jpg"),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class FollowButtonWidget extends StatefulWidget {
  @override
  _FollowButtonWidgetState createState() => _FollowButtonWidgetState();
}

class _FollowButtonWidgetState extends State<FollowButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(
      builder: (context, screenSizeInfo) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: OutlineButton(
            onPressed: () {},
            textColor: Colors.red.shade700,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            borderSide: BorderSide(
                color: Colors.red.shade700, style: BorderStyle.solid),
            child: Text(
              "FOLLOW",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProfileWidget extends BaseStatelessWidget {
  final name;
  final location;

  const ProfileWidget({
    Key key,
    @required this.name,
    @required this.location,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Padding(
      padding: EdgeInsets.all(screenSizeInfo.paddingSmall * 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              color: Colors.black,
              fontSize: screenSizeInfo.textSizeMedium * 1.2,
            ),
          ),
          Text(
            location,
            style: TextStyle(
              color: Colors.grey,
              fontSize: screenSizeInfo.textSizeSmall * 1.3,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}

class SocialInfoWidget extends BaseStatelessWidget {
  final subtitle;
  final title;

  const SocialInfoWidget(
      {Key key, @required this.title, @required this.subtitle})
      : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          screenSizeInfo.paddingLarge,
          screenSizeInfo.paddingSmall,
          screenSizeInfo.paddingLarge,
          screenSizeInfo.paddingSmall),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: screenSizeInfo.textSizeSmall * 1.5),
            ),
            Text(
              subtitle,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  fontSize: screenSizeInfo.textSizeSmall * 1.5),
            )
          ],
        ),
      ),
    );
  }
}
