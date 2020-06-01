

import 'yuruyen_insan.dart';
import 'package:flutter/material.dart';

int YURUME_HIZI = 18; // 18 saniyede aşağı varacak
bool YURUSUNMU = true; // true -> yukarı
int INSAN_SAYISI = 1;
void main() => runApp(KalabaliktanKacOyunu());

class KalabaliktanKacOyunu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _KalabaliktanKacOyunu();

}

class _KalabaliktanKacOyunu extends State<KalabaliktanKacOyunu> {

  @override
  Widget build(BuildContext context) {
    /*Timer(Duration(seconds: 5), () {
      print("[*] STATE DEĞİŞTİRİLDİ");

      setState(() {
        YURUSUNMU = !YURUSUNMU;
        INSAN_SAYISI += 1;
        print("[*] INSAN SAYISI = $INSAN_SAYISI");
      });

    });*/
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.grey[100],
          child: Stack(
            children: <Widget>[
              //InsanCokla(INSAN_SAYISI, YURUME_HIZI, YURUSUNMU)
            ],
          )
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              YURUSUNMU = !YURUSUNMU;
            });
          },
          label: Text('Başla'),
          icon: Icon(Icons.play_arrow),
          backgroundColor: Colors.orange,
        ),
      ),
    );

  }
}
