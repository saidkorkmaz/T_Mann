import 'package:corona_oyun/su_oyunu/components/backyard.dart';
import 'package:corona_oyun/su_oyunu/components/count-display.dart';
import 'package:corona_oyun/su_oyunu/components/drop.dart';
import 'package:corona_oyun/su_oyunu/components/glass.dart';
import 'package:corona_oyun/su_oyunu/components/score-display.dart';
import 'package:corona_oyun/su_oyunu/components/virus.dart';
import 'package:corona_oyun/su_oyunu/view.dart';
import 'package:corona_oyun/su_oyunu/views/gameover-view.dart';
import 'package:corona_oyun/su_oyunu/virus-spawner.dart';
import 'package:corona_oyun/su_oyunu/water-game-ui.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:hive/hive.dart';

import '../global.dart';

class WaterGame extends Game{
  final WaterGameUIState ui;
  Size screenSize;
  double tileSize, heightTileSize;
  List<Drop> drops;
  List<Virus> viruses;
  List<Glass> glasses;
  Random randomNumber;
  double creationTimer = 0.0;
  int isOffScreenCount= 0; //ekrandan çıkan damlacık sayısı, can sayısı
  bool gameOver = false;
  Backyard background;
  double touchPositionDx = 0.0;
  double touchPositionDy = 0.0;
  double dropTop, dropLeft;
  double glassTop, glassLeft;
  double virusTop, virusLeft;
  double difference, virusDifference;
  int score = 0; //puan
  int scoreGlassFull=0;
  int totalScore=0;
  int fallingDropCount = 0;
  double condition= 3.0;
  AudioPlayer homeBGM;
  double dropCoefficient=5;

  bool newOne = false; // puan saymak için yeni damlacık geliyomu diye kontrol
  View activeView = View.home;
  LostView lostView;
  ScoreDisplay scoreDisplay;
  CountDisplay countDisplay;
  bool ok =false;
  VirusSpawner virusSpawner;
  double virusSpeed;
  bool puanEkle = true;
   WaterGame(this.ui){
    initialize();
  }
  void initialize() async {



    drops = List<Drop>();
    viruses = List<Virus>();
    resize(await Flame.util.initialDimensions());
    lostView = LostView(this);
    randomNumber = Random();
    background= Backyard(this);
    scoreDisplay = ScoreDisplay(this);
    countDisplay =CountDisplay(this);
    virusSpawner = VirusSpawner(this);
    virusSpawner.start();
   // homeBGM = await Flame.audio.loop('bgm/home.mp3', volume: .25);
    //homeBGM.pause();
    //playHomeBGM();
    glasses = List<Glass>();
    spawnGlass();
  //  spawnDrop();
  }
  void start() {
    gameOver=false;
    totalScore=0;
    score=0;
    scoreGlassFull=0;
    isOffScreenCount=0;
    //  spawnGlass();
    initialize();
  }

  void render(Canvas canvas){
    background.render(canvas);
    drops.forEach((Drop drop) => drop.render(canvas));
    viruses.forEach((Virus virus) => virus.render(canvas));
    scoreDisplay.render(canvas);
    countDisplay.render(canvas);
    glasses.forEach((Glass glass) => glass.render(canvas));
    canvas.restore();
  }


  void update(double t){

    if(gameOver)
      {

     //   sehirdenVirusSayisiDusvePuanEkle(kullaniciSehir, totalScore);
        drops.clear();
        viruses.clear();
        super.pauseEngine();

        gameIsOver();
        gameOver=false;
      }
    creationTimer += t;
    glasses.forEach((Glass glass) => glass.update(t));

  //bardakla damlacığın teması

   if (glassTop != null && dropTop != null){
     difference = glassTop - dropTop;

     if (difference <32 && difference>-25  && (glassLeft-dropLeft)<35 && (glassLeft-dropLeft)>(-30)){
       drops.removeWhere((Drop drop) => drop.isTouch);
      // print("FARK: "+ fark.toString());
       if(newOne && !gameOver ){
         score ++;
         totalScore++;
         Flame.audio.play('sfx/drop.ogg', volume: 0.25);
         if (score !=1 && score % 4==0 ){
           scoreGlassFull += 2;
           totalScore +=2;

           Flame.audio.play('sfx/slurp.ogg', volume: 0.25);
         }
         newOne=false;
       }
     }
   }
   //bardakla virüsün teması
    if(glassTop !=null && virusTop !=null){
      virusDifference=glassTop-virusTop;
      if(virusDifference<30 && virusDifference>-40 && (glassLeft-virusLeft)<40 && (glassLeft-virusLeft)>(-30)){
      //  print("GAME OVER");
        gameOver = true;

      }
    }
    switch(fallingDropCount){
      case 3:
        condition = 2.5;
        break;
      case 5:
        condition = 2.2;
        break;
      case 6:
        condition = 2.0;
        break;
      case 8:
        condition = 1.7;
        break;
      case 13:
        condition = 1.4;
        break;
      case 24:
        condition = 1.1;
        break;
      case 30:
        condition = 1.0;
        break;
      case 39:
        condition = 0.9;
        break;
      case 54:
        condition = 0.8;
        break;
      case 65:
        condition = 0.7;
        break;
      case 80:
        condition = 0.6;
        break;
      case 95:
        condition = 0.5;
        break;
      case 117:
        condition = 0.4;
        break;
      case 140:
        condition = 0.3;
        break;
      case 190:
        condition = 0.25;
        break;
      case 250:
        condition = 0.2;
        break;
    }
    //virüslerin kontrolü
    virusSpawner.update(t);
  //  print(virusSpeed);
    //ilk şart ekrandan çıkan 5 damlacık olursa GAME OVER
    if(isOffScreenCount == 5){
      gameOver=true;
    }
    fallingDropCount = isOffScreenCount +score ;

    if(creationTimer>=condition  && !gameOver){
      creationTimer = 0.0;
      spawnDrop();
    }

    drops.forEach((Drop drop) => drop.update(t));
    drops.removeWhere((Drop drop) => drop.isOffScreen);
    viruses.removeWhere((Virus virus) => virus.isVirusOffScreen);
    viruses.forEach((Virus virus) => virus.update(t));
    scoreDisplay.update(t);
    countDisplay.update(t);
    print("suoyunu: "+checkVal.toString());

  }

  Future<void> sehirdenVirusSayisiDusvePuanEkle(String sehir, int toplampuan) async {

    if(puanEkle && checkVal)
      {
        puanEkle = false;
        var box = await Hive.openBox("sehirVeriler");

        int suankiPuan = box.get(nereyeOynuyor);
        int yeniPuan = suankiPuan + toplampuan;
        box.delete(nereyeOynuyor);
        box.put(nereyeOynuyor,yeniPuan);
        /*print("SUUU HIGHHHHHHHHHHHHHHHHHHHHH");
        print(box.get("SU_HIGH"));*/
       if(toplampuan > box.get("SU_HIGH")){
         box.delete("SU_HIGH");
         box.put("SU_HIGH",toplampuan);
         suHigh = toplampuan;
         print("En yüksek değişti");
       }

        }
      }




  void resize(Size size){
    screenSize = size;
    tileSize=screenSize.width/9;
    heightTileSize = screenSize.height;
  }
  void spawnDrop(){
    double x = randomNumber.nextDouble() * (screenSize.width - tileSize);
  //  double y = randomNumber.nextDouble() * (screenSize.height - tileSize);
    drops.add(Drop(this, x,0));
  }
  void spawnVirus(){
    double x = randomNumber.nextDouble() * (screenSize.width - tileSize);
    //  double y = randomNumber.nextDouble() * (screenSize.height - tileSize);
    viruses.add(Virus(this, x,0));
  }
  void spawnGlass(){
    glasses.add(Glass(this,((screenSize.width/2) - (tileSize/2)), (screenSize.height-(2*tileSize)) ));
  }
  void onDragUpdate(DragUpdateDetails d) {
    gameOver=false;
    // print("başladı");
    dragInput(d.globalPosition);
  }
  void dragInput(Offset position) {
    gameOver=false;
    touchPositionDx = position.dx;
    touchPositionDy = position.dy;
  }
  void getDrop(top, left){
    dropTop = top + tileSize;
    dropLeft = left;
  }
  void getGlass(top2, left2){
    glassTop = top2;
    glassLeft = left2;
  }
  void getVirus(top3, left3){
    virusTop = top3+tileSize;
    virusLeft=left3;
  }
  void playHomeBGM() {
   // playingBGM.pause();
  //  playingBGM.seek(Duration.zero);
    homeBGM.pause();
   // homeBGM.resume();
    if(gameOver){


      homeBGM.pause();
    }
  }
  void gameIsOver(){
    // print("GAME OVERRRRR");
    gameOver=false;
    ui.currentScreen = UIScreen.lost;
    ui.update();
  }
  void getSpeed(speed){
    virusSpeed = speed;
  }
}