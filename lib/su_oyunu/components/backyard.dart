import 'dart:ui';
import 'package:corona_oyun/su_oyunu/water-game.dart';
import 'package:flame/sprite.dart';

class Backyard{
  final WaterGame game;
  Sprite bgSprite;
  Rect bgRect;
  Paint bgPaint;


  Backyard(this.game){
    bgSprite = Sprite('bg/cl.png');
    bgPaint = Paint();
    bgPaint.color = Color(0xffdff9fb);

    bgRect = Rect.fromLTWH(
      0,
      game.screenSize.height - (game.tileSize * 23),
      game.tileSize *17,
      game.tileSize * 23,
    );
  }
  void render(Canvas c) {
    c.drawRect(bgRect, bgPaint);
    bgSprite.renderRect(c, bgRect);
  }

  void update(double t) {}

}