import 'dart:ui';
import 'package:corona_oyun/oksurme_oyunu/cough-game.dart';
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
class Tissue {
  final CoughGame game;
  Rect tissueRect;
  Sprite tissueSprite;
  double posx;
  double posy;
  Offset targetLocation;
  bool isOffScreen = false;
  bool isTouch=false;

  double get speed => game.tileSize * 26;

  Tissue(this.game, double x, double y) {
    tissueRect = Rect.fromLTWH(x-2, y-18, game.tileSize+5, game.tileSize-5);
    tissueSprite = Sprite('tissubox.png');
    targetLocation=Offset(tissueRect.left+20, tissueRect.top);
    // setTargetLocation();
  }
  void render(Canvas c) {
    if (true) {
      tissueSprite.renderRect(c, tissueRect.inflate(game.heightTileSize/40));
    }
  }
  void update(double t) {
    game.visible = true;
    if(isOffScreen){
      game.visible = false;
    }

    if (tissueRect.top > game.screenSize.height) {
      isOffScreen = true;
    }
    if (game.touchPositionDx == 0.0) {
      tissueRect = tissueRect.translate(0, 0);

    }  if ((game.touchPositionDy - tissueRect.top < -40 &&
        game.touchPositionDy - tissueRect.top > -630.6666666666666) && game.startDrag) {

      /*tissueRect = tissueRect.translate(
          (game.touchPositionDx - tissueRect.left),
          (game.touchPositionDy - tissueRect.top));*/
      double x = 100 *
          (game.touchPositionDx - tissueRect.left+20);
      double y = 100 *
          (game.touchPositionDy - tissueRect.top);
      targetLocation = Offset(x, y);

      double stepDistance = speed * t;
      Offset toTarget = targetLocation - Offset(tissueRect.left+20, tissueRect.top);

      if (stepDistance < toTarget.distance) {
       // print("if");
        Offset stepToTarget = Offset.fromDirection(toTarget.direction, stepDistance);
        stepToTarget = Offset.fromDirection(toTarget.direction, stepDistance*1.1);
        tissueRect = tissueRect.shift(stepToTarget);
        if (tissueRect.top > game.screenSize.height) {
          isOffScreen = true;
        }
        if(game.newOne){

          tissueRect = tissueRect.translate(0, 0);
        }

      }else {
        print("else");
        tissueRect = tissueRect.shift(toTarget);
        setTargetLocation();
      }
    }

    if(tissueRect.topCenter.dy.toInt()<game.screenSize.height-game.tileSize){
      isTouch=true;
      game.newOne = true;
      game.getTissue(tissueRect.topCenter.dy.toInt(), tissueRect.center.dx.toInt());
    }
    //bardağın konumunun water-game e göderilmesi
  }
  void setTargetLocation() {
    //rastgele bir hedef belirler.
    //bunu update in içine yazsak sürekli belirler ve uçan şey sallanır.

  }
}