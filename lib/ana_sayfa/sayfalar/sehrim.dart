import 'package:corona_oyun/su_oyunu/water-game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

import '../../global.dart';

int sehirdekiVirusSayisi = 0;
Color sehirRenk = Color.fromRGBO(80, 80, 80, 1);

class SehrimPage extends StatefulWidget {
  const SehrimPage([Key key]) : super(key: key);

  @override
  _SehrimPage createState() => _SehrimPage();
}

class _SehrimPage extends State<SehrimPage> {
  final String killer = "kaynaklar/sehrim_resimler/killer.svg";

  WaterGame oldur = new WaterGame(null);

  @override
  Widget build(BuildContext context) {
    VirusSayisiGetir(kullaniciSehir);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      "Virüs öldür",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12,fontFamily: 'ssLight'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      height: 50,
                      width: 50,
                      child: SvgPicture.asset(killer),
                    ),
                    onTap: () {
                      debugPrint("öldür baba");

                      setState(() {
                        if (Puan < VirusDusmeSayisi) {
                          return _showPuan();
                        } else {
                          sehirdenVirusSayisiDus(
                              kullaniciSehir, oldur.totalScore);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
Padding(
  padding: const EdgeInsets.all(16.0),
  child:   Row(mainAxisAlignment:MainAxisAlignment.center,children: [Text("Seviye : $Level",style: TextStyle(fontFamily: "ssRegular", fontSize: 25),)],),
),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  "kaynaklar/kendim_resimler/elmas.svg",
                  width: 25,
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$Puan",
                    style: TextStyle(fontFamily: "ssRegular", fontSize: 25),
                  ),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment(0, -0.5),
              child: SvgPicture.asset(
                "kaynaklar/sehrim_resimler/city.svg",
                color: sehirRenk,
              )),
          Align(
              alignment: Alignment(0, -0.05),
              child: Text(
                kullaniciSehir,
                style: TextStyle(fontFamily: "ssLight", fontSize: 30),
              )),
          Align(
              alignment: Alignment(0, -0.25),
              child: Text(
                sehirdekiVirusSayisi.toString(),
                style: TextStyle(fontFamily: "ssRegular", fontSize: 80),
              )),
        ],
      ),
    );
  }

  Future<void> VirusSayisiGetir(String sehir) async {
    var box = await Hive.openBox("sehirVeriler");
    sehirdekiVirusSayisi = int.parse(box.get(sehir));
    if (sehirdekiVirusSayisi != int.parse(box.get(sehir))) {
      setState(() {
        sehirdekiVirusSayisi = int.parse(box.get(sehir));
        print("SEHİREKİ VİRUS SAYISI : $sehirdekiVirusSayisi");
        int renk = Map(sehirdekiVirusSayisi,0,Level*100,-254,254);
        print("RENK : $renk");
        if (renk < 0)
          sehirRenk = Color.fromRGBO(renk, 255, 0, 1);
        else
          sehirRenk =
              Color.fromRGBO(255, 255 - (renk - 255), 0, 1);
        print(renk);
      });
    }
    /*while (sehirdekiVirusSayisi == 0) {
      setState(() {
        sehirdekiVirusSayisi = int.parse(box.get(sehir));
        if(sehirdekiVirusSayisi< 255) sehirRenk = Color.fromRGBO(sehirdekiVirusSayisi, 255, 0, 1);
        else sehirRenk = Color.fromRGBO(255, 255-(sehirdekiVirusSayisi-255), 0, 1);
        print(sehirdekiVirusSayisi);
      });
    }*/
  }

  Future<void> sehirdenVirusSayisiDus(String sehir, int toplampuan) async {
    debugPrint("şehirdeki virüsler öldü mü?");

    var box = await Hive.openBox("sehirVeriler");
    int suankiVirusSayisi = int.parse(box.get(sehir));
    if (suankiVirusSayisi < 1) {
      Level = box.get("LEVEL");
      Level = Level + 1;
      box.delete("LEVEL");
      box.put("LEVEL", Level);
      print("Seviye Yükseldi : $Level");
      VirusDusmeSayisi = Level * 10;

      //int suankiVirusSayisi = int.parse(box.get(sehir));
      int yeniVirusSayisi = (Level * 100) + VirusDusmeSayisi;
      box.delete(sehir);
      box.put(sehir, yeniVirusSayisi.toString());
      _showLevelUp();
    }
    if (nereyeOynuyor == "PUAN" && (Puan) > VirusDusmeSayisi) {
      int suankiVirusSayisi = int.parse(box.get(sehir));
      int yeniVirusSayisi = suankiVirusSayisi - VirusDusmeSayisi;
      box.delete(sehir);
      box.put(sehir, yeniVirusSayisi.toString());

      Puan = Puan - VirusDusmeSayisi;
      print("D_SEHIR" + Puan.toString());


        sehirdekiVirusSayisi = int.parse(box.get(sehir));
        print("SEHİREKİ VİRUS SAYISI : $sehirdekiVirusSayisi");
        int renk = Map(sehirdekiVirusSayisi,0,Level*100,-254,254);
        print("RENK : $renk");
        if (renk < 0)
          sehirRenk = Color.fromRGBO(renk, 255, 0, 1);
        else
          sehirRenk =
              Color.fromRGBO(255, 255 - (renk - 255), 0, 1);
        print(renk);




      int suankiPuan = box.get(nereyeOynuyor);
      int yeniPuan = suankiPuan - VirusDusmeSayisi;
      box.delete(nereyeOynuyor);
      box.put(nereyeOynuyor, yeniPuan);
    }
//
    // kendimPuan = kendimPuan;
  }

  _showPuan() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text(
              "Yetersiz puan!",
              textAlign: TextAlign.center,
            ),
            content: Text(
              "Şehrine yardım etmek için en az $VirusDusmeSayisi puanın olmalı.",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[],
          );
        });
  }

  _showLevelUp() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text(
              "Yeni Seviye : $Level",
              textAlign: TextAlign.center,
            ),
            content: Text(
              "Tebrikler ! Seviye atladın.",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[],
          );
        });
  }


  int Map(int value, int fromSource, int toSource, int fromTarget, int toTarget)
  {
    print("Map : $value");
    double deger = (value - fromSource) / (toSource - fromSource) * (toTarget - fromTarget) + fromTarget;
  return int.parse(deger.toStringAsFixed(0));
  }

}
