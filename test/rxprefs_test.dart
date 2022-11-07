// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';

import 'package:rxprefs/rxprefs.dart';

class Prefs {
  static Future<void> init() async {
    return RxPref.init();
  }

  static const boolPref = RxPref("boolPref", false);
}

void main() {
  test('prefs read', () async {
    await Prefs.init();
    Prefs.boolPref.getValueStream().listen((event) {
      print("changed: $event");
    });
    await Prefs.boolPref.setValue(true);
    expect(Prefs.boolPref.getValue(), true);
    await Prefs.boolPref.setValue(false);
    expect(Prefs.boolPref.getValue(), false);
  });
}
