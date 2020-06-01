
import 'package:flutter/material.dart';

import '../game_controller.dart';


class StartText {
  final GameController gameController;
  TextPainter painter;
  Offset position;

  StartText(this.gameController) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double t) {
    painter.text = TextSpan(
      text: 'Sağlığımız için evde kalmalıyız! \n'
      '\n Polis olarak, sen de '
          '\n dışarı çıkan insanları uyararak'
          '\n yardımcı olabilirsin. \n '
          '\n Ne kadar temas olursa'
          '\n o kadar canın azalır!',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.greenAccent[200],
        fontSize: 20.0,
      ),
    );
    painter.layout();



    position = Offset(
      (gameController.screenSize.width / 2) - (painter.width / 2),
      (gameController.screenSize.height * 0.8) - (painter.height / 2),
    );
  }
}