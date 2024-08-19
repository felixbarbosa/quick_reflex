import 'package:quick_reflex/enum/dificuldade.dart';

class Recorde {
  int? id;
  String playerName;
  double hitPercentage;
  double averageTime;
  int velocity;
  Dificuldade difficulty;

  Recorde({
    this.id,
    required this.playerName,
    required this.difficulty,
    required this.hitPercentage,
    required this.velocity,
    required this.averageTime,
  });
}
