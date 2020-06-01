import 'dart:ui';

import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../global.dart';
import 'colors.dart';

class Profil extends StatelessWidget {
  List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
  String _selectedLocation; // Option 2

  bool kizMi = true;
  final Widget svg = new SvgPicture.asset(
    "kaynaklar/kendim_resimler/hasta.svg",
  );

  final String kiz = "assets/images/healthy.png";
  final String erkek = "assets/images/healthy_boy.png";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,

        backgroundColor: koyuBeyaz,
        
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xffFFB75E), Color(0xffED8F03)])
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 120),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(color: Colors.grey[350], blurRadius: 20)
                      ]),
                ),
              ),
              Align(
                alignment: Alignment(0, 1),
                child: Stack(
                  children: <Widget>[
                    ClipShadow(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[400],
                            blurRadius: 20,
                            offset: Offset(0, 0))
                      ],
                      clipper: OvalTopBorderClipper(),
                      child: Container(
                        height: 100,
                      ),
                    ),
                    ClipPath(
                      clipper: OvalTopBorderClipper(),
                      child: Container(
                        height: 100,
                        color: koyuBeyaz,
                      ),
                    )
                  ],
                ),
              ),
              Align(
                  alignment: Alignment(-0.65, 0.8),
                  child: FloatingActionButton(
                    onPressed: null,
                    heroTag: null,
                    child: Icon(Icons.trending_up),
                    backgroundColor: acikKoyu,
                  )),
              Align(
                  alignment: Alignment(0.65, 0.8),
                  child: FloatingActionButton(
                    heroTag: null,
                    child: Icon(Icons.person),
                    backgroundColor: turuncu,
                    onPressed: null,
                  )),
              Align(
                  alignment: Alignment(0.0, 0.8),
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: FloatingActionButton(
                      heroTag: null,
                      child: Icon(
                        Icons.home,
                        size: 50,
                      ),
                      backgroundColor: acikKoyu,
                      onPressed: () => Navigator.pop(context),
                    ),
                  )),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1, // 20%
                    child: Container(),
                  ),
                  Expanded(
                    flex: 6, // 60%
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              width: 200.0,
                              height: 200.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: SizedBox(
                                      height: 40,
                                      width: 40,
                                   /*   child: FloatingActionButton(
                                        onPressed: null,
                                        heroTag: null,
                                        backgroundColor: Colors.white,
                                        child: Icon(Icons.edit, color: turuncu),
                                      ),*/
                                    )),
                              ),

                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[350], blurRadius: 20)
                                  ],
                                  image:  DecorationImage(image: AssetImage(cinsiyet(kizMi)),),

                                  //DecorationImage(
                                    //  fit: BoxFit.fitHeight,
                                      //image: NetworkImage(
                                        //  "https://www.meshur.co/wp-content/uploads/2019/02/BARBARA_PALVIN_02-650x427.jpg"))
                                  //
                                  )),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            /*child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  kullaniciAdi + " ",
                                  style: TextStyle(
                                      fontFamily: "ssRegular", fontSize: 40),
                                ),
                                Text(
                                  kullaniciSoyAdi,
                                  style: TextStyle(
                                      fontFamily: "ssLight", fontSize: 40),
                                )
                              ],
                            ),*/
                          ),

                          ListTile(

                            leading: Icon(FontAwesomeIcons.transgender),
                            title: Text(

                              kullaniciCinsiyet,
                              style: TextStyle(
                                  fontFamily: "ssRegular", fontSize: 30),
                            ),
                            trailing:new DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                              items: <String>['Kadın', 'Erkek'].map((String value) {
                                return new DropdownMenuItem<String>(

                                  value: kullaniciCinsiyet,
                                  child: new Text(value),

                                  onTap: () {
                                    print(value);
                                    kullaniciCinsiyet = value;
                                   // kullaniciCinsiyet = value;
                                  },



                                );
                              }).toList(),
                              icon: Icon(
                                  Icons.arrow_drop_down_circle, color: turuncu
                              ),


                              onChanged: (_) {

                                print("onchanged"+ kullaniciCinsiyet);
                                cinsiyetiDegistir(kullaniciCinsiyet);
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (context) => Profil()));
                              },
                            ),)
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(FontAwesomeIcons.mapMarkerAlt),
                            title: Text(
                              kullaniciSehir,
                              style: TextStyle(
                                  fontFamily: "ssRegular", fontSize: 30),
                            ),
                            trailing: Icon(
                              Icons.edit,
                              color: turuncu,

                            ),
                            onTap: (){

                            },
                          ),
                          Divider(),

                          /*Container(
                            height: 60,
                            decoration: BoxDecoration(color:Colors.grey[50], borderRadius: BorderRadius.circular(8),boxShadow: [BoxShadow(color:Colors.grey[300],blurRadius: 8)]),
                          )*/
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1, // 20%
                    child: Container(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  cinsiyet(bool cinsiyet) {
    if (kullaniciCinsiyet == "Kadın") {
      return  kiz;
    } else {
      return erkek;
    }
  }
  Future<void> cinsiyetiDegistir(String cinsiyet) async {

  }
}
