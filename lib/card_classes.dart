// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'players.dart';
import 'species.dart';
import 'play_screen.dart';
import 'decks.dart';
import 'attack_cards.dart';

void playLongLegs(Species player) {
  player.increaseAggression(1);
  player.increaseSpeed(1);
  player.increaseEnergyToSpend(-1);
}

void playSharpTeeth(Species player) {
  player.increaseAggression(1);
  player.increaseStrength(1);
  player.increaseEnergyToSpend(-1);
}

class EvolutionCard extends StatefulWidget {
  final String imgPath;
  final ValueNotifier<int> valueNotifier;
  final ValueNotifier<bool> canPlay;
  final int cardNum;
  const EvolutionCard({
    super.key,
    required this.imgPath,
    required this.valueNotifier,
    required this.canPlay,
    required this.cardNum,
  });

  @override
  State<EvolutionCard> createState() => _EvolutionCardState();
}

class _EvolutionCardState extends State<EvolutionCard> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: widget.valueNotifier,
        builder: (context, value, child) {
          return GestureDetector(
            child: Card(
              clipBehavior: Clip.antiAlias,
              color: widget.cardNum == widget.valueNotifier.value
                  ? (canPlay.value ? Colors.green : Colors.lightGreen)
                  : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: InkWell(
                splashColor: Colors.greenAccent,
                onTap: () {
                  widget.valueNotifier.value = widget.cardNum;
                  bool temp = true;
                  if (cardTypes[intToCardName[widget.valueNotifier.value]] == 'attack') {
                    temp = predatorConditions[intToCardName[widget.valueNotifier.value]]
                        ?.call(playerOne); // check to make sure that it can be played if it's an attack card
                  }
                  canPlay.value =
                      (cardCosts[intToCardName[(widget.valueNotifier.value)]]! <= playerOne.energyToSpend) & temp;
                },
                onDoubleTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CardZoomed(
                        imgPath: widget.imgPath,
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  width: 180,
                  height: 300,
                  child: Column(
                    children: <Widget>[
                      Image(
                        image: AssetImage(widget.imgPath),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
