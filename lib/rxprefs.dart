library rxprefs;

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RxPref<T> {
  const RxPref(this.key, this._defaultVal);

  static final Map<RxPref, BehaviorSubject> _subjects = {};
  static SharedPreferences? _prefsInstance;

  static Future<void> init() async {
    _prefsInstance ??= await SharedPreferences.getInstance();
  }

  final T _defaultVal;
  final String key;

  T getValue() {
    Object? ret;
    if (this is RxPref<List<String>>) {
      // list needs more complicated processing
      ret = _prefsInstance!.getStringList(key);
    } else {
      ret = _prefsInstance!.get(key);
    }
    return (ret as T?) ?? _defaultVal;
  }

  // lazy init of subjects
  ValueStream<T> getValueStream() {
    final ret = _subjects[this];
    if (ret != null) {
      return ret as BehaviorSubject<T>;
    }
    final newLazy = BehaviorSubject<T>.seeded(getValue());
    _subjects[this] = newLazy;
    return newLazy;
  }

  Future<bool> setValue(T value) async {
    final prefs = await SharedPreferences.getInstance();
    _subjects[this]?.value = value;
    switch (T) {
      case int:
        return prefs.setInt(key, value as int);
      case List<String>:
        return prefs.setStringList(key, value as List<String>);
      case String:
        return prefs.setString(key, value as String);
      case bool:
        return prefs.setBool(key, value as bool);
      case double:
        return prefs.setDouble(key, value as double);
    }
    throw Exception("Unknown setValue type $T");
  }
}
