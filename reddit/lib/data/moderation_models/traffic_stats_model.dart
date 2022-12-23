class TrafficStatsData {
  int? numberOfJoinedLastDay;
  int? numberOfJoinedLastWeek;
  int? numberOfJoinedLastMonth;
  int? numberOfLeftLastDay;
  int? numberOfLeftLastWeek;
  int? numberOfLeftLastMonth;
  List<Days>? days;
  List<Weeks>? weeks;
  List<Months>? months;

  TrafficStatsData(
      {this.numberOfJoinedLastDay,
      this.numberOfJoinedLastWeek,
      this.numberOfJoinedLastMonth,
      this.numberOfLeftLastDay,
      this.numberOfLeftLastWeek,
      this.numberOfLeftLastMonth,
      this.days,
      this.weeks,
      this.months});

  TrafficStatsData.fromJson(Map<String, dynamic> json) {
    numberOfJoinedLastDay = json['numberOfJoinedLastDay'];
    numberOfJoinedLastWeek = json['numberOfJoinedLastWeek'];
    numberOfJoinedLastMonth = json['numberOfJoinedLastMonth'];
    numberOfLeftLastDay = json['numberOfLeftLastDay'];
    numberOfLeftLastWeek = json['numberOfLeftLastWeek'];
    numberOfLeftLastMonth = json['numberOfLeftLastMonth'];
    if (json['days'] != null) {
      days = <Days>[];
      json['days'].forEach((v) {
        days!.add(Days.fromJson(v));
      });
    }
    if (json['weeks'] != null) {
      weeks = <Weeks>[];
      json['weeks'].forEach((v) {
        weeks!.add(Weeks.fromJson(v));
      });
    }
    if (json['months'] != null) {
      months = <Months>[];
      json['months'].forEach((v) {
        months!.add(Months.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['numberOfJoinedLastDay'] = numberOfJoinedLastDay;
    data['numberOfJoinedLastWeek'] = numberOfJoinedLastWeek;
    data['numberOfJoinedLastMonth'] = numberOfJoinedLastMonth;
    data['numberOfLeftLastDay'] = numberOfLeftLastDay;
    data['numberOfLeftLastWeek'] = numberOfLeftLastWeek;
    data['numberOfLeftLastMonth'] = numberOfLeftLastMonth;
    if (days != null) {
      data['days'] = days!.map((v) => v.toJson()).toList();
    }
    if (weeks != null) {
      data['weeks'] = weeks!.map((v) => v.toJson()).toList();
    }
    if (months != null) {
      data['months'] = months!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Days {
  String? day;
  int? numberOfJoined;

  Days({this.day, this.numberOfJoined});

  Days.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    numberOfJoined = json['numberOfJoined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['day'] = day;
    data['numberOfJoined'] = numberOfJoined;
    return data;
  }
}

class Weeks {
  String? day;
  int? numberOfJoined;

  Weeks({this.day, this.numberOfJoined});

  Weeks.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    numberOfJoined = json['numberOfJoined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['day'] = day;
    data['numberOfJoined'] = numberOfJoined;
    return data;
  }
}

class Months {
  String? month;
  int? numberOfJoined;

  Months({this.month, this.numberOfJoined});

  Months.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    numberOfJoined = json['numberOfJoined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['month'] = month;
    data['numberOfJoined'] = numberOfJoined;
    return data;
  }
}
