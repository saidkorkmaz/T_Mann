import 'package:corona_oyun/su_oyunu/water-game-ui.dart';
import 'package:corona_oyun/su_oyunu/water-game.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';



class SuOyunu extends StatefulWidget {
  _SuOyunuState createState() => _SuOyunuState();
}
class _SuOyunuState extends State<SuOyunu>{
  @override
  initState() {
    super.initState();
    su();
  }
  su() async{
    WaterGameUI gameUI = WaterGameUI();
    WaterGame game = WaterGame(gameUI.state);
    gameUI.state.game = game;
    Util flameUtil = Util();
    await flameUtil.fullScreen();
    await flameUtil.setOrientation(DeviceOrientation.portraitUp);
    await Flame.images.loadAll(<String>[
      'glass25.png',
      'glass50.png',
      'glass75.png',
      'glass100.png',
      'bg/bluecloud5.png',
      'moradovirus.png',
      'water-drop.png',

    ]);
    HorizontalDragGestureRecognizer horizontalDragGestureRecognizer =
    new HorizontalDragGestureRecognizer();

    Flame.util.addGestureRecognizer(horizontalDragGestureRecognizer
      ..onUpdate = (startDetails) => game.dragInput(startDetails.globalPosition));

    Flame.audio.disableLog();
    Flame.audio.loadAll(<String>[
      'sfx/blup.ogg',
      'sfx/slurp.ogg',
      'sfx/drop.ogg',
    ]);
  }
  @override
  Widget build(BuildContext context) {

    WaterGameUI gameUI = WaterGameUI();
    WaterGame game = WaterGame(gameUI.state);
    gameUI.state.game = game;

    HorizontalDragGestureRecognizer horizontalDragGestureRecognizer =
    new HorizontalDragGestureRecognizer();

    Flame.util.addGestureRecognizer(horizontalDragGestureRecognizer
      ..onUpdate = (startDetails) {
        game.dragInput(startDetails.globalPosition);
      }
    );

    return MaterialApp(

      home: Scaffold(
        body: Stack(
          //   fit: StackFit.expand,
          children: <Widget>[
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onHorizontalDragUpdate: game.onDragUpdate,
                child: game.widget,
              ),
            ),
            Positioned.fill(
              child: gameUI,
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );

  }




}