class Job {
  String id;
  String type;
  String origin;
  String destination;
  String orderTime;
  DateTime dateTime;
  int harga;

  Job({this.id,this.type,this.origin,this.destination,this.orderTime,this.harga,this.dateTime});
  factory Job.fromMap(Map<String, dynamic> dataMap) {
    return new Job(
      id:dataMap['trip_id'],
      origin: dataMap['trip_origin'],
      destination: dataMap['trip_destination'],
      harga: dataMap['trip_total'],
      dateTime: dataMap['trip_date']
    );
  }
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["type"] = type;
    map["origin"] = origin;
    map["destination"] = destination;
    map['dateTime'] = dateTime;

    return map;
  }
}