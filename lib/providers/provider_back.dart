import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CounterProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;

  int get count => _count;

  void increment(int index) {
    _count=index;
    notifyListeners();
  }}