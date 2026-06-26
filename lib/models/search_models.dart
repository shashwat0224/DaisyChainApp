class DirectResult {
  final String trainNo;
  final String trainName;
  final String sourceStation;
  final String destStation;
  final String arrivalTime;
  final int arrivalDay;
  final String departureTime;
  final int departureDay;
  final int journeyMinutes;
  final String journeyDuration;
  final int stopsInBetween;
  final String classes;
  final String serviceDays;

  const DirectResult({
    required this.trainNo,
    required this.trainName,
    required this.sourceStation,
    required this.destStation,
    required this.arrivalTime,
    required this.arrivalDay,
    required this.departureTime,
    required this.departureDay,
    required this.journeyMinutes,
    required this.journeyDuration,
    required this.stopsInBetween,
    required this.classes,
    required this.serviceDays,
  });

  factory DirectResult.fromJson(Map<String, dynamic> j) => DirectResult(
    trainNo: j['train_no'],
    trainName: j['train_name'],
    sourceStation: j['source_station'],
    destStation: j['dest_station'],
    arrivalTime: j['arrival_time'],
    arrivalDay: j['arrival_day'],
    departureTime: j['departure_time'],
    departureDay: j['departure_day'],
    journeyMinutes: j['journey_minutes'],
    journeyDuration: j['journey_duration'],
    stopsInBetween: j['stops_in_between'],
    classes: j['classes'] ?? '',
    serviceDays: j['serviceDays'] ?? '',
  );
}

class TransferInfo {
  final String stationCode;
  final String stationName;
  final bool isMajor;
  final String waitMinutes;
  final String arriveTime;
  final int arriveDay;
  final String departTime;
  final int departDay;

  const TransferInfo({
    required this.stationCode,
    required this.stationName,
    required this.isMajor,
    required this.waitMinutes,
    required this.arriveTime,
    required this.arriveDay,
    required this.departTime,
    required this.departDay,
  });

  factory TransferInfo.fromJson(Map<String, dynamic> j) => TransferInfo(
    stationCode: j['station_code'],
    stationName: j['station_name'],
    isMajor: j['is_major'] ?? false,
    waitMinutes: j['wait_minutes'],
    arriveTime: j['arrive_time'],
    arriveDay: j['arrive_day'],
    departTime: j['depart_time'],
    departDay: j['depart_day'],
  );
}

class IndirectResult {
  final DirectResult leg1;
  final DirectResult leg2;
  final TransferInfo transfer;
  final int totalMinute;
  final String totalDuration;

  const IndirectResult({
    required this.leg1,
    required this.leg2,
    required this.transfer,
    required this.totalMinute,
    required this.totalDuration,
  });

  factory IndirectResult.fromJson(Map<String, dynamic> j) => IndirectResult(
    leg1: DirectResult.fromJson(j['leg1']),
    leg2: DirectResult.fromJson(j['leg2']),
    transfer: TransferInfo.fromJson(j['transfer']),
    totalMinute: j['total_minutes'],
    totalDuration: j['total_duration'],
  );
}

class Station {
  final String code;
  final String name;
  final bool isMajor;

  const Station({
    required this.code,
    required this.name,
    required this.isMajor,
  });

  factory Station.fromJson(Map<String, dynamic> j) => Station(
    code: j['station_code'],
    name: j['station_name'],
    isMajor: j['is_major_junction'] ?? false,
  );

  Map<String,dynamic> toJson() {
    return {
      'station_code': code,
      'station_name': name,
      'is_major_junction': isMajor,
    };
}
}
