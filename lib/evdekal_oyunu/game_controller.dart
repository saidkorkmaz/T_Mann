import 'dart:math';
import 'dart:ui';

import 'package:corona_oyun/evdekal_oyunu/evdekal_ui.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'enemy_spawner.dart';
import 'models/arkaplan_resmi.dart';
import 'models/enemy.dart';
import 'models/health_bar.dart';
import 'models/highscore_text.dart';
import 'models/kaldirim.dart';
import 'models/oynarken_arkaplan.dart';
import 'models/player.dart';
import 'models/score_text.dart';
import 'models/start_text.dart';

class GameController extends Game {
  final EvdeKalUIState ui;


 // final SharedPreferences storage;
  Random rand;
  Size screenSize;
  double tileSize;
  Player player;
  EnemySpawner enemySpawner;
  List<Enemy> enemies;
  HealthBar healthBar;
  int score= 0;
  ScoreText scoreText;
  Stater state;
  HighscoreText highscoreText;
  StartText startText;

  Resim evler;
  Resim2 merkez;
  Kaldirim kaldirim;
  bool gameOver= false;
  int temp;

  GameController(this.ui) {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    state = Stater.menu;
    rand = Random();
    kaldirim = Kaldirim(this);
    player = Player(this);
    enemies = List<Enemy>();
    enemySpawner = EnemySpawner(this);
    healthBar = HealthBar(this);
    score = 0;
    scoreText = ScoreText(this);
    highscoreText = HighscoreText(this);
    startText = StartText(this);
    evler = Resim(this);
    merkez = Resim2(this);


  }

  void render(Canvas c) {
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xFFFFFFFF);
    c.drawRect(background, backgroundPaint);



    player.render(c);

    if (state == Stater.menu ) {
      startText.render(c);
      evler.render(c);
     // highscoreText.render(c);
    } else if (state == Stater.playing) {
      kaldirim.render(c);
      player.render(c);
      enemies.forEach((Enemy enemy) => enemy.render(c));
      scoreText.render(c);
      healthBar.render(c);
      merkez.render(c);


    }
  }

  void update(double t) {
 //   print(score);
    if(score>0){
      temp=score;
    }
    if(temp ==null){
      temp  =0;
    }


    if (state == Stater.menu) {
      if(gameOver){
        enemies.clear();
        super.pauseEngine();
        print("DİĞER IF"+score.toString());
        gameIsOver();
        gameOver=false;
      }
      startText.update(t);
     // highscoreText.update(t);
      evler.update(t);
    } else if (state == Stater.playing) {
      gameOver = true;
      kaldirim.update(t);
      player.update(t);
      enemySpawner.update(t);
      enemies.forEach((Enemy enemy) => enemy.update(t));
      enemies.removeWhere((Enemy enemy) => enemy.isDead);

      scoreText.update(t);
      healthBar.update(t);
      merkez.update(t);


    }

  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 10;
  }

  void onTapDown(TapDownDetails d) {
    if (state == Stater.menu) {
      state = Stater.playing;
    } else if (state == Stater.playing) {
      enemies.forEach((Enemy enemy) {
        if (enemy.enemyRect.contains(d.globalPosition)) {
          enemy.onTapDown();
        }
      });
    }
  }

  void spawnEnemy() {
    double x, y;
    switch (rand.nextInt(4)) {
      case 0:
      // Top
        x = rand.nextDouble() * screenSize.width;
        y = -tileSize * 2.5;
        break;
      case 1:
      // Right
        x = screenSize.width + tileSize * 2.5;
        y = rand.nextDouble() * screenSize.height;
        break;
      case 2:
      // Bottom
        x = rand.nextDouble() * screenSize.width;
        y = screenSize.height + tileSize * 2.5;
        break;
      case 3:
      // Left
        x = -tileSize * 2.5;
        y = rand.nextDouble() * screenSize.height;
        break;
    }
    enemies.add(Enemy(this, x, y));
  }
  void gameIsOver(){
    // print("GAME OVERRRRR");
    gameOver=false;
    ui.currentScreen = UIScreen.lost;
    ui.update();
  }


}
enum Stater {
  menu,
  playing,
}