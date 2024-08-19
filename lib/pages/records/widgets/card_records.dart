import 'package:flutter/material.dart';
import 'package:quick_reflex/model/recorde.dart';

class CardRecords extends StatelessWidget {
  final Recorde recorde;
  final bool isTheBest;
  const CardRecords(
      {super.key, required this.recorde, required this.isTheBest});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      color: isTheBest ? Colors.amber : Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    const Text("Jogador"),
                    Text(recorde.playerName),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    const Text("Tempo de reação (sec)"),
                    Text("${recorde.averageTime.toStringAsFixed(3)} segundos"),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    const Text("Acerto (%)"),
                    Text("${recorde.hitPercentage.toStringAsFixed(2)}%"),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Column(
                  children: [
                    const Text("Dificuldade"),
                    Text(recorde.difficulty.name),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    const Text("Velociade"),
                    Text(recorde.velocity.toString()),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
