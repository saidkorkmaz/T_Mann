import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'ana_sayfa/anasayfa.dart';
import 'ana_sayfa/colors.dart';
import 'global.dart';

class GameOverDialog extends StatefulWidget {
  final String uyariYazisi;
  final int enYuksekPuan, simdikiPuan;
  final Function tekrarOynaMethod;

  GameOverDialog({
    @required this.enYuksekPuan,
    @required this.simdikiPuan,
    @required this.uyariYazisi,
    @required this.tekrarOynaMethod,
  });

  @override
  _GameOverDialog createState() => _GameOverDialog();
}

class _GameOverDialog extends State<GameOverDialog> {
  bool gercektenYaptinmi = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                mainAxisSize: MainAxisSize.min, // To make the card compact
                children: <Widget>[
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "En yüksek : " + widget.enYuksekPuan.toString(),
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
                      widget.simdikiPuan.toString(),
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
                              print(checkVal);
                            });
                          },
                          activeColor: turuncu),
                      Expanded(
                          child: Text(
                        widget.uyariYazisi,
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
                        padding: const EdgeInsets.only(left: 24.0, bottom: 24),
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
                                  sehirdenVirusSayisiDusvePuanEkle(kullaniciSehir, widget.simdikiPuan);
                                }
                                print(context.widget.key);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            AnasayfaPage()),
                                    (route) => false);
                              },
                              child: Icon(Icons.home, size: 45),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 24.0, bottom: 24),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            width: 70,
                            height: 70,
                            child: FloatingActionButton(
                              backgroundColor: turuncu,
                              heroTag: null,
                              onPressed: widget.tekrarOynaMethod,
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
        ));
  }

  bool puanEkle = true;

  Future<void> sehirdenVirusSayisiDusvePuanEkle(String sehir, int toplampuan) async {




    if(puanEkle)
    {
      puanEkle = false;
      var box = await Hive.openBox("sehirVeriler");

      int suankiPuan = box.get(nereyeOynuyor);
      int yeniPuan = suankiPuan + toplampuan;
      box.delete(nereyeOynuyor);
      box.put(nereyeOynuyor,yeniPuan);
      /*print("SUUU HIGHHHHHHHHHHHHHHHHHHHHH");
        print(box.get("SU_HIGH"));*/
      if(toplampuan > box.get("SU_HIGH")){
        box.delete("SU_HIGH");
        box.put("SU_HIGH",toplampuan);
        suHigh = toplampuan;
        print("En yüksek değişti");
      }
      debugPrint("ellerini yıkadın kaptın puanı");




    }
  }

  void gercektenYaptinmiTiklendi(bool value) {
    setState(() {
      gercektenYaptinmi = value;
      print(value);
    });
  }
}
