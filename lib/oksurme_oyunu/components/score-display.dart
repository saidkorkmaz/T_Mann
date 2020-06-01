import 'dart:ui';
import 'package:corona_oyun/oksurme_oyunu/cough-game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
class ScoreDisplay {
  final CoughGame game;
  Paint scorePaint;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;
  Sprite dotSprite;
  Rect scoreRect;
  int total= 0;
  double x=0;
  double y =0;


  ScoreDisplay(this.game) {
    scorePaint = Paint();
    scorePaint.color = Color(0xff8FBF87);
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
        TextStyle(color: Color(0xffffffff), fontSize: 40,


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
    c.scale(game.screenSize.height/5);
    c.translate(0,0);
    c.drawCircle(Offset(((game.screenSize.width / 6) - (29 / 1.9))/113,((game.screenSize.height * .07) - (59 /3))/80), 0.25, scorePaint);
    c.restore();
    painter.paint(c, position);

  }

  void update(double t) {
    if ((painter.text?.text ?? '') != game.score.toString()) {
      total =   game.score;
      if(total ==-1){
        total =0;

      }


      painter.text = TextSpan(


        text: total.toString(),
        style: textStyle,
      );
      painter.layout();

      if (total<10){
        // print("iftee");
        position = Offset(

          (game.screenSize.width / 5.9) - (28 / 1.9),
          (game.screenSize.height * .073) - (50 /3),
        );

      }else if(total<100){
        position = Offset(

          (game.screenSize.width / 7.5) - (20 / 1.9),
          (game.screenSize.height * .073) - (54 /3),
        );

      }else{
        position = Offset(

          (game.screenSize.width / 13.5) - (10 / 1.9),
          (game.screenSize.height * .073) - (54 /3),
        );
      }

      print(((painter.width )));

    }
  }
}
