import 'dart:typed_data';

import 'package:flutter/services.dart';

class Values {
  static const String backgroundImagePath = 'assets/images/default.jpg';

  static Future<Uint8List> get backgroundImage async {
    final ByteData data = await rootBundle.load(backgroundImagePath);
    return data.buffer.asUint8List();
  }
}
