import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import '../game_controller.dart';


class Kaldirim {
  final GameController gameController;
  Rect evlerRect;
  Sprite kaldirim;


  Kaldirim(this.gameController) {
    kaldirim = Sprite("kaldirim4.jpg");


  }

  void render(Canvas c) {
    kaldirim.render(c);
  }

  void update(double t) {

    kaldirim = Sprite("kaldirim4.jpg");

  }
}