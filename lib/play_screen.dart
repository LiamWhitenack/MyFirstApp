// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'species.dart';
import 'card_classes.dart';
import 'decks.dart';

class PlayScreen extends StatefulWidget {
  final Species player;
  late List<int> cardNumList;
  PlayScreen({required this.player, super.key});
  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selected,
      builder: (context, value, child) {
        return GestureDetector(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 38, 162, 42),
              title: const Text('Survival of the Fittest'),
            ),
            body: Column(
              children: [
                Text('Reproduction: ${widget.player.reproduction}'),
                Text('Strength: ${widget.player.strength}'),
                Text('Speed: ${widget.player.speed}'),
                Text('Energy: ${widget.player.energy}'),
                Text('Aggression: ${widget.player.aggression}'),
                Text('Diet: ${widget.player.diet}'),
                Text('Population: ${widget.player.population}'),
                Center(
                  child: SizedBox(
                    height: 300,
                    child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: cardNumsToCards(widget.player.hand)),
                  ),
                ),
                GestureDetector(
                  child: ValueListenableBuilder<bool>(
                      valueListenable: canPlay,
                      builder: (context, value, child) {
                        return TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor:
                                    (selected.value != 999) & canPlay.value ? Colors.green : Colors.lightGreen,
                                foregroundColor: Colors.white // Text Color
                                ),
                            onPressed: () {
                              if ((selected.value == 999) | !canPlay.value) {
                                return;
                              }
                              setState(
                                () {
                                  playCard(
                                    selected.value,
                                    widget.player,
                                  );
                                  widget.player.hand.remove(selected.value);
                                  widget.player.drawCards();
                                  selected.value = 999;
                                },
                              );
                            },
                            child: const Text(
                              'Play',
                              style: TextStyle(fontSize: 25),
                            ));
                      }),
                ),
                Center(child: Text("Energy Remaining: ${widget.player.energyToSpend}")),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CardZoomed extends StatelessWidget {
  final String imgPath;
  const CardZoomed({required this.imgPath, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: const Center(
            child: Text(
              'Survival of the Fittest',
              style: TextStyle(fontSize: 30),
            ),
          ),
          backgroundColor: Colors.green,
        ),
      ),
      body: Image.asset(imgPath),
    );
  }
}
