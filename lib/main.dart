import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'newCommande.dart';
import 'prodDetail.dart';
import 'updateProd.dart';
import 'venteDetail.dart';
import 'venteManagement.dart';

void main() async {
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  }
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: venteManagement(),
    routes: {
      'VenteManagement': (context) => venteManagement(),
      'newCommande': (context) => newCommande(),
      'prodDetail': (context) => prodDetail(),
      'VenteDetail': (context) => venteDetail(),
      'updateProd': (context) => updateProd(),
    },
  ));
}
