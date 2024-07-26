import 'package:quick_reflex/enum/dificuldade.dart';

class QuickReflex {
  String nomeJogador;
  Dificuldade dificuldade;
  int velocidade;

  QuickReflex(
      {required this.nomeJogador,
      required this.dificuldade,
      required this.velocidade});
}
