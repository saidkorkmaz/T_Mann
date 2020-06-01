import 'dart:math';
import 'package:corona_oyun/oksurme_oyunu/components/person.dart';
import 'package:corona_oyun/oksurme_oyunu/cough-game.dart';

class PersonSpawner {
  final CoughGame game;
  final int maxSpawnInterval = 5000;
  final int minSpawnInterval = 250;
  final int intervalChange = 5;
  final int maxPeopleOnScreen = 1;
  int currentInterval;
  int nextSpawn;
  int index = 0;
  Random rnd;
  int random;
  int temp;
  bool personShowed = true;

  PersonSpawner(this.game) {
    rnd = Random();

    start();

    // game.spawnPeople(random);
  }

  void start() {
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void update(double t) {
    // print(personShowed);

    random = rnd.nextInt(6);
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;
    //   print(nowTimestamp);
    int showingPerson = 0;
    game.people.forEach((Person person) {
      showingPerson += 1;
    });
    //   print(currentInterval);
    /* if (game.firstSpawn) {
        if (temp == random) {
          random = rnd.nextInt(6);
        }
        game.spawnPeople(random);
        personShowed = true;

        if (currentInterval > minSpawnInterval) {
          temp = random;
          currentInterval -= intervalChange;
          currentInterval -= (currentInterval * .02).toInt();
          //       print("ifteeee");
        }
        nextSpawn = nowTimestamp + currentInterval;
        game.firstSpawn = false;
        currentInterval = maxSpawnInterval;
        nextSpawn = DateTime
            .now()
            .millisecondsSinceEpoch + currentInterval;

    }*/

    if (nowTimestamp >= nextSpawn && showingPerson < maxPeopleOnScreen) {
      if (temp == random) {
        random = rnd.nextInt(6);
      }
      game.showingPerson = true;
      game.spawnPeople(random);


      if (currentInterval > minSpawnInterval) {
        temp = random;
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * .02).toInt();
        //       print("ifteeee");
      }
      nextSpawn = nowTimestamp + currentInterval;
    } else if (nowTimestamp >= nextSpawn &&
        showingPerson == maxPeopleOnScreen) {
      //  print("Ttttttttttttteeeeeee"+temp.toString());
      game.showingPerson = false;
      game.people.removeLast();


      if (index == 0)
        index = 1;
      else {
        index = 0;
      }
    }
  }
}
