import 'dart:ui';
import 'package:corona_oyun/oksurme_oyunu/cough-game.dart';
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
class TissueBox {
  final CoughGame game;
  Rect tissueBoxRect;
  Sprite tissueBoxSprite;
  double posx;
  double posy;
  bool bo = true;


  TissueBox(this.game, double x, double y) {
    tissueBoxRect = Rect.fromLTWH(x, y-22, game.tileSize, game.tileSize);
    tissueBoxSprite = Sprite('emptybox.png');

  }

  void render(Canvas c) {
    if (bo) {
      tissueBoxSprite.renderRect(c, tissueBoxRect.inflate(game.heightTileSize/40));
    }
  }
  void update(double t) {
    if (game.touchPositionDx == posx) {
      tissueBoxRect = tissueBoxRect.translate(0, 0);
      game.visible = true;
    }
  }
}