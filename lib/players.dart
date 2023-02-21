import 'species.dart';
import 'decks.dart';

List<Species> players() {
  List<Species> players = [
    playerOne,
    playerTwo,
    playerThree,
    // playerFour,
    // playerFive,
    // playerSix,
    // playerSeven,
    // playerEight
  ];
  // print(players);
  return players;
}

List<Species> opponents(Species player) {
  List<Species> opponents = players();
  opponents.remove(player);
  return opponents;
}

Species playerOne = Species(
  homoSapiens.elementAt(0),
  homoSapiens.elementAt(1),
  homoSapiens.elementAt(2),
  homoSapiens.elementAt(3),
  homoSapiens.elementAt(4),
  homoSapiens.elementAt(5),
  homoSapiens.elementAt(6),
  homoSapiens.elementAt(7),
  homoSapiens.elementAt(8),
  drawCardNums(homoSapiens.elementAt(0)),
  [],
);
Species playerTwo = Species(
  homoSapiens.elementAt(0),
  homoSapiens.elementAt(1),
  homoSapiens.elementAt(2),
  homoSapiens.elementAt(3),
  homoSapiens.elementAt(4),
  homoSapiens.elementAt(5),
  homoSapiens.elementAt(6),
  homoSapiens.elementAt(7),
  homoSapiens.elementAt(8),
  drawCardNums(homoSapiens.elementAt(0)),
  [],
);
Species playerThree = Species(
  homoSapiens.elementAt(0),
  homoSapiens.elementAt(1),
  homoSapiens.elementAt(2),
  homoSapiens.elementAt(3),
  homoSapiens.elementAt(4),
  homoSapiens.elementAt(5),
  homoSapiens.elementAt(6),
  homoSapiens.elementAt(7),
  homoSapiens.elementAt(8),
  drawCardNums(homoSapiens.elementAt(0)),
  [],
);
Species playerFour = Species(
  homoSapiens.elementAt(0),
  homoSapiens.elementAt(1),
  homoSapiens.elementAt(2),
  homoSapiens.elementAt(3),
  homoSapiens.elementAt(4),
  homoSapiens.elementAt(5),
  homoSapiens.elementAt(6),
  homoSapiens.elementAt(7),
  homoSapiens.elementAt(8),
  drawCardNums(homoSapiens.elementAt(0)),
  [],
);
Species playerFive = Species(
  homoSapiens.elementAt(0),
  homoSapiens.elementAt(1),
  homoSapiens.elementAt(2),
  homoSapiens.elementAt(3),
  homoSapiens.elementAt(4),
  homoSapiens.elementAt(5),
  homoSapiens.elementAt(6),
  homoSapiens.elementAt(7),
  homoSapiens.elementAt(8),
  drawCardNums(homoSapiens.elementAt(0)),
  [],
);
Species playerSix = Species(
  homoSapiens.elementAt(0),
  homoSapiens.elementAt(1),
  homoSapiens.elementAt(2),
  homoSapiens.elementAt(3),
  homoSapiens.elementAt(4),
  homoSapiens.elementAt(5),
  homoSapiens.elementAt(6),
  homoSapiens.elementAt(7),
  homoSapiens.elementAt(8),
  drawCardNums(homoSapiens.elementAt(0)),
  [],
);
Species playerSeven = Species(
  homoSapiens.elementAt(0),
  homoSapiens.elementAt(1),
  homoSapiens.elementAt(2),
  homoSapiens.elementAt(3),
  homoSapiens.elementAt(4),
  homoSapiens.elementAt(5),
  homoSapiens.elementAt(6),
  homoSapiens.elementAt(7),
  homoSapiens.elementAt(8),
  drawCardNums(homoSapiens.elementAt(0)),
  [],
);
Species playerEight = Species(
  homoSapiens.elementAt(0),
  homoSapiens.elementAt(1),
  homoSapiens.elementAt(2),
  homoSapiens.elementAt(3),
  homoSapiens.elementAt(4),
  homoSapiens.elementAt(5),
  homoSapiens.elementAt(6),
  homoSapiens.elementAt(7),
  homoSapiens.elementAt(8),
  drawCardNums(homoSapiens.elementAt(0)),
  [],
);
