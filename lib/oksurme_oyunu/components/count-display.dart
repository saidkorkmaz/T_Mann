import 'dart:ui';
import 'package:corona_oyun/oksurme_oyunu/cough-game.dart';
import 'package:flutter/painting.dart';

class CountDisplay {
  final CoughGame game;
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
    if ((painter.text?.text ?? '') != game.newTissue.toString()) {
      count = 8 - game.newTissue;

      painter.text = TextSpan(
        text: 'Kalan hak: ' + count.toString(),
        style: textStyle,
      );
      painter.layout();
      position = Offset(
        game.screenSize.width - (game.tileSize * .30) - painter.width,
        game.tileSize * 1.10,
      );
    }
  }
}