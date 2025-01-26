import 'package:flutter/material.dart';

import '/models/piece_type.dart';

class ConfigGame extends ChangeNotifier {
  bool _areTipsEnabled = false;
  bool get areTipsEnabled => _areTipsEnabled;
  set areTipsEnabled(bool enabled) {
    _areTipsEnabled = enabled;
    notifyListeners();
  }

  bool _soldierCanMoveAside = false;
  bool get soldierCanMoveAside => _soldierCanMoveAside;
  set soldierCanMoveAside(bool enabled) {
    _soldierCanMoveAside = enabled;
    notifyListeners();
  }

  PieceType startPieceType = PieceType.officer;

  int numberOfOfficers = 2;
}
