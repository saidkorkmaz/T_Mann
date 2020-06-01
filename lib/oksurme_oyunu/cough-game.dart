import 'dart:math';
import 'dart:ui';
import 'package:corona_oyun/oksurme_oyunu/components/background.dart';
import 'package:corona_oyun/oksurme_oyunu/components/count-display.dart';
import 'package:corona_oyun/oksurme_oyunu/components/person.dart';
import 'package:corona_oyun/oksurme_oyunu/components/score-display.dart';
import 'package:corona_oyun/oksurme_oyunu/components/tissue-box.dart';
import 'package:corona_oyun/oksurme_oyunu/components/tissue.dart';
import 'package:corona_oyun/oksurme_oyunu/components/window.dart';
import 'package:corona_oyun/oksurme_oyunu/controllers/spawner.dart';
import 'package:corona_oyun/oksurme_oyunu/cough-game-ui.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:hive/hive.dart';

import '../global.dart';

class CoughGame extends Game{
  final CoughGameUIState ui;
  Size screenSize;
  double tileSize, heightTileSize;
  BackGround background;
  List<TissueBox> tissuebox;
  List<Tissue> tissues;
  List<Window> windows;
  List<Person> people;
  int newTissue = 0;//boşa kullanılan medilleri saymak için
  double touchPositionDx = 0.0;
  double touchPositionDy = 0.0;
  bool visible = false;
  bool finish = false;
  Random rnd;
  int personBottom, personLeft, tissueTop,tissueLeft;
  bool isTouchTissue=false;
  bool startDrag=false;
  int score=0;
  int temp=0;
  bool newOne=false;//puanı tek tek sayması için
  ScoreDisplay scoreDisplay;
  CountDisplay countDisplay;
  bool gameOver=false;
  int random=0;
  bool first=true;
  PersonSpawner personSpawner;
  bool windowIsOpen=false;
  int r=0;
  bool firstSpawn =true;
  bool showingPerson=false;

  CoughGame(this.ui){
    initialize();
  }

  void initialize() async{
    rnd = Random();
    people = List<Person>();
    windows = List<Window>();
    tissuebox = List<TissueBox>();
    tissues = List<Tissue>();
    resize(await Flame.util.initialDimensions());
    background =  BackGround(this);
    scoreDisplay=ScoreDisplay(this);
    countDisplay =CountDisplay(this);
    personSpawner = PersonSpawner(this);
    personSpawner.start();


    //spawnTissue();
    spawnWindows();
    spawnTissueBox();
  }

  void render(Canvas canvas){
    background.render(canvas);
    scoreDisplay.render(canvas);
    countDisplay.render(canvas);
    people.forEach((Person person) => person.render(canvas));

    windows.forEach((Window window) => window.render(canvas));
    tissuebox.forEach((TissueBox tissueBox) => tissueBox.render(canvas));
    tissues.forEach((Tissue tissue) => tissue.render(canvas));

  }

  void update(double t){
    // print(showingPerson);



    if(gameOver){
      people.clear();
      super.pauseEngine();
      gameIsOver();
      gameOver = false;
    }

    random= personSpawner.index;
    personSpawner.update(t);
    scoreDisplay.update(t);
    countDisplay.update(t);
    //   print(startDrag);
    // print("FİNİSH:" + finish.toString());
    if(!startDrag){
      tissues.removeWhere((Tissue tissue) => finish);

      startDrag=true;
      spawnTissue();
      //  print("1111111111111");
    }

    people.forEach((Person person) => person.update(t));

    tissues.forEach((Tissue tissue) => tissue.update(t));
    if(personSpawner.temp !=null){
      windows[personSpawner.temp].update(t);

    }
    else{
      r = rnd.nextInt(6);
      windows[r].update(t);
    }


    tissuebox.forEach((TissueBox tissueBox) => tissueBox.update(t));


    if(tissueTop != null&& personBottom != null){
      //print((personLeft-tissueLeft).abs());

      if((tissueTop-personBottom).abs()<55&& (personLeft-tissueLeft).abs()<25 && windowIsOpen){
        isTouchTissue=true;

        tissues.removeWhere((Tissue tissue) => tissue.isTouch);
        if(newOne && !gameOver){
          score++;
          newOne=false;
        }
      }
    }
    if(isTouchTissue &&  startDrag&&finish){
      isTouchTissue=false;

      //   print("2222222222222222");

    }
    if(newTissue == 8){
      gameOver = true;
      //     print("GAME OVER");
    }
    /*  if(tissue != null){
      print(tissue.tissueRect.topCenter.dy.toInt()-personRect.bottom);

      if((tissue.tissueRect.topCenter.dy.toInt())< 20){
        isTouchTissue = true;

      }
    }*/
  }
  void resize(Size size){
    screenSize = size;
    tileSize=screenSize.width/9;
    heightTileSize = screenSize.height;

    //  super.resize(size);
  }
  void spawnWindows(){

    windows.add(Window(this,((screenSize.width/2) - (tileSize*2.5)),  (tileSize*4)));

    windows.add(Window(this,((screenSize.width) - (tileSize*3)),  (tileSize*4)));
    windows.add(Window(this,((screenSize.width/2) - (tileSize*2.5)),(tileSize*8)));
    windows.add(Window(this,((screenSize.width) - (tileSize*3)),  (tileSize*8)));

    windows.add(Window(this,((screenSize.width/2) - (tileSize*2.5)),(tileSize*12)));
    windows.add(Window(this,((screenSize.width) - (tileSize*3)),  (tileSize*12)));
  }
  void spawnPeople(r){

    switch(r){
      case 0:
        people.add(Person(this,((screenSize.width/2) - (tileSize*2.5)),  (tileSize*4.5)));
        break;
      case 1:
        people.add(Person(this,((screenSize.width/2) + (tileSize*1.5)),  (tileSize*4.5)));
        break;
      case 2:
        people.add(Person(this,((screenSize.width/2) - (tileSize*2.5)),  (tileSize*8.5)));
        break;
      case 3:
        people.add(Person(this,((screenSize.width/2) + (tileSize*1.5)),  (tileSize*8.5)));
        break;
      case 4:
        people.add(Person(this,((screenSize.width/2) - (tileSize*2.5)),  (tileSize*12.5)));
        break;
      case 5:
        people.add(Person(this,((screenSize.width/2) + (tileSize*1.5)),  (tileSize*12.5)));
        break;
    }
  }
  void spawnTissueBox(){
    tissuebox.add(TissueBox(this,((screenSize.width/2) - (tileSize/2)), (screenSize.height-(2*tileSize)) ));
  }
  void spawnTissue(){
    startDrag=false;
    isTouchTissue=false;
    tissues.add(Tissue(this,((screenSize.width/2) - (tileSize/2)), (screenSize.height-(2*tileSize)) ));
  }
  void onDragUpdate(DragUpdateDetails d) {


    dragInput(d.globalPosition);
  }
  void dragInput(Offset position) {
    touchPositionDx = position.dx;
    touchPositionDy = position.dy;
    isTouchTissue=false;
    startDrag=true;
  }
  onDragStart(DragStartDetails details){
    Flame.audio.play('tissue.ogg', volume: 0.25);

    //contains
    // finish = false;
    // startDrag=true;
    temp++;


  }
  onDragEnd(DragEndDetails detail){
    finish = true;
    startDrag=false;
    if(newOne && !gameOver && temp!=score){
      newTissue++;
      temp=score;
    }


  }
  getPerson(bottom,left){
    personBottom=bottom;
    personLeft=left;
  }
  getTissue(top,left2){
    tissueTop=top;
    tissueLeft=left2;
    // newOne=false;
  }

  void gameIsOver(){
    // print("GAME OVERRRRR");
    gameOver=false;
    ui.currentScreen = UIScreen.lost;
    ui.update();
  }
}