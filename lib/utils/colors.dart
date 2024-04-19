import 'dart:ui';
import 'package:flutter/material.dart';

Color _getStatusColor(String status) {
  switch (status) {
    case 'safe':
      return Color.fromARGB(255, 51, 160, 104);
    case 'potential':
      return Color.fromARGB(255, 255, 215, 0);
    case 'at_risk':
      return Color.fromARGB(255, 238, 75, 43);
    case 'InAlarm':
      return Color.fromARGB(255, 255, 155, 155);
    case 'InVote':
      return Color.fromARGB(255, 255, 214, 165);
    case 'InAction':
      return Color.fromARGB(255, 255, 254, 196);
    case 'InFinish':
      return Color.fromARGB(255, 203, 255, 169);
    default:
      return Colors.grey;
  }
}
