
import 'package:flutter/foundation.dart';

class ScrollEvent with ChangeNotifier {
  bool _isScrolling;
  ScrollEvent(this._isScrolling);

  get isScrolling => _isScrolling;

  set isScrolling(bool status) {
    _isScrolling = status;
    notifyListeners();
  }

}