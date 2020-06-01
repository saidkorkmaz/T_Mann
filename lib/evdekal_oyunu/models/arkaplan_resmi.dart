import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import '../game_controller.dart';


class Resim {
  final GameController gameController;
  Offset position;
  Rect evlerRect;
  Sprite evler;


  Resim(this.gameController) {
    evler = Sprite("evler.png");


  }

  void render(Canvas c) {
     evler.render(c);
  }

  void update(double t) {

    evler = Sprite("evler.png", height: 400, width: 400);

    position = Offset(
      (gameController.screenSize.width - 10),
      (gameController.screenSize.height - 300),
    );
  }
}