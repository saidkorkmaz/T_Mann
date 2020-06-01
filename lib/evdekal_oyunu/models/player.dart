import 'dart:ui';

import 'package:flame/sprite.dart';

import '../game_controller.dart';



class Player {

  final GameController gameController;
  int maxHealth;
  int currentHealth;

  Rect playerRect;
  Sprite polis;

  bool isDead = false;


  Player(this.gameController) {
    maxHealth = currentHealth = 300;
    final size = gameController.tileSize * 1.5;
    playerRect = Rect.fromLTWH(
      gameController.screenSize.width / 2 - size / 2,
      gameController.screenSize.height / 2 - size / 2,
      size,
      size,
    );

    polis = Sprite("poliscik.png");

  }

  void render(Canvas c) {

    polis.renderRect(c, playerRect.inflate(2));
  }

  void update(double t) {
    if (!isDead && currentHealth <= 0) {
      isDead = true;
      gameController.initialize();
    }
  }

}