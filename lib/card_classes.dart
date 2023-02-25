// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'mutation_cards.dart';
import 'players.dart';
import 'species.dart';
import 'play_screen.dart';
import 'decks.dart';
import 'attack_cards.dart';

List<AttackCardInfo> attackCards = [attackTheNest, attackTheNest];

AttackCardInfo attackTheNest = AttackCardInfo(
    name: 'Attack the Nest',
    description: 'Attack the nest and get a quick meal',
    predatorRequirementsString: 'Must be a carnivore',
    preyRequirementsString: 'Must be a carnivore',
    predatorEffectsString: '+2 population',
    preyEffectsString: '+4 population',
    cost: 3);

class AttackCardInfo {
  final String name;
  final String description;
  final String predatorRequirementsString;
  final String preyRequirementsString;
  final String predatorEffectsString;
  final String preyEffectsString;
  final int cost;
  final Function predatorRequirements;
  final Function preyRequirements;
  final Function predatorEffects;
  final Function preyEffects;

  AttackCardInfo({
    required this.predatorEffectsString,
    required this.preyEffectsString,
    required this.name,
    required this.description,
    required this.cost,
    this.predatorEffects = doNothing,
    this.preyEffects = doNothing,
    this.predatorRequirements = affordable,
    this.preyRequirements = preyAttackTheNest,
    this.predatorRequirementsString = '',
    this.preyRequirementsString = '',
  });
}

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

// ignore: must_be_immutable
class AttackCard extends StatelessWidget {
  final AttackCardInfo info;
  final ValueNotifier<int> selected;
  final ValueNotifier<String> selectedType;
  final ValueNotifier<bool> canPlay;
  final int cardNum;
  AttackCard({
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
            color: (cardNum == selected.value) & (selectedType.value == 'attack')
                ? (info.predatorRequirements.call(playerOne, info) ? Colors.red : Colors.pink)
                : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: InkWell(
              splashColor: Colors.redAccent,
              onTap: () {
                selectedType.value = 'attack';
                selected.value = cardNum;
                canPlay.value = info.predatorRequirements.call(playerOne, info);
              },
              child: SizedBox(
                width: 180,
                height: 300,
                child: Column(
                  children: [
                    Text(info.name),
                    Text(info.description),
                    Text(info.predatorEffectsString),
                    Text(info.preyEffectsString),
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

// ignore: must_be_immutable
class AdaptationCard extends StatelessWidget {
  final AdaptationCardInfo info;
  final ValueNotifier<int> selected;
  final ValueNotifier<String> selectedType;
  final ValueNotifier<bool> canPlay;
  final int cardNum;
  AdaptationCard({
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
