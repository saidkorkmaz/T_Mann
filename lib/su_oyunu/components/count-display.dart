import 'dart:ui';
import 'package:corona_oyun/su_oyunu/water-game.dart';
import 'package:flutter/painting.dart';

class CountDisplay {
  final WaterGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;
  int count;

  CountDisplay(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,

    );

    Shadow shadow = Shadow(
      blurRadius: 10,
      color: Color(0xff000000),
      offset: Offset.zero,
    );

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 19,
     shadows: [shadow, shadow, shadow, shadow],
    );

    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }
  void update(double t){
   // int highscore = game.storage.getInt('highscore') ?? 0;
    if ((painter.text?.text ?? '') != game.isOffScreenCount.toString()) {
      count = 5 - game.isOffScreenCount;

      painter.text = TextSpan(
        text: 'Kalan hak: ' + count.toString(),
        style: textStyle,
      );
      painter.layout();
      position = Offset(
        game.screenSize.width - (game.tileSize * .30) - painter.width,
        game.tileSize * .90,
      );
    }
  }
}