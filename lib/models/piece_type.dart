import 'package:flutter/material.dart';

enum PieceType {
  officer,
  soldier;

  bool get isOfficer => this == officer;
  bool get isSoldier => this == soldier;

  IconData get icon => switch (this) {
        officer => Icons.shield_outlined,
        soldier => Icons.close_outlined,
      };
}
