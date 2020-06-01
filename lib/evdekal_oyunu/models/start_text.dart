
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
      text: 'Sağlığımız için  \n'
          'sosyal mesafeye uymalıyız! \n'
      '\n Duyarlı bir vatandaş olarak, sen de '
          '\n dışarı çıkan insanlara 3 kere tıklayarak'
          '\n onları uyarabilirsin. \n '
          '\n Sosyal mesafeye ne kadar uymazsak'
          '\n o kadar canın azalır!',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.greenAccent,
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