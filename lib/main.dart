import 'dart:io';

import 'package:corona_oyun/ana_sayfa/anasayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'ana_sayfa/colors.dart';
import 'global.dart';
import 'home.dart';
void main() {

  runApp(MyApp());
  veritabaniHazirla();
}

veritabaniHazirla()
async {
  print("VERİTABANI KONTROLLERİİ ------------------");
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  var box = await Hive.openBox('sehirVeriler');
  if (box.get('ANKARA') == null) {
    box.put('ANKARA', '100');
    print("ankara oluşturuldu");
  }
  if (box.get('ISTANBUL') == null) box.put('ISTANBUL', '400');
  int turkiye = int.parse(box.get('ISTANBUL')) + int.parse(box.get('ANKARA'));
  box.put('TURKIYE', turkiye.toString());

  if (box.get('PUAN') == null) {box.put('PUAN', 0); print("PUAN oluşturuldu ---------");}

  if (box.get('LEVEL') == null) {box.put('LEVEL', 1); print("PUAN oluşturuldu ---------");}

  if (box.get('EL_YIKA_HIGH') == null) box.put('EL_YIKA_HIGH', 0);
  if (box.get('SU_HIGH') == null) box.put('SU_HIGH', 0);
  if (box.get('EVDE_KAL_HIGH') == null) box.put('EVDE_KAL_HIGH', 0);
  if (box.get('OKSURUK_HIGH') == null) box.put('OKSURUK_HIGH', 0);

  elYikaHigh = box.get('EL_YIKA_HIGH');
  suHigh = box.get('SU_HIGH');
  evdeKalHigh = box.get('EVDE_KAL_HIGH');
  oksurukHigh = box.get('OKSURUK_HIGH');

  Puan = box.get("PUAN");
  Level = box.get("LEVEL");
  VirusDusmeSayisi = Level*10;
  print("Level : $Level");


}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Corona Oyunlar',
        home: Splash()
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {

  SpinKitSquareCircle spinkit;
  String ilkgiris ;
  Future<String> ilkGiris() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("ilkgiris", "girildi");
  }

  girildimi() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ilkgiris = prefs.getString("ilkgiris");
  }
  @override
  void initState() {

    spinkit = SpinKitSquareCircle(

      color: Color.fromRGBO(240, 240, 240, 1),
      size: 50.0,
      controller: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 1000)),
    );
    girildimi();
    print(ilkgiris);
    Future.delayed(const Duration(seconds: 4), () async {
     /* if(ilkgiris == null){
        Navigator.pushReplacement(
            context, new MaterialPageRoute(builder: (context) => new IntroPage()));
        ilkGiris();
        print(ilkgiris);
      }
      else{*/
        Navigator.pushReplacement(
            context, new MaterialPageRoute(builder: (context) => new MyApp3()));



    });

  }
//Color.fromRGBO(240, 240, 240, 1)
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            spinkit,
            Image.asset('assets/images/TedbirAdam.png', width: 150, height: 150,),
            SizedBox(

              height: 15,
            ),


          /*  Text(
                "TEDBİR ADAM",style: TextStyle(fontFamily: "ssRegular",fontSize: 25,fontWeight: FontWeight.bold,color: Color(0xff009432)),textAlign: TextAlign.center, textScaleFactor: 1,

              ),*/
          ],
        ),
      ),
    );
  }
}
