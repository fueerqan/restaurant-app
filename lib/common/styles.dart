import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData get getThemeData => ThemeData(
      primarySwatch: Colors.orange,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

CupertinoThemeData get getCupertinoThemeData => const CupertinoThemeData(
      primaryColor: Colors.orange,
    );
