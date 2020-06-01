import 'package:corona_oyun/ana_sayfa/profil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../global.dart';
import 'colors.dart';
import 'radial_animation.dart';
import 'tab_icerik.dart';

TabController tabController;

class AnasayfaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlutterBase',
        home: Container(height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,child: RadialMenu()),

    );
  }
}

class RadialMenu extends StatefulWidget {
  createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu> with TickerProviderStateMixin {
  AnimationController controller;
  TabController _tabController;
  final infoController = TextEditingController();
  final List<Tab> myTabs = <Tab>[
    new Tab(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: turuncu, width: 1)),
        child: Align(
          alignment: Alignment.center,
          child: Text("ŞEHRİM"),
        ),
      ),
    ),
    new Tab(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: turuncu, width: 1)),
        child: Align(
          alignment: Alignment.center,
          child: Text("KENDİM"),
        ),
      ),
    ),
    new Tab(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: turuncu, width: 1)),
        child: Align(
          alignment: Alignment.center,
          child: Text("ÜLKEM"),
        ),
      ),
    )
  ];

  @override
  void initState() {
    print("anasayfa"+ checkVal.toString());

    checkVal = false;
    print("anasayfa"+ checkVal.toString());

    puanlariGetir();
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);

    _tabController = new TabController(vsync: this, length: myTabs.length);
    tabController = _tabController;
    _tabController.index = 1;
    _tabController.addListener(() {

      if (Puan < 20) {
        if (tabController.index == 0) {
          tabController.index = 1;
          infoController.text = "200 puana ulaşmalısın!";
          Future.delayed(const Duration(milliseconds: 2000), () {
            setState(() {
              infoController.text = "";
            });
          });
        }


        print("Nereye Oynuyor : $nereyeOynuyor");
      }

      if (Puan < 600) {
        if (tabController.index == 2) {
          tabController.index = 1;
          infoController.text = "600 puana ulaşmalısın!";
          Future.delayed(const Duration(milliseconds: 2000), () {
            setState(() {
              infoController.text = "";
            });
          });
        }

//        if (tabController.index == 0) nereyeOynuyor = "SEHRIM_PUAN";
//        if (tabController.index == 1) nereyeOynuyor = "KENDIM_PUAN";
//        if (tabController.index == 2) nereyeOynuyor = "ULKEM_PUAN";
//        print("Nereye Oynuyor : $nereyeOynuyor");
      }
    });

    // ..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  //    resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          backgroundColor: beyaz,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: TabBar(
              unselectedLabelColor: turuncu,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: turuncu),
              controller: _tabController,
              tabs: myTabs,
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            TabBarView(
              controller: _tabController,
              children: [Sehrim(), Kendim(), Ulkem()],
            ),
            Align(
              alignment: Alignment(0, 1),
              child: ClipPath(
                clipper: OvalTopBorderClipper(),
                child: Container(
                  height: 100,
                  color: koyuBeyaz,
                ),
              ),
            ),
            Align(
                alignment: Alignment(-0.65, 0.8),
                child: FloatingActionButton(
                  heroTag: null,
                  onPressed: null,
                  child: Icon(Icons.trending_up),
                  backgroundColor: acikKoyu,
                )),
            Align(
                alignment: Alignment(0.65, 0.8),
                child: FloatingActionButton(
                  heroTag: null,
                  child: Icon(Icons.person),
                  backgroundColor: acikKoyu,
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Profil())),
                )),
            Align(
                alignment: Alignment(0, 1.1),
                child: Container(
                    width: 230,
                    height: 260,
                    child: RadialAnimation(controller: controller))),
            Align(
                alignment: Alignment(1, -0.92),
                child: Container(

                    child: TextField(
                  controller: infoController,
                  enabled: false,

                  decoration: null,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: turuncu, fontFamily: "ssRegular",fontSize: 17,fontWeight: FontWeight.bold),
                ))),
            /*  Center(
          child: FloatingActionButton(
            heroTag: null,
            onPressed: ()=> showDialog(
                context: context,
                builder: (BuildContext context) => GameOverDialog(
                    enYuksekPuan: 100,
                    simdikiPuan: 71,
                    uyariYazisi: "Bu sadece bir oyun, önemli olan gerçekten ellerini yıkaman. Gerçekten ellerini yıkadıysan bu kutucuğu işaretle.",
                tekrarOynaMethod: (){print("Tekrar oyna");},)),

          )),*/
          ],
        ),

    );
  }

  @override
  void dispose() {
    controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  puanlariGetir() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    var box = await Hive.openBox("sehirVeriler");
    print("nereyeOynuyor : $nereyeOynuyor");
    setState(() {
      Puan = box.get("PUAN");
      print("Puan : $Puan");
    });
  }
}
