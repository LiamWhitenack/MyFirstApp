// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'adaptation_cards.dart';
import 'attack_cards.dart';
import 'common_functions.dart';
import 'mutation_card_framework.dart';
import 'players.dart';
import 'species.dart';
import 'play_screen.dart';
import 'attack_card_framework.dart';

class AdaptationCardInfo {
  final String name;
  final String description;
  final String requirementsString;
  final String effectsString;
  final int cost;
  final Function requirements;
  final Function effects;

  AdaptationCardInfo({
    required this.effectsString,
    required this.name,
    required this.description,
    required this.requirementsString,
    required this.cost,
    this.requirements = affordable,
    this.effects = doNothing,
  });
}

// ignore: must_be_immutable
class AdaptationCard extends StatelessWidget {
  final AdaptationCardInfo info;
  final ValueNotifier<int> selected;
  final ValueNotifier<String> selectedType;
  final ValueNotifier<bool> canPlay;
  final int cardNum;
  const AdaptationCard({
    super.key,
    required this.info,
    required this.selected,
    required this.selectedType,
    required this.canPlay,
    required this.cardNum,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selected,
      builder: (context, value, child) {
        return GestureDetector(
          child: Card(
            clipBehavior: Clip.antiAlias,
            color: (cardNum == selected.value) & (selectedType.value == 'adaptation')
                ? (info.requirements.call(playerOne, info) ? Colors.green : Colors.lightGreen)
                : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: InkWell(
              splashColor: Colors.greenAccent,
              onTap: () {
                selectedType.value = 'adaptation';
                selected.value = cardNum;
                canPlay.value = info.requirements.call(playerOne, info);
              },
              child: SizedBox(
                width: 180,
                height: 300,
                child: Column(
                  children: [
                    Text(info.name),
                    Text(info.description),
                    Text(info.effectsString),
                    Text(info.cost.toString()),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

List<AdaptationCardInfo> drawAdaptationCards(int numCards) {
  adaptationCards.shuffle();
  if (adaptationCards.length < numCards) {
    adaptationCardsDiscard.shuffle();
    adaptationCards.addAll(adaptationCardsDiscard);
    adaptationCardsDiscard = [];
  }
  List<AdaptationCardInfo> drawn = [];
  for (var i = 0; i < numCards; i++) {
    drawn.add(adaptationCards.first);
    adaptationCards.remove(adaptationCards.first);
  }
  return drawn;
}
