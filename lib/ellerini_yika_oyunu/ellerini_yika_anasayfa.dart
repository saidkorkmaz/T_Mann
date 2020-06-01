import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:corona_oyun/ellerini_yika_oyunu/balon_sayfasi.dart';
import 'package:corona_oyun/ellerini_yika_oyunu/eller_model/kopuk2.dart';
import 'package:corona_oyun/ellerini_yika_oyunu/kopuk_sayfasi.dart';
import 'package:corona_oyun/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';

import '../game_over.dart';



class EllerPage extends StatefulWidget {
  EllerPage({Key key, this.title, this.offset}) : super(key: key);
  final Offset offset;
  final String title;

  @override
  _EllerPageState createState() => _EllerPageState();
}

class _EllerPageState extends State<EllerPage> {



  String kirli_el = "kaynaklar/eller_resim/kirli.svg";
  final String sabun = "kaynaklar/eller_resim/soap.svg";
  final String musluk = "kaynaklar/eller_resim/musluk.svg";
  final String water = "kaynaklar/eller_resim/su.svg";


  String el_yikama1 = "kaynaklar/eller_resim/el1.png";
  String el_yikama2 = "kaynaklar/eller_resim/el2.png";
  String el_yikama3 = "kaynaklar/eller_resim/el3.png";
  String el_yikama4 = "kaynaklar/eller_resim/el4.png";
  String el_yikama5 = "kaynaklar/eller_resim/el5.png";
  String el_yikama6 = "kaynaklar/eller_resim/el6.png";


  bool varMi = false;
  bool suVarMi = false;


  Timer timer;

  int start = 60;

  int toplamPuan;



  @override
  void dispose() {
    timer.cancel();
    super.dispose();

  }

  void startTimer(){

    timer = Timer.periodic(Duration(seconds: 1),
            (Timer timer) {

          setState(() {

            if(start < 1)
            {

            }
            else
            {
              start -- ;
            }
          });

        });
  }



  int _counter = 0;

  void _puanKazan() {

    setState(() {

      if(start != 0)
     { _counter++; }

    });
  }

  void _puanKazan_sabun(){
    setState(() {

      if(start != 0) {
        _counter = _counter + 3;
      }
    });
  }


  void _puanKazan_eller(){
    setState(() {
      if(start != 0) {
        _counter = _counter + 5;
      }
    });
  }

  AppBar appBar;

  int a = 1;

  bool accepted = false;

  Color lightDfabColor = Colors.yellow;

  Offset offset = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    checkVal = false;
    print("anasayfa"+ checkVal.toString());


    startTimer();

    initPlayer();

    offset = widget.offset;
  }


  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  final String sarkiAc = "kaynaklar/eller_resim/music.svg";
  final String sarkiKapat = "kaynaklar/eller_resim/pembe_sessiz.svg";

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.durationHandler = (d) => setState(() {
      _duration = d;
    });

    advancedPlayer.positionHandler = (p) => setState(() {
      _position = p;
    });
  }



  @override
  Widget build(BuildContext context) {

    return WillPopScope(

      onWillPop: () async {
        debugPrint("on will pop çalıstı Kadriye");

              await advancedPlayer.stop();

              Navigator.of(context).pop();

      },


      child: Scaffold(
        resizeToAvoidBottomPadding: false,



        body: Container(  
          color: Colors.lightBlue[200],
          child: Stack (

              children: <Widget>[

                baloncuk(),



                Padding(
                  padding: const EdgeInsets.only(top: 37, left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[


                       CircleAvatar(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:  Text(
                                '$_counter',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                )
                            ),

                          ),
                          backgroundColor: Colors.pinkAccent,
                          radius: 27,
                        ),


                    ],
                  ),
                ),



               //süre
                Padding(
                  padding: const EdgeInsets.only(top: 37.0, right: 20),
                  child: Align(
                    alignment: Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          border: Border.all(
                            width: 3,
                            color: Colors.pinkAccent
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Text(
                              "$start",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white
                              ),
                            ),
                          )
                        ),
                      )
                  ),
                ),




                Positioned (
                  child: Align(
                      alignment: FractionalOffset.center,
                      child: Container(
                        width: 250.0,
                        height: 250.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: DragTarget(
                            builder: (context, List<String> candidateData, rejectedData) {
                              print('builder');
                              return Center(
                                  child: Stack(
                                    children: <Widget>[


                                      kopuk(varMi, suVarMi),

                                    ],
                                  )
                              );
                            },

                            //üzerindeyken
                            onWillAccept: (data) {
                              print('onWillAccept ' + data);

                              if(data == 'sabun_bilgi'){
                                _puanKazan_sabun();

                                setState(() {
                                  if(start != 0)
                                  {
                                    suVarMi = false;
                                    varMi = true;
                                  }
                                });

                                return true;
                              }

                              if(data == 'su_bilgi'){
                                _puanKazan();

                                setState(() {
                                  if(start != 0)
                                  {
                                    varMi = false;
                                    suVarMi = true;
                                  }
                                    });

                                return true;
                              }

                              return true;
                            },


                            //üzerine bırakınca
                            onAccept: (data) {
                              print('onAccept ' + data);
                              if(data == 'sabun_bilgi'){

                                return true;
                              }

                              if(data == 'su_bilgi'){

                                return true;
                              }


                              if(data == 'eldata1'){

                                _puanKazan_eller();

                                setState(() {
                                  a = 2;
                                });
                                return true;
                              }

                              if(data == 'eldata2'){

                                _puanKazan_eller();

                                setState(() {
                                  a = 3;
                                });
                                return true;
                              }

                              if(data == 'eldata3'){

                                _puanKazan_eller();

                                setState(() {
                                  a = 4;
                                });
                                return true;
                              }

                              if(data == 'eldata4'){

                                _puanKazan_eller();

                                setState(() {
                                  a = 5;
                                });
                                return true;
                              }

                              if(data == 'eldata5'){

                                _puanKazan_eller();

                                setState(() {
                                  a = 6;
                                });
                                return true;
                              }

                              if(data == 'eldata6'){

                                _puanKazan_eller();

                                setState(() {
                                  a = 7;
                                });
                                return true;
                              }

                            },

                            //ayrılınca
                            onLeave: (data) {
                              print('onLeave' + data);
                            }

                        ),
                      )
                  ),
                ),



                Padding(
                  padding: const EdgeInsets.only(bottom: 100, left: 10, right: 10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[

                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Draggable(

                              data: "eldata1",
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(el_yikama1),
                              ),

                              childWhenDragging: CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(el_yikama1),
                              ),


                              feedback: CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(el_yikama1),
                              ),



                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Draggable(

                              data: "eldata2",
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20,
                                backgroundImage: AssetImage(el_yikama2),
                              ),

                              childWhenDragging: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20,
                                backgroundImage: AssetImage(el_yikama2),
                              ),


                              feedback: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30,
                                backgroundImage: AssetImage(el_yikama2),
                              ),


                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Draggable(

                              data: "eldata3",
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(el_yikama3),
                              ),

                              childWhenDragging: CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(el_yikama3),
                              ),


                              feedback: CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(el_yikama3),
                              ),


                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child:Draggable(

                              data: "eldata4",
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(el_yikama4),
                              ),

                              childWhenDragging: CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(el_yikama4),
                              ),


                              feedback: CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(el_yikama4),
                              ),


                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child:Draggable(

                              data: "eldata5",
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(el_yikama5),
                              ),

                              childWhenDragging: CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(el_yikama5),
                              ),


                              feedback: CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(el_yikama5),
                              ),


                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Draggable(

                              data: "eldata6",
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(el_yikama6),
                              ),

                              childWhenDragging: CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(el_yikama6),
                              ),


                              feedback: CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(el_yikama6),
                              ),


                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                ),



                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child:

                    MaterialButton(
                      minWidth: 300,
                      onPressed: () {

                        _showDialog();

                      },
                      shape: StadiumBorder(),
                      splashColor: Colors.blue,
                      color: Colors.pinkAccent,
                      child: Text("Ellerini kurula"),
                    ),


                  ),
                ),





                Stack(
                  children: <Widget>[
                    musluk_fonksiyonu(),
                    sabun_fonksiyonu(),

                  ],
                ),



                Padding(
                  padding: const EdgeInsets.only(top:50.0),
                  child:


                  Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Container(
                            height: 30,
                            width: 30,
                            child: InkWell(
                              onTap: () async {

                                await audioCache.play('sarki.mp3');

                                debugPrint("müzik açıldı");

                              },
                              child: SvgPicture.asset(
                                  sarkiAc
                              ),
                            ),
                          ),
                        ),



                        Container(
                          height: 30,
                          width: 30,
                          child: InkWell(
                            onTap: () async {

                              await advancedPlayer.pause();

                              debugPrint("müzik kapatıldı");

                            },
                            child: SvgPicture.asset(
                                sarkiKapat
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),



                )

              ]
          ),
        ),
      ),
    );
  }




  baloncuk()
  {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Particles(30),
      ),
    );
  }



  kopuk(bool varMi, bool suVarMi)
  {
    if(varMi == true && suVarMi == false) {
      return Center(
        child: Stack(
          children: <Widget>[


            Align(
              alignment: Alignment.center,
              child: resim(a),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  color: Colors.transparent,
                  child: Bubbles(),
                  height: 1,
                  width: 1,
                ),
              ),
            ),

          ],
        ),
      );
    }
    if(suVarMi == true && varMi == false)
    {
      return Center(
        child: Stack(
          children: <Widget>[

            Align(
              alignment: Alignment.center,
              child: resim(a),
            ),

            Align(
              alignment: Alignment.center,
              child: Container(
                child: Kopuk(30),
                height: 100,
                width: 100,
              ),
            ),

          ],
        ),
      );
    }

    if(varMi == false && suVarMi == false)
    {
      return Center(
        child: Stack(
          children: <Widget>[

            Align(
              alignment: Alignment.center,
              child: resim(a),
            ),

          ],
        ),
      );
    }

  }


  resim(int a)
  {
    if(a == 1)
    {
      return SvgPicture.asset(
        kirli_el,
        width: 250,
        height: 250,
      );
    }

    if( a == 2)
    {
      return CircleAvatar(
          backgroundColor: Colors.white,
          radius: 87,
          child: Image(image: AssetImage(el_yikama1))
      );
    }

    if(a == 3)
    {
      return CircleAvatar(
          backgroundColor: Colors.white,
          radius: 87,
          child: Image(image: AssetImage(el_yikama2))
      );
    }

    if( a == 4)
    {
      return CircleAvatar(
          backgroundColor: Colors.white,
          radius: 87,
          child: Image(image: AssetImage(el_yikama3))
      );
    }

    if( a == 5)
    {
      return CircleAvatar(
          backgroundColor: Colors.white,
          radius: 87,
          child: Image(image: AssetImage(el_yikama4))
      );
    }

    if( a == 6)
    {
      return CircleAvatar(
          backgroundColor: Colors.white,
          radius: 87,
          child: Image(image: AssetImage(el_yikama5))
      );
    }

    if( a == 7)
    {
      return CircleAvatar(
          backgroundColor: Colors.white,
          radius: 87,
          child: Image(image: AssetImage(el_yikama6))
      );
    }

  }



  musluk_fonksiyonu()
  {
    return Padding(
      padding: const EdgeInsets.only(top:120.0, left: 70),
      child: Align(
        alignment: Alignment.topLeft,
        child: Draggable(

          data: "su_bilgi",

          //çekmeden önce
          child: SvgPicture.asset(musluk,
            height: 50,
            width: 50,),

          //çekince arkanda bıraktığın
          childWhenDragging: SvgPicture.asset(musluk,
            height: 50,
            width: 50,),

          //çekince eline aldığın
          feedback:SvgPicture.asset(
            water,
            height: 50,
            width: 50,),

        ),
      ),
    );
  }


  sabun_fonksiyonu(){
    return Padding(
      padding: const EdgeInsets.only(top: 115.0, right: 70),
      child: Align(
        alignment: Alignment.topRight,
        child: Draggable(

          data: "sabun_bilgi",

          //çekmeden önce
          child: SvgPicture.asset(sabun,
            height: 60,
            width: 60,),

          //çekince arkanda bıraktığın
          childWhenDragging: SvgPicture.asset(sabun,
            height: 60,
            width: 60,),

          //çekince eline aldığın
          feedback:SvgPicture.asset(sabun,
            height: 60,
            width: 60,),

        ),
      ),
    );
  }


  _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,  //sadece butonlara basınca ekrandan çıkıyor
      builder: (BuildContext context) {

        return AlertDialog(



          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(20.0)),

          title: Text("Ellerini kuruladın mı?"),
          content: Text("El yıkama işlemini, ellerini kurulayarak bitirmelisin. "
              "Hem böylece, bu oyundan kazandığın puanları kullanabilirsin!"),

          actions: <Widget>[


            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: MaterialButton(
                shape: StadiumBorder(),
                minWidth: 100,
                color: Colors.pinkAccent,
                child: new Text("Evet"),
                onPressed: () {
                  setState(() {
                    varMi = false;
                    suVarMi = false;
                  });

               //   _showPuan();



                  showDialog(
                      context: context,
                      builder: (BuildContext context) => GameOverDialog(

                        enYuksekPuan: 100,
                        simdikiPuan: _counter,
                        uyariYazisi: "Bu sadece bir oyun, önemli olan gerçekten ellerini yıkaman. Gerçekten ellerini yıkadıysan bu kutucuğu işaretle.",
                        tekrarOynaMethod: (){print("Tekrar oyna");},));




                },
              ),
            ),

            MaterialButton(
              shape: StadiumBorder(),
              minWidth: 100,
              color: Colors.pinkAccent,
              child: new Text("Hayır"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      },
    );
  }



  _showPuan() {
    showDialog(
      context: context,
      builder: (BuildContext context) {

        toplamPuan = _counter;

        return AlertDialog(


          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(20.0)),

          title: Text("Toplam puanın:",
          textAlign: TextAlign.center,),
          content: Text("$toplamPuan",
            textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20
          ),),

          actions: <Widget>[


          ],
        );
      },
    );
  }


   bool puanEkle = true;

  Future<void> sehirdenVirusSayisiDusvePuanEkle(String sehir, int toplampuan) async {




    if(puanEkle)
    {
      debugPrint("ellerini yıkadın kaptın puanı");

      puanEkle = false;
      var box = await Hive.openBox("sehirVeriler");

      int suankiPuan = box.get(nereyeOynuyor);
      int yeniPuan = suankiPuan + toplampuan;
      box.delete(nereyeOynuyor);
      box.put(nereyeOynuyor,yeniPuan);

    }
  }



}


