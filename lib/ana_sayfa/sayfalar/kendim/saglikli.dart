import 'package:dashed_container/dashed_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../global.dart';

class SaglikliPage extends StatefulWidget {
  State<StatefulWidget> createState() => MyApp2();
}

class MyApp2 extends State<SaglikliPage> {
  bool kizMi = false;

  final String kiz = "kaynaklar/kendim_resimler/hasta.svg";
  final String erkek = "kaynaklar/kendim_resimler/saglam_erkek.svg";

  final String guc = "kaynaklar/kendim_resimler/guc.svg";

  final String puanFoto = "kaynaklar/kendim_resimler/elmas.svg";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Bağışıklığını yükselt",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        height: 35,
                        width: 35,
                        child: InkWell(
                            onTap: () {
                              _showDialog();
                            },
                            child: SvgPicture.asset(guc)),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 70,
                        child: Text(
                          "Puanım:",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 30,
                            width: 30,
                            child: SvgPicture.asset(puanFoto),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              "$Puan",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 73.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(color:Colors.grey[400],blurRadius: 8)],
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            "Hiçbir hastalık, alınan tedbirlerden \ndaha güçlü değildir!"
                            "\n Sağlıklısın.",textScaleFactor: 1,
                            style: TextStyle(
                              fontFamily: "ssRegular",
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //foto ayarlama cinsiyete göre
              cinsiyet()
            ],
          ),
        ));
  }


  cinsiyet() {
    if (kullaniciCinsiyet == "Kadın") {
      return Align(
          alignment: Alignment.center,
          child: Container(
            height: 200,
            width: 200,
            child: SvgPicture.asset(kiz),
          ));
    } else {
      return Align(
          alignment: Alignment.center,
          child: Container(
            height: 200,
            width: 200,
            child: SvgPicture.asset(erkek),
          ));
    }
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(
            "Bağışıklığın zaten güçlü!",
            textAlign: TextAlign.center,
          ),
          content: Text(
            "Başkalarına yardım etmek için oyun oynayarak puan toplayabilirsin.",
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[],
        );
      },
    );
  }
}
