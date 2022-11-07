<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Wrapper around shared_preferences to support reading of preferences as a ValueStream, and synchronous value setting.

## Usage

Initialize with RxPrefs.init() before use


```dart
static const boolPref = RxPref("boolPref", false);

boolPref.getValueStream().listen((event) {
  print("pref changed: $event");
});
print("initial value: ${boolPref.getValue()}");
myBoolPref.setValue(!boolPref.getValue());

```