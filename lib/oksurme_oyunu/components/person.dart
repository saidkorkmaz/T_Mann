import 'dart:math';
import 'dart:ui';
import 'package:corona_oyun/oksurme_oyunu/components/tissue.dart';
import 'package:corona_oyun/oksurme_oyunu/cough-game.dart';
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
class Person{
  final CoughGame game;
  Rect personRect,personBgRect;
  Sprite personSprite;
  Sprite personSprite2;
  double posx;
  double posy;
  Tissue tissue;
  Paint windowPaint;
  Window window;

  Random  rnd;
  int random;
  Person(this.game, double x, double y){
    rnd= Random();

    personRect = Rect.fromLTWH(x, y-5, game.tileSize/1.2, game.tileSize/1.2);
    personBgRect = Rect.fromLTWH(x-20, y-40, game.tileSize*2, game.tileSize*2);

    personSprite = Sprite('cough.png');
    personSprite2 = Sprite('coughman.png');
    windowPaint = Paint();
    windowPaint.color = Color(0xfff7f1e3);

  }
  void render(Canvas c){
    c.drawRect(personBgRect, windowPaint);

    if(game.visible){
      if(game.random==0)
        personSprite.renderRect(c, personRect.inflate(game.heightTileSize/60));
      else
        personSprite2.renderRect(c, personRect.inflate(game.heightTileSize/60));


    }
  }
  void update (double t){
    random= rnd.nextInt(2);
    game.visible = true;

    game.getPerson(personRect.top.toInt(),personRect.left.toInt());

  }

}