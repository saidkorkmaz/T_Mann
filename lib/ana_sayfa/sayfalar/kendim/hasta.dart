import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:dashed_container/dashed_container.dart';

import '../../../global.dart';

class HastaPage extends StatefulWidget {
  State<StatefulWidget> createState() => MyApp2();
}

class MyApp2 extends State<HastaPage> {

  bool hastaKizMi = false;


  dynamic randomImagesErkek = [
    "kaynaklar/kendim_resimler/hasta_erkek1.svg",
    "kaynaklar/kendim_resimler/hasta_erkek2.svg",
    "kaynaklar/kendim_resimler/hasta_erkek3.svg",
  ];


  dynamic randomImages = [
    "kaynaklar/kendim_resimler/hasta1.svg",
    "kaynaklar/kendim_resimler/hasta2.svg",
    "kaynaklar/kendim_resimler/hasta3.svg",
  ];

  Random rnd, rnd2;

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
                            onTap: (){

                              _showDialog();

                            },
                              child: SvgPicture.asset(guc)
                          ),
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
                    child: DashedContainer(
                      child: Container(
                        height: 70.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Bağışıklığın düşük olduğu için şu an hastasın!",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      dashColor: Colors.black,
                      borderRadius: 20.0,
                      dashedLength: 30.0,
                      blankLength: 6.0,
                      strokeWidth: 6.0,
                    ),
                  ),
                ),
              ),
              Align(alignment: Alignment.center, child: cinsiyet(context, hastaKizMi))
            ],
          ),
        ));
  }


  //random resimler için
  Widget buildImage(BuildContext context, bool cinsiyet) {
    int min = 0;
    int max = randomImages.length - 1;
    rnd = new Random();
    int r = min + rnd.nextInt(max - min);
    String image_name = randomImages[r].toString();
    return Container(
      height: 200,
      width: 200,
      child: SvgPicture.asset(image_name),
    );
  }


  //random resimler için
  Widget buildImageErkek(BuildContext context, bool cinsiyet) {
    int min = 0;
    int max = randomImagesErkek.length - 1;
    rnd2 = new Random();
    int r = min + rnd2.nextInt(max - min);
    String image_nameErkek = randomImagesErkek[r].toString();
    return Container(
      height: 200,
      width: 200,
      child: SvgPicture.asset(image_nameErkek),
    );
  }

  cinsiyet(BuildContext context, bool cinsiyet)
  {
    if(kullaniciCinsiyet == "Kadın"){
      hastaKizMi=true;
    }else{
      hastaKizMi=false;
    }
    if(hastaKizMi)
    {
      return buildImage(context, cinsiyet);
    }
    else
    {
      return buildImageErkek(context, cinsiyet);
    }
  }


  _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {

        return AlertDialog(

          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(20.0)),

          title: Text(
            "Yeterli puana sahip değilsin!",
          textAlign: TextAlign.center,
          ),

          content: Text(
            "Bağışıklığını yükseltmek için 200 puanın olmalı."
              "\nOyun oynayarak puan kazanabilirsin.",
          textAlign: TextAlign.center,
          ),

          actions: <Widget>[


          ],
        );
      },
    );
  }


}
