
import 'package:corona_oyun/ana_sayfa/sayfalar/kendim/hasta.dart';
import 'package:corona_oyun/ana_sayfa/sayfalar/kendim/saglikli.dart';
import 'package:corona_oyun/ana_sayfa/sayfalar/ulkem.dart';
import 'package:flutter/material.dart';

import '../global.dart';
import 'sayfalar/sehrim.dart';

Widget Kendim(){

  bool puaniYuksekMi = true;

  if(Puan > 100)
    {
      return SaglikliPage();
    }
  else
    {
      return HastaPage();
    }


}

Widget Sehrim(){
  return SehrimPage();
}

Widget Ulkem(){
  return UlkemPage();
}