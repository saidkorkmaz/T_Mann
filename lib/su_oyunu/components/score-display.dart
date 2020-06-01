import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:corona_oyun/su_oyunu/water-game.dart';

class ScoreDisplay {
  final WaterGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;
  //Sprite dotSprite;
  Rect scoreRect;
  Paint scorePaint;


  ScoreDisplay(this.game) {
    //dotSprite = Sprite('greendot2.png');
    scorePaint = Paint();
    scorePaint.color = Color(0xff652085);
    scoreRect = Rect.fromLTWH(
      game.tileSize -17,
      (game.screenSize.height / 2) - (game.tileSize * 9),
      game.tileSize * 2,
      game.tileSize * 2,
    );

    painter = TextPainter(

      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      //left to right: yazı yönü soldan sağa
    );
    textStyle =
        TextStyle(color: Color(0xffffffff), fontSize: 50,
            shadows: <Shadow>[
      Shadow(
        blurRadius: 3,
        color: Color(0xff000000),
        offset: Offset(3, 3),
        //sağa ve aşağıya 3 pixel gölge
      )
    ]);

    position = Offset.zero;
  }

  void render(Canvas c) {

    c.save();
    c.scale(game.screenSize.height/5.2);
    c.translate(0,0);
    c.drawCircle(Offset(0.45,0.4), 0.25, scorePaint);
    c.restore();
    painter.paint(c, position);
  }

  void update(double t) {
    if ((painter.text?.text ?? '') != game.totalScore.toString()) {
      painter.text = TextSpan(
        text: game.totalScore.toString(),
        style: textStyle,
      );
      painter.layout();

      position = Offset(

        (game.screenSize.width / 5.6) - (painter.width / 2),
        (game.screenSize.height * .08) - (painter.height / 2),
      );
    }
  }
}
