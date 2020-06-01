import 'package:corona_oyun/su_oyunu/water-game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

import '../../global.dart';
import '../colors.dart';

int ulkedekiVirusSayisi = 0;
Color sehirRenk = Color.fromRGBO(80, 80, 80, 1);

class UlkemPage extends StatefulWidget {
  const UlkemPage([Key key]) : super(key: key);

  @override
  _UlkemPage createState() => _UlkemPage();
}

class _UlkemPage extends State<UlkemPage> {
  final String killer = "kaynaklar/sehrim_resimler/killer.svg";
  WaterGame oldur = new WaterGame(null);

  @override
  Widget build(BuildContext context) {
    VirusSayisiGetir(kullaniciUlke);
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
                    child: Text("Virüs öldür",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12
                      ),
                      textAlign: TextAlign.center,),
                  ),

                  InkWell(

                    child: Container(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(killer),
                    ),

                    onTap: ()  {

                      debugPrint("öldür baba");

                      setState(()  {
                        if(Puan < 5)
                        {
                          return _showPuan();
                        }
                        else {
                          ulkedenVirusSayisiDus(kullaniciUlke, oldur.totalScore);
                        }
                      });

                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                SvgPicture.asset("kaynaklar/kendim_resimler/elmas.svg",width: 25,height: 25,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("$Puan",style: TextStyle(fontFamily: "ssRegular",fontSize: 25),),
                ),

              ],
            ),
          ),
          Align(alignment:Alignment(0,-0.45),child: SvgPicture.asset("kaynaklar/ulkem_resimler/tr.svg",color: sehirRenk,)),
          Align(alignment:Alignment(0,-0.05),child: Text('TÜRKİYE',style: TextStyle(fontFamily: "ssLight",fontSize: 30),)),
          Align(alignment:Alignment(0,-0.25),child: Text(ulkedekiVirusSayisi.toString(),style: TextStyle(fontFamily: "ssRegular",fontSize: 80),)),
        ],
      ),
    );
  }

  Future<void> VirusSayisiGetir(String ulke) async {
    var box = await Hive.openBox("sehirVeriler");

    if(ulkedekiVirusSayisi != int.parse(box.get(ulke)))
    {
      setState(() {
        ulkedekiVirusSayisi = int.parse(box.get('TURKIYE'));
        if(ulkedekiVirusSayisi< 255) sehirRenk = Color.fromRGBO(ulkedekiVirusSayisi, 255, 0, 1);
        else sehirRenk = Color.fromRGBO(255, 255-(ulkedekiVirusSayisi-255), 0, 1);
        print(ulkedekiVirusSayisi);
      });
    }
  }
  Future<void> ulkedenVirusSayisiDus(String ulke, int toplampuan) async {


    debugPrint(ulke);

    var box = await Hive.openBox("sehirVeriler");

    if(nereyeOynuyor == "KENDIM_PUAN" && (Puan) >4){

      print(ulkedekiVirusSayisi);
      int ulkedekiVirusSay = int.parse(box.get(ulke));
      int yeniVirusSayisi = ulkedekiVirusSayisi - 5;
      box.delete(ulke);
      box.put(ulke, yeniVirusSayisi.toString());

      Puan = (Puan - 5);
      print(Puan);


    }
    int suankiPuan = box.get(nereyeOynuyor);
    int yeniPuan = suankiPuan -5;
    box.delete(nereyeOynuyor);
    box.put(nereyeOynuyor,yeniPuan);
  }





  _showPuan() {
    showDialog(
        context: context,
        builder: (BuildContext context) {

          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)),

            title: Text("Yetersiz puan!",
              textAlign: TextAlign.center,),
            content: Text("Şehrine yardım etmek için en az 5 puanın olmalı.",
              textAlign: TextAlign.center,),

            actions: <Widget>[
            ],
          );
        }

    );
  }
}
