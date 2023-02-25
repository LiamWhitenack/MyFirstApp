import 'package:flutter/material.dart';
import 'players.dart';
import 'species.dart';
import 'mutation_cards.dart';
// import 'play_screen.dart';
import 'decks.dart';

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
