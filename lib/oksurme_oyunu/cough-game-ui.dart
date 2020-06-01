import 'dart:ui';

import 'package:corona_oyun/oksurme_oyunu/cough-game-home.dart';
import 'package:corona_oyun/oksurme_oyunu/cough-game.dart';
import 'package:flutter/material.dart';
import 'package:corona_oyun/global.dart';
import 'package:hive/hive.dart';

import '../ana_sayfa/anasayfa.dart';
import '../ana_sayfa/colors.dart';


class CoughGameUI extends StatefulWidget {
  final CoughGameUIState state = CoughGameUIState();

  State<StatefulWidget> createState() => state;
}

class CoughGameUIState extends State<CoughGameUI> with WidgetsBindingObserver {
  CoughGame game;
  bool gercektenYaptinmi= false;
  bool puanEkle = true;

// SharedPreferences _storage;
  UIScreen currentScreen = UIScreen.playing;
  /*  int score = 0;
  int highScore = 0;
  SharedPreferences get storage => _storage;
  set storage(SharedPreferences value) {
    _storage = value;
    highScore = storage.getInt('high-score') ?? 0;
    if (mounted) {
      update();
    }
  }*/

  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void update() {
    setState(() {});
  }
  Widget spacer({int size}) {
    return Expanded(
      flex: size ?? 100,
      child: Center(),
    );
  }

  Widget topControls() {
    return Padding(
      padding: EdgeInsets.only(top: 5, left: 100, right: 100),
      child: Row(
        children: <Widget>[
          //  bgmControlButton(),
          //sfxControlButton(),
          //  helpButton(),
          // creditsButton(),
          spacer(),
          // highScoreDisplay(),
        ],
      ),
    );
  }

  Widget buildScreenPlaying() {

    return Positioned.fill(
      child: Column(
        children: <Widget>[
          spacer(size: 45),
          //  scoreDisplay(),
          spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Row(
              children: <Widget>[

              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget buildScreenGameOver(){

  }

  Widget buildScreenLost() {

    List<Widget> children = List<Widget>();
    children.add(
      Padding(
        padding: EdgeInsets.only(top: 20),
        child: Text(
          'You got tired.',
          style: TextStyle(
            fontSize: 25,
            color: Color(0xff032626),
          ),
        ),
      ),
    );
    children.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: <Widget>[
            Text(
              'YOUR TOTAL SCORE:',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff032626),
              ),
            ),
            Text(
              game.score.toString(),
              style: TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
    children.add(
      Padding(
        padding: EdgeInsets.only(top: 15, bottom: 20),
        child: RaisedButton(
          color: Color(0xff032626),
          child: Text(
            'Lezz Go!',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => CoughGameHome()));

          },
        ),
      ),
    );

    return Positioned.fill(
      child: Column(
        children: <Widget>[
          SimpleDialog(
            backgroundColor: Color(0xddffffff),
            children: <Widget>[
              Column(
                children: children,
              ),
            ],
          ),
          spacer(),
        ],
      ),
    );
  }
  playAgain(){
    if(checkVal){
      sehirdenVirusSayisiDusvePuanEkle(kullaniciSehir, game.score);
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => CoughGameHome()));
  }



  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        topControls(),
        Expanded(
          child: IndexedStack(
            sizing: StackFit.expand,
            children: <Widget>[
              //  buildScreenHome(),
              buildScreenPlaying(),
              Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: 10,
                          right: 10,
                        ),
                        margin: EdgeInsets.only(top: 20),
                        decoration: new BoxDecoration(
                          color: Color(0xddffffff),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              offset: const Offset(0.0, 10.0),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          // To make the card compact
                          children: <Widget>[
                            Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "En yüksek : " + oksurukHigh.toString(),
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    fontFamily: "ssLight",
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Text("Puanın",
                                textScaleFactor: 1,
                                style: TextStyle(
                                  fontFamily: "ssLight",
                                  fontSize: 24.0,
                                )),
                            Container(
                              child: Text(
                                game.score.toString(),
                                textScaleFactor: 1,
                                style: TextStyle(
                                  fontFamily: "ssRegular",
                                  fontSize: 100,
                                ),
                              ),
                            ),
                            Divider(),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                    value: checkVal,
                                    onChanged: (bool value) {
                                      setState(() {
                                        checkVal = value;
                                   //     print(checkVal);
                                      });

                                    },
                                    activeColor: turuncu),
                                Expanded(
                                    child: Text(
                                      "Bu sadece bir oyun. Önemli olan öksürdüğünde ağzını ve burnunu bir mendille veya mendil yoksa dirseğinle kapatman. Bunu gerçekten uyguluyorsan işaretle.",
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                        fontFamily: "ssLight",
                                        fontSize: 16,
                                      ),
                                    )),
                              ],
                            ),
                            Divider(),
                            SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24.0, bottom: 24),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: SizedBox(
                                      width: 70,
                                      height: 70,
                                      child: FloatingActionButton(
                                        backgroundColor: turuncu,
                                        heroTag: null,
                                        onPressed: () {
                                          if(checkVal){
                                            sehirdenVirusSayisiDusvePuanEkle(kullaniciSehir, game.score);
                                          }
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                      AnasayfaPage()),
                                                  (route) => false);
                                        },
                                        child: Icon(Icons.home, size: 45),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 24.0, bottom: 24),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: SizedBox(
                                      width: 70,
                                      height: 70,
                                      child: FloatingActionButton(
                                        backgroundColor: turuncu,
                                        heroTag: null,
                                        onPressed: playAgain,
                                        child: Icon(
                                          Icons.replay,
                                          size: 45,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
            index: currentScreen.index,
          ),
        ),
      ],
    );
  }
  Future<void> sehirdenVirusSayisiDusvePuanEkle(String sehir, int toplampuan) async {

    if(puanEkle && checkVal)
    {
      puanEkle = false;
      var box = await Hive.openBox("sehirVeriler");

      int suankiPuan = box.get(nereyeOynuyor);
      int yeniPuan = suankiPuan + toplampuan;
      box.delete(nereyeOynuyor);
      box.put(nereyeOynuyor,yeniPuan);
      /*print("SUUU HIGHHHHHHHHHHHHHHHHHHHHH");
        print(box.get("SU_HIGH"));*/
      if(toplampuan > box.get("OKSURUK_HIGH")){
        box.delete("OKSURUK_HIGH");
        box.put("OKSURUK_HIGH",toplampuan);
        oksurukHigh = toplampuan;
        print("En yüksek değişti");
      }

    }
  }

  void gercektenYaptinmiTiklendi(bool value) {
    setState(() {
      gercektenYaptinmi = value;
    });
  }

  void didChangeMetrics() {
    game.resize(window.physicalSize / window.devicePixelRatio);
  }



}
enum UIScreen {
  // home,
  playing,
  lost,

  // credits,
}