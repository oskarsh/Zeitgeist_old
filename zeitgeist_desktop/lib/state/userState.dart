//
//
// LICENSE: MIT
// AUTHOR: daeh@tuta.io
// TITLE:
// DESCRIPTION: This Class is used as a global state
//
import 'package:flutter/material.dart';
import "../model/background.dart";
import "../model/character.dart";


class UserState with ChangeNotifier {
  Character character;
  Background background;
  int points;
  int time_spent;
}
