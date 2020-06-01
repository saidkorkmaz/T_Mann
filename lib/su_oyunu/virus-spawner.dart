import 'dart:math';

import 'package:corona_oyun/su_oyunu/components/virus.dart';
import 'package:corona_oyun/su_oyunu/water-game.dart';


class VirusSpawner {
  final WaterGame game;
  final int maxSpawnInterval = 5000;
  final int minSpawnInterval = 250;
  final int intervalChange = 10;
  final int maxPeopleOnScreen = 3;
  int currentInterval;
  int nextSpawn;
 // int index = 0;
  final double virusCoefficient= 4.0;
  final double maxVirusCoefficient=13.0;
  final double coefficientChange=0.001;
  double currentCoefficient;
  double nextCoefficient;

  VirusSpawner(this.game) {
    start();
  }
  void start() {

    currentCoefficient=virusCoefficient;
    nextCoefficient = DateTime.now().millisecondsSinceEpoch + currentCoefficient;
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }
  void update(double t) {

    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;
    int nowTimestamp2 = DateTime.now().millisecondsSinceEpoch;


    int fallingVirus = 0;
    game.viruses.forEach((Virus virus) {
      fallingVirus += 1;
    });
  //  print(currentCoefficient);


    if(nowTimestamp2>= nextCoefficient){
      if (currentCoefficient < maxVirusCoefficient ) {

        currentCoefficient += coefficientChange;
       // currentCoefficient += (currentCoefficient * .02);
      }
      nextCoefficient = nowTimestamp2 + currentCoefficient;

    }

    if (nowTimestamp >= nextSpawn && fallingVirus < maxPeopleOnScreen) {
      //   getIndex()

      //  print(random);
      game.spawnVirus();
      if (currentInterval > minSpawnInterval) {

        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * .02).toInt();
      }
      nextSpawn = nowTimestamp + currentInterval;

    }else if(nowTimestamp >= nextSpawn && fallingVirus == maxPeopleOnScreen  ){
      //  print("Ttttttttttttteeeeeee"+temp.toString());
   /*   game.viruses.removeLast();
      if(index==0)
        index=1;
      else{
        index=0;
      }*/



    }
    game.getSpeed(currentCoefficient);
  }
}