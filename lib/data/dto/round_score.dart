class RoundScore {
  final String roundId;
  final String playerId;
  final int score;
  final int scoreUpdate;

  RoundScore(
      {required this.roundId,
      required this.playerId,
      required this.score,
      required this.scoreUpdate});
}
