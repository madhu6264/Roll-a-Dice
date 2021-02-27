class LeaderboardModel {
  String userID;
  String fullName;
  bool isGameCompleted;

  int availableChances;
  int totalScore;

  LeaderboardModel(
      {this.userID,
      this.fullName,
      this.isGameCompleted,
      this.availableChances,
      this.totalScore});

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'fullName': fullName,
      'isGameCompleted': isGameCompleted,
      'availableChances': availableChances,
      "totalScore": totalScore
    };
  }

  factory LeaderboardModel.fromJson(Map<String, dynamic> map) {
    return LeaderboardModel(
      userID: map['userID'],
      fullName: map['fullName'],
      isGameCompleted: map['isGameCompleted'] ?? false,
      availableChances: map['availableChances'] ?? 10,
      totalScore: map['totalScore'] ?? 0,
    );
  }
}
