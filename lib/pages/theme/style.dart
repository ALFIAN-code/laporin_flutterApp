// text Style
import 'dart:ui';

import 'package:flutter/material.dart';

var screenHeight = window.physicalSize.height / window.devicePixelRatio * 0.01;
var screenWidth = window.physicalSize.width / window.devicePixelRatio * 0.002;
double multiplier = 25;

TextStyle regular12_5 = const TextStyle(fontFamily: 'poppins', fontSize: 12.5);
TextStyle medium12_5 = regular12_5.copyWith(fontWeight: FontWeight.w500);
TextStyle bold12_5 = regular12_5.copyWith(fontWeight: FontWeight.w700);

TextStyle regular15 = regular12_5.copyWith(fontSize: 15);
TextStyle medium15 = regular15.copyWith(fontWeight: FontWeight.w500);
TextStyle semiBold15 = regular15.copyWith(fontWeight: FontWeight.w600);

TextStyle regular17 = regular12_5.copyWith(fontSize: 17);
TextStyle medium17 = regular17.copyWith(fontWeight: FontWeight.w500);
TextStyle semiBold17 = regular17.copyWith(fontWeight: FontWeight.w600);
TextStyle bold17 = regular17.copyWith(fontWeight: FontWeight.w700);

TextStyle regular25 = regular12_5.copyWith(fontSize: 25);
TextStyle medium25 = regular25.copyWith(fontWeight: FontWeight.w500);
TextStyle bold25 = regular25.copyWith(fontWeight: FontWeight.w700);

TextStyle bold40 =
    regular12_5.copyWith(fontSize: 40, fontWeight: FontWeight.w700);
