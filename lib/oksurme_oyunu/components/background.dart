import 'dart:ui';
import 'package:corona_oyun/oksurme_oyunu/cough-game.dart';
import 'package:flame/sprite.dart';
class BackGround{
  final CoughGame game;
  Sprite bgSprite;
  Rect bgRect;
  Paint bgPaint;

  BackGround(this.game){
    bgRect = Rect.fromLTWH(
      0,
      game.screenSize.height - (game.tileSize * 23),//23
      game.tileSize * 19,//9
      game.tileSize * 23,
    );
    bgPaint = Paint();
    bgPaint.color = Color(0xffffda79);
    //#ffda79    sarı
    //0xff652085
  }
  void render(Canvas c) {
    c.drawRect(bgRect, bgPaint);
    //  bgSprite.renderRect(c, bgRect);
  }

  void update(double t) {}

}