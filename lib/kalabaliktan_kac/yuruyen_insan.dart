
import 'dart:async';
import 'dart:math';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

double rastgeleX;
double rastgeleY;
int rastgeleHiz;
GlobalKey insanKey = GlobalKey();

AnimatedContainer YuruyenInsan(int YURUME_HIZI, bool YURUSUNMU)
{

if(YURUSUNMU)
  {
    rastgeleX =RastgeleXKonumuSec();
    rastgeleY =RastgeleYKonumuSec();
    rastgeleHiz = RastgeleSureSec();
  }


  return AnimatedContainer(
    key:insanKey,
    //width: 40,
    //color: Colors.cyan,
    duration: YURUSUNMU ? Duration(seconds: 0): Duration(seconds: rastgeleHiz),
    curve: Curves.linear,
    alignment: YURUSUNMU ? Alignment(rastgeleX, rastgeleY) : AlignmentDirectional(rastgeleX, 1.1),
    child: Container(
      //color: Colors.orange,
      width: 40,
      height: 40,
      child: Transform.rotate(angle: 3.1415,
        child: FlareActor("kaynaklar/animasyon/WalkTop.flr",
            alignment: Alignment.center, fit: BoxFit.contain, animation: "Walk"),
      ),
    ),
  );
}

_getPosition()
{
  final RenderBox insanRenderBox = insanKey.currentContext.findRenderObject();
  final pozisyonInsan = insanRenderBox.localToGlobal(Offset.zero);
  print(pozisyonInsan);
}
double RastgeleXKonumuSec() {
  var random = Random();
  return double.parse((random.nextDouble()*2.6 -1.3).toStringAsFixed(1));
}
double RastgeleYKonumuSec() {
  var random = Random();
  return double.parse((random.nextDouble()*(-1) -1.1).toStringAsFixed(1));
}
int RastgeleSureSec() {
  var random = Random();
  return random.nextInt(3) + 2;
}

InsanCokla (int INSAN_SAYISI, int YURUME_HIZI, bool YURUSUNMU) {

  List<Widget> YuruyenInsanList = new List();
  for (int i = 0; i < INSAN_SAYISI; i++) {
    print("İnsan eklendi");
    YuruyenInsanList.add(YuruyenInsan(YURUME_HIZI, YURUSUNMU));
  }
  return YuruyenInsanList;
}