import 'package:flutter/cupertino.dart';

Widget authenticationComponents(context) {
  Size size = MediaQuery.of(context).size;
  return Stack(alignment: Alignment.center, children: <Widget>[
    Positioned(
      top: 0,
      right: 0,
      child: Image.asset("assets/images/top1.png", width: size.width),
    ),
    Positioned(
      top: 0,
      right: 0,
      child: Image.asset("assets/images/top2.png", width: size.width),
    ),
    Positioned(
      bottom: 0,
      right: 0,
      child: Image.asset("assets/images/bottom1.png", width: size.width),
    ),
    Positioned(
      bottom: 0,
      right: 0,
      child: Image.asset("assets/images/bottom2.png", width: size.width),
    ),
  ]);
}

Widget signinComponents(context) {
  Size size = MediaQuery.of(context).size;
  return Stack(children: <Widget>[
    Positioned(
      top: 100,
      right: 160,
      child: Image.asset("assets/images/topleft.png", width: size.width),
    ),
  ]);
}

Widget signupComponents(context) {
  Size size = MediaQuery.of(context).size;
  return Stack(children: <Widget>[
      Positioned(
            top: 90,
            right: 160,
            child: Image.asset("assets/images/topleft.png", width: size.width),
          ),
  ]);
}
