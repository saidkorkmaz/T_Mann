import 'dart:math';
import 'dart:ui';
import 'package:corona_oyun/oksurme_oyunu/controllers/spawner.dart';
import 'package:corona_oyun/oksurme_oyunu/cough-game.dart';
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
class Window{
  final CoughGame game;
  Rect windowRect;
  List<Sprite> windowSprite;
  Sprite openWindowSprite, closeWindowSprite;
  double posx;
  double posy;
  int windowIndex = 0;
  Random random;
  int ran;
  PersonSpawner personSpawner;


  Window(this.game, double x, double y){

    personSpawner = PersonSpawner(this.game);
    random = Random();
    windowRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    windowSprite = List();


    openWindowSprite = Sprite('open_window.png');
    closeWindowSprite = Sprite('window_closed.png');

    //   windowSprite.add(Sprite('closed_window.png'));
    // windowSprite.add(Sprite('opened_window.png'));

  }
  void render(Canvas c){


    if(windowIndex==1)
      openWindowSprite.renderRect(c, windowRect.inflate(game.heightTileSize/28));
    else
      closeWindowSprite.renderRect(c, windowRect.inflate(game.heightTileSize/28));


    //  windowSprite[windowIndex.toInt()].renderRect(c, windowRect.inflate(50));
  }
  void update (double t) {
    if (windowIndex == 1) {
      game.windowIsOpen = true;
    } else {
      game.windowIsOpen = false;
    }

    if (game.showingPerson == false) {
      windowIndex = 0;
    }
    if (game.showingPerson) {
      windowIndex = 1;
    }
    /* ran =game.rnd.nextInt(5);
   // print(windowIndex);
    windowIndex += ran *0.2* t;
    while (windowIndex >= 2) {
      windowIndex -= 2;
    }*/
    /*   if(personSpawner.personShowed==false){
      windowIndex=0;
    }
    else if(personSpawner.personShowed){
      windowIndex=1;
    }*/



  }
  void onTap() {}

}