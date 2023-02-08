import 'package:flutter/material.dart';
import 'players.dart';
import 'species.dart';
import 'play_screen.dart';
import 'decks.dart';

void playCard(int cardnum, Species player) {
  if (cardnum == 0) {
    playLongLegs(player);
  }
  if (cardnum == 1) {
    playSharpTeeth(player);
  }
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

class AdaptationCard extends StatefulWidget {
  final String imgPath;
  final ValueNotifier<int> valueNotifier;
  final ValueNotifier<bool> canPlay;
  final int cardnum;
  const AdaptationCard({
    super.key,
    required this.imgPath,
    required this.valueNotifier,
    required this.canPlay,
    required this.cardnum,
  });

  @override
  State<AdaptationCard> createState() => _AdaptationCardState();
}

class _AdaptationCardState extends State<AdaptationCard> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: widget.valueNotifier,
      builder: (context, value, child) {
        return GestureDetector(
          child: InkWell(
            splashColor: Colors.greenAccent,
            onTap: () {
              widget.valueNotifier.value = widget.cardnum;
              canPlay.value = cardCosts[intToCardName[(widget.valueNotifier.value)]]! <= playerOne.energyToSpend;
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
            child: Card(
              color: widget.cardnum == widget.valueNotifier.value
                  ? (canPlay.value ? Colors.green : Colors.lightGreen)
                  : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
      }, // builder
    );
  }
}
