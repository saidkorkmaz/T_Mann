import 'dart:io';

import 'package:corona_oyun/ana_sayfa/anasayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

import 'ana_sayfa/colors.dart';


Future<void> main() async {



}
Color loading = Colors.transparent;
class MyApp3 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Corona Oyunlar',
        home: Ana()
    );
  }



}
class Ana extends StatefulWidget {
  @override
  _Ana createState() => _Ana();
}

class _Ana extends State<Ana>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xffFFB75E), Color(0xffED8F03)])
        ),
        child: Padding(
          padding: const EdgeInsets.only(top:80,bottom:60,right:24.0, left:24),
          child: Container(

            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Color(0xccffffff),
                borderRadius: BorderRadius.all(Radius.circular(30)),
                boxShadow: [
                  BoxShadow(color: Colors.grey[400], blurRadius: 20)
                ]),

            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom:18.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Stack(children: <Widget>[
                        Icon(Icons.phone_android,size: 70,),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Icon(FontAwesomeIcons.handSparkles),
                        ),
                      ],),
                    ),
                  ),

                  Text("Merhaba !",style: TextStyle(fontFamily: "ssLight",fontSize: 40),textAlign: TextAlign.center, textScaleFactor: 1,),

                  Divider(),
                  Text("Oyuna başlamadan önce, ufak bir hatırlatma. "
                      "En çok kullandığımız eşyalardan birisi olan "
                      "cep telefonunu temizledin mi?",style: TextStyle(fontFamily: "ssLight",fontSize: 25),textAlign: TextAlign.center,),


                  Divider(),




                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child: FloatingActionButton(
                              heroTag: null,
                              onPressed: (){exit(0);},
                              backgroundColor: Colors.red,
                              child: Icon(Icons.close,size: 50,),),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child: FloatingActionButton(
                              heroTag: null,
                              onPressed: () {
                              setState(() {
                                loading = turuncu;
                              });

                              anasayfaAc();


                              },
                              backgroundColor: Colors.green,
                              child: Icon(Icons.check,size: 50,),),
                          ),
                        ),
                      ),

                    ],
                  ),
                  Center(child: Loading(indicator: BallPulseIndicator(), size: 50,color: loading),),







                ],
              ),
            ),
          ),
        ),
      ),



    );
  }
  void anasayfaAc() async{

    await Future.delayed(const Duration(milliseconds: 700), () {
      setState(() {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp2()));
      });
    });


  }

}


class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox.expand(child: AnasayfaPage()),
        ],
      ),
    );
  }}

