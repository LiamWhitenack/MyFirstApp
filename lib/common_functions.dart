import 'species.dart';

bool alwaysTrue(Species player) {
  // use when there are no requirements
  return true;
}

void doNothing(Species player) {
  return;
}

bool affordable(Species player, info) {
  return player.energyToSpend >= info.cost;
}
