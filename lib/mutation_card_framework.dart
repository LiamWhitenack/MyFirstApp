import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfirstapp/attack_card_framework.dart';
import 'package:myfirstapp/players.dart';
import 'attack_cards.dart';

import 'common_functions.dart';
import 'play_screen.dart';
import 'species.dart';

List<MutationCardInfo> mutationCards = [multipleStomachs, multipleStomachs];

MutationCardInfo multipleStomachs = MutationCardInfo(
    name: 'Multiple Stomachs',
    description: 'Now that you can safely consume practically anything, you will never go hungry',
    requirementsString: 'Strength > 4, Terrain must be plains',
    effectsString: 'Start every turn with 3 energy',
    cost: 3);

class MutationCardInfo {
  final String name;
  final String description;
  final String requirementsString;
  final String effectsString;
  final int cost;
  final Function requirements;
  final Function beforePreyEffects;
  final Function afterPreyEffects;
  final Function startOfTurnEffects;
  final Function endOfTurnEffects;
  final Function endOfRoundEffects;

  MutationCardInfo({
    required this.name,
    required this.description,
    required this.requirementsString,
    required this.effectsString,
    required this.cost,
    this.requirements = affordable,
    this.beforePreyEffects = doNothing,
    this.afterPreyEffects = doNothing,
    this.startOfTurnEffects = doNothing,
    this.endOfTurnEffects = doNothing,
    this.endOfRoundEffects = doNothing,
  });
}

class MutationScreen extends StatelessWidget {
  const MutationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: ValueListenableBuilder<int>(
            valueListenable: selected,
            builder: (context, value, child) {
              return Column(
                children: mutationCardWidgets(mutationCards, selected),
              );
            }),
      ),
    );
  }
}

List<Widget> mutationCardWidgets(List<MutationCardInfo> mutationCards, ValueNotifier selected) {
  List<Widget> output = [];
  for (var i = 0; i < mutationCards.length; i++) {
    output.add(MutationCard(
      info: mutationCards.elementAt(i),
      selected: selected,
      cardNum: i,
      player: playerOne,
    ));
  }
  return output;
}

class MutationCard extends StatelessWidget {
  final MutationCardInfo info;
  final ValueNotifier selected;
  final Species player;
  final int cardNum;
  const MutationCard({
    super.key,
    required this.info,
    required this.selected,
    required this.player,
    required this.cardNum,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        splashColor: Colors.greenAccent,
        onTap: () {
          if (info.requirements.call(player, info)) selected.value = cardNum;
        },
        child: Container(
          color: info.requirements.call(player, info)
              ? selected.value == cardNum
                  ? Colors.blue
                  : Colors.green
              : Colors.lightGreen,
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
    );
  }
}
