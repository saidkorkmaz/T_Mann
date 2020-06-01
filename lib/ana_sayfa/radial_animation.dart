import 'dart:math';

import 'package:corona_oyun/evdekal_oyunu/evdekal_anasayfa.dart';
import 'package:corona_oyun/oksurme_oyunu/cough-game-home.dart';
import 'package:corona_oyun/su_oyunu/su_oyunu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vector_math/vector_math.dart' show radians, Vector3;
import 'package:corona_oyun/ellerini_yika_oyunu/ellerini_yika_anasayfa.dart';
import '../deneme.dart';
import '../su_oyunu/su_oyunu.dart';
import 'colors.dart';
import 'anasayfa.dart';

class RadialAnimation extends StatelessWidget {
  RadialAnimation({Key key, this.controller})
      : translation = Tween<double>(
    begin: 0.0,
    end: 100.0,
  ).animate(
    CurvedAnimation(parent: controller, curve: Curves.elasticOut),
  ),
        scale = Tween<double>(
          begin: 1.5,
          end: 0.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
        ),
        rotation = Tween<double>(
          begin: 0.0,
          end: 360.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.7,
              curve: Curves.decelerate,
            ),
          ),
        ),
        super(key: key);

  final AnimationController controller;
  final Animation<double> rotation;
  final Animation<double> translation;
  final Animation<double> scale;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, widget) {
          return Transform.rotate(
              angle: radians(rotation.value),
              child: Stack(alignment: Alignment.center, children: <Widget>[
                _buildButton(210,"ELLERINI_YIKA", context,
                    color: Colors.green, icon: FontAwesomeIcons.handsWash),
                _buildButton(250,"SU_IC", context,
                    color: Colors.blue, icon: FontAwesomeIcons.tint),
                _buildButton(290,"EVDE_KAL", context,
                    color: Colors.red, icon: FontAwesomeIcons.home),
                _buildButton(330,"OKSURUK", context,
                    color: Colors.deepPurple, icon: FontAwesomeIcons.headSideCough),
                Transform.scale(
                  scale: scale.value - 1,
                  child: FloatingActionButton(
                      heroTag: null,
                      child: Icon(FontAwesomeIcons.timesCircle),
                      onPressed: _close,
                      backgroundColor: kirmizi),
                ),
                Transform.scale(
                  scale: scale.value,
                  child: FloatingActionButton(
                    heroTag: null,
                    child: Icon(FontAwesomeIcons.play),
                    onPressed: _open,
                    backgroundColor: turuncu,
                  ),
                )
              ]));
        });
  }

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }

  _sayfayaYonlendir(String kod, BuildContext context)
  {

    if(kod == "ELLERINI_YIKA") {print("ELLERINI_YIKA"); Navigator.push(context, MaterialPageRoute(builder: (context) => EllerPage()));}
    if(kod == "SU_IC") {print("SU_IC"); Navigator.push(context, MaterialPageRoute(builder: (context) => SuOyunu()));}
    if(kod == "EVDE_KAL") {print("EVDE_KAL"); Navigator.push(context, MaterialPageRoute(builder: (context) => EvdeKalOyunu()));}
    if(kod == "OKSURUK") {print("OKSURUK"); Navigator.push(context, MaterialPageRoute(builder: (context) => CoughGameHome()));}
  }

  _buildButton(double angle, String kod,BuildContext context,{Color color, IconData icon}) {
    final double rad = radians(angle);
    return Transform(
        transform: Matrix4.identity()
          ..translate(
              (translation.value) * cos(rad), (translation.value) * sin(rad)),
        child: FloatingActionButton(
            heroTag: null,
            child: Icon(icon),
            backgroundColor: color,
            onPressed: (){ _close(); _sayfayaYonlendir(kod, context); print(tabController.index);},
            elevation: 0));
  }
}