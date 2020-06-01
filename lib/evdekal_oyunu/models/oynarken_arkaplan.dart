import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import '../game_controller.dart';


class Resim2 {
  final GameController gameController;
  Offset position;
  Rect evlerRect, ev2Rect;
  Sprite evler, ev2;


  Resim2(this.gameController) {
    evler = Sprite("guzel_ev.jpg");
    ev2 = Sprite("evler9.png");

    final size = gameController.tileSize * 2;

    evlerRect = Rect.fromLTWH(
      1,
      1 ,
      gameController.screenSize.width,
      size + 10,
    );

    ev2Rect = Rect.fromLTWH(
      1,
      gameController.screenSize.height / 2 + size * 3.5,
      gameController.screenSize.width,
      size,
    );

  }

  void render(Canvas c) {
    evler.renderRect(c, evlerRect.inflate(2));
    ev2.renderRect(c, ev2Rect.inflate(2));
  }

  void update(double t) {

    evler = Sprite("guzel_ev.jpg");
    ev2 = Sprite("evler9.png");


  }
}