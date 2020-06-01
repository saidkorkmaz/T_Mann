import 'dart:ui';
import 'package:corona_oyun/su_oyunu/water-game.dart';
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
class Glass{
  final WaterGame game;
  Rect glassRect;
  List<Sprite> glassSprite;
//  Sprite ;
  double posx;
  double posy;
  int glassIndex = 0;
  bool fourToOne= false;

  Glass(this.game, double x, double y){
    glassRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
   // glassSprite = Sprite('');
    glassSprite = List();
    glassSprite.add(Sprite('glass25.png'));
    glassSprite.add(Sprite('glass50.png'));
    glassSprite.add(Sprite('glass75.png'));
    glassSprite.add(Sprite('glass100.png'));
    posx = game.touchPositionDx;
  }
  void render(Canvas c){
 //   glass.renderRect(c, glassRect.inflate(20));
    glassSprite[glassIndex].renderRect(c, glassRect.inflate(15));
  }
  void update (double t){

    glassIndex = game.score % 4;

  // print(game.touchPositionDx-glassRect.left);
    //bardağın sağa sola hareketi
    if(game.touchPositionDx == posx){
      glassRect =glassRect.translate(0, 0);
    }else{
      glassRect =glassRect.translate(game.touchPositionDx-glassRect.left, 0);
    }
    //bardağın konumunun water-game e göderilmesi
    game.getGlass(glassRect.top, glassRect.right-((glassRect.right -glassRect.left)/2));



  }

}