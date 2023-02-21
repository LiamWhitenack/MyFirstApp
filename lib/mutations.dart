import 'package:flutter/material.dart';
import 'players.dart';
import 'play_screen.dart';
import 'decks.dart';

class MutationCard extends StatefulWidget {
  final String imgPath;
  final ValueNotifier<int> valueNotifier;
  final ValueNotifier<bool> canPlay;
  final int cardnum;
  const MutationCard({
    super.key,
    required this.imgPath,
    required this.valueNotifier,
    required this.canPlay,
    required this.cardnum,
  });

  @override
  State<MutationCard> createState() => _MutationCardState();
}

class _MutationCardState extends State<MutationCard> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: widget.valueNotifier,
      builder: (context, value, child) {
        return GestureDetector(
          child: InkWell(
            splashColor: Colors.blueAccent,
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
                  ? (canPlay.value ? Colors.blue : Colors.lightBlue)
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
