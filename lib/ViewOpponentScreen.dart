import 'dart:async';
import 'attack_card_framework.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'players.dart';
import 'species.dart';
import 'play_screen.dart';

class ViewOpponentScreen extends StatelessWidget {
  final Species player;
  final ValueNotifier<int> selected = ValueNotifier(999);

  ViewOpponentScreen({required this.player, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder<int>(
          valueListenable: selected,
          builder: (context, value, child) {
            return Column(
              children: [
                Column(
                  children: opponentCards(player, selected),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
