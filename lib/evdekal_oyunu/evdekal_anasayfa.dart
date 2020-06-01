import 'package:corona_oyun/evdekal_oyunu/evdekal_ui.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game_controller.dart';

class EvdeKalOyunu extends StatefulWidget {
  _EvdeKalState createState() => _EvdeKalState();
}

class _EvdeKalState extends State<EvdeKalOyunu> {
  @override
  initState() {
    super.initState();
    evdekal();
  }

 // GameController gameController;

  evdekal() async {
    EvdeKalUI gameUI = EvdeKalUI();
    SharedPreferences storage = await SharedPreferences.getInstance();
    GameController gameController = GameController(gameUI.state);
    gameUI.state.gameController = gameController;
    Util flameUtil = Util();
    await flameUtil.fullScreen();
    await flameUtil.setOrientation(DeviceOrientation.portraitUp);

    WidgetsFlutterBinding.ensureInitialized();


//    runApp(gameController.widget);

    TapGestureRecognizer tapper = TapGestureRecognizer();
    tapper.onTapDown = gameController.onTapDown;
    flameUtil.addGestureRecognizer(tapper);
  }

  @override
  Widget build(BuildContext context) {
    EvdeKalUI gameUI = EvdeKalUI();
   // SharedPreferences storage = await SharedPreferences.getInstance();

    GameController gameController = GameController(gameUI.state);
    gameUI.state.gameController = gameController;
    Util flameUtil = Util();


  /*  Flame.util.addGestureRecognizer(horizontalDragGestureRecognizer
      ..onUpdate = (startDetails) {
        game.dragInput(startDetails.globalPosition);
      }
    );*/
    TapGestureRecognizer tapper = TapGestureRecognizer();
    tapper.onTapDown = gameController.onTapDown;
    flameUtil.addGestureRecognizer(tapper);


    return MaterialApp(

      home: Scaffold(
        body: Stack(
          //   fit: StackFit.expand,
          children: <Widget>[
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: gameController.onTapDown,
                child: gameController.widget,
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
