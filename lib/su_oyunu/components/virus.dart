import 'dart:ui';
import 'package:corona_oyun/su_oyunu/water-game.dart';
import 'package:flame/sprite.dart';

class Virus {
  final WaterGame game;
  Rect virusRect;
  //Paint virusPaint;
  //double creationTimer = 0.0;
  // bool isOffScreen= false;
  Sprite fallingVirus;
  double virusSpriteIndex = 0;
  bool isVirusOffScreen =false;
  //virüsün hızlanma katsayısı
  Virus(this.game, double x, double y){

    virusRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    fallingVirus = Sprite('moradovirus.png');
  }
  void render(Canvas c){
    fallingVirus.renderRect(c, virusRect.inflate(2));
  }
  void update(double t){
    //print(game.virusSpawner.virusCoefficient);
   // print(game.virusSpeed);
    virusRect =virusRect.translate(0, game.tileSize * game.virusSpeed * t);

    if (virusRect.top > game.screenSize.height) {
      isVirusOffScreen = true;
      //game.isOffScreencount += 1;
      //   print(game.isOffScreencount);

    }
    if (virusRect.bottom>610){
      //    isTouch=true;
      //  game.newOne = false;
      game.getVirus(virusRect.top, virusRect.right-((virusRect.right -virusRect.left)/2));
    }
  }

}