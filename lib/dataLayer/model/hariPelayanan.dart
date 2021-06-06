import 'package:flutter/material.dart';

class HariPelayanan {
  bool status;
  String kodeHari;
  String hari;
  TextEditingController jamBukaBookingInput = TextEditingController();
  TextEditingController jamTutupBookingInput = TextEditingController();

  HariPelayanan({this.status, this.kodeHari, this.hari});
}