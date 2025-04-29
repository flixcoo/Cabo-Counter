/// This class represents a single round in the game.
/// It is stored within the [GameSession] class.
/// [roundNum] is the number of the round its reppresenting.
/// [scores] is a list of the actual scores the players got.
/// [scoreUpdates] is a list of how the players scores updated this round.
/// [kamikazePlayerIndex] is the index of the player who got kamikaze. If no one got
/// kamikaze, this value is null.
class Round {
  final int roundNum;
  final List<int> scores;
  final List<int> scoreUpdates;
  final int? kamikazePlayerIndex;

  Round(
      {required this.roundNum,
      required this.scores,
      required this.scoreUpdates,
      this.kamikazePlayerIndex});
}
