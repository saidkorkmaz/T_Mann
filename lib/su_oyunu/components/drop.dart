import 'dart:ui';
import 'package:corona_oyun/su_oyunu/water-game.dart';
import 'package:flame/sprite.dart';

class Drop {
  final WaterGame game;
  Rect dropRect;
  //Paint dropPaint;
  bool isOffScreen= false; //ekrandan çıkan damlacık sayısı
  bool isTouch = false;
  Sprite fallingDrop;



  Drop(this.game, double x, double y){
    dropRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    fallingDrop = Sprite('water-drop.png');

  }
  void render(Canvas c){
    fallingDrop.renderRect(c, dropRect.inflate(2));
  }
  void update(double t){
    if(game.fallingDropCount<5){
      game.dropCoefficient =6.0;
    }
    dropRect =dropRect.translate(0, game.tileSize* game.dropCoefficient* t);
    game.dropCoefficient += 0.001;
    if (dropRect.top > game.screenSize.height) {
      isOffScreen = true;
      game.isOffScreenCount += 1;
      if (game.isOffScreenCount>5){
        game.isOffScreenCount=5;
      }
   //   print(game.isOffScreencount);

    }
    if (dropRect.bottom>580){
      isTouch=true;
      game.newOne = true;
      game.getDrop(dropRect.top, dropRect.right-((dropRect.right -dropRect.left)/2));
    }


  }

}