import 'dart:ui';
import 'package:flame/sprite.dart';

import '../game_controller.dart';


class Enemy {
  final GameController gameController;
  int health;
  int damage;
  double speed;
  Rect enemyRect;

  Sprite dusman;

  bool isDead = false;

  Enemy(this.gameController, double x, double y) {
    health = 3;
    damage = 1;
    speed = gameController.tileSize * 2;
    enemyRect = Rect.fromLTWH(
      x,
      y,
      gameController.tileSize * 1.2,
      gameController.tileSize * 1.2,
    );

    dusman = Sprite("insan.png");
  }

  void render(Canvas c) {
   dusman.renderRect(c, enemyRect.inflate(2));
  }

  void update(double t) {
    if (!isDead) {
      double stepDistance = speed * t;
      Offset toPlayer =
          gameController.player.playerRect.center - enemyRect.center;
      if (stepDistance <= toPlayer.distance - gameController.tileSize * 1.25) {
        Offset stepToPlayer =
        Offset.fromDirection(toPlayer.direction, stepDistance);
        enemyRect = enemyRect.shift(stepToPlayer);
      } else {
        attack();
      }
    }
  }

  void attack() {
    if (!gameController.player.isDead) {
      gameController.player.currentHealth -= damage;
    }
  }

  void onTapDown() {
    if (!isDead) {
      health--;
      if (health <= 0) {
  //      print("GAME OVER");
        isDead = true;
        gameController.score++;
      //  if (gameController.score > (gameController.storage.getInt('highscore') ?? 0)) {
         // gameController.storage.setInt('highscore', gameController.score);
       // }
      }
    }
  }
}