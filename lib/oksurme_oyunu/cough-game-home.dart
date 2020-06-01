import 'package:corona_oyun/oksurme_oyunu/cough-game-ui.dart';
import 'package:corona_oyun/oksurme_oyunu/cough-game.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';

class CoughGameHome extends StatefulWidget {

  _CoughGameHomeState createState() => _CoughGameHomeState();
}
class _CoughGameHomeState extends State<CoughGameHome> {

  @override
  initState() {
    super.initState();
    cough();
  }


  cough() async {
    CoughGameUI gameUI = CoughGameUI();
    CoughGame game = CoughGame(gameUI.state);
    gameUI.state.game = game;

    Util flameUtil = Util();
    await flameUtil.fullScreen();
    await flameUtil.setOrientation(DeviceOrientation.portraitUp);
    await Flame.images.loadAll(<String>[
      'tiss.png',
      'tissues.png',
      'cough.png',
      'coughman.png',
      'closed_window.png',
      'opened_window.png',

    ]);

    /*  VerticalDragGestureRecognizer verticalDragGestureRecognizer =
    new VerticalDragGestureRecognizer();

    HorizontalDragGestureRecognizer horizontalDragGestureRecognizer = new HorizontalDragGestureRecognizer();
 //   verticalDragGestureRecognizer.dispose();
   // horizontalDragGestureRecognizer.dispose();

     Flame.util.addGestureRecognizer(verticalDragGestureRecognizer
     ..onStart = (startDetails) => game.onDragStart(startDetails.globalPosition));

    Flame.util.addGestureRecognizer(verticalDragGestureRecognizer
      ..onUpdate = (updateDetails) => game.dragInput(updateDetails.globalPosition));

    verticalDragGestureRecognizer.onEnd = game.onDragEnd;
    horizontalDragGestureRecognizer.onEnd = game.onDragEnd;*/




    Flame.audio.disableLog();
    Flame.audio.loadAll(<String>[
      'tissue.ogg',
    ]);

  }

  @override
  Widget build(BuildContext context) {

    CoughGameUI gameUI = CoughGameUI();
    CoughGame game = CoughGame(gameUI.state);
    gameUI.state.game = game;


    /*  VerticalDragGestureRecognizer verticalDragGestureRecognizer =
    new VerticalDragGestureRecognizer();

    HorizontalDragGestureRecognizer horizontalDragGestureRecognizer = new HorizontalDragGestureRecognizer();
    //   verticalDragGestureRecognizer.dispose();
    // horizontalDragGestureRecognizer.dispose();


    Flame.util.addGestureRecognizer(verticalDragGestureRecognizer
      ..onUpdate = (updateDetails) => game.dragInput(updateDetails.globalPosition));

    verticalDragGestureRecognizer.onEnd = game.onDragEnd;
    horizontalDragGestureRecognizer.onEnd = game.onDragEnd;*/
    return Material(

      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragStart: game.onDragStart,
              onVerticalDragUpdate: game.onDragUpdate,
              onHorizontalDragEnd: game.onDragEnd,
              onVerticalDragEnd: game.onDragEnd,
              child: game.widget,
            ),
          ),
          Positioned.fill(
            child: gameUI,
          ),
        ],

      ),

    );
  }

}
