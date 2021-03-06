class Job {
  int id;
  String customer;
  String type;
  String origin;
  String destination;
  DateTime orderTime;
  DateTime dateTime;
  double oriLat;
  double oriLng;
  double desLat;
  double desLng;
  int harga;
  int distance;
  int status;

  Job({this.id,this.customer,this.type,this.origin,this.destination,this.orderTime,this.harga,this.dateTime,this.oriLat,this.oriLng,this.desLat,this.desLng,this.distance,this.status});
  factory Job.fromMap(Map<String, dynamic> dataMap) {
    return new Job(
      id:dataMap['trip_id'],
      origin: dataMap['trip_address_origin'],
      destination: dataMap['trip_address_destination'],
      harga: dataMap['trip_total'],
      dateTime: DateTime.parse(dataMap['trip_date']),
      distance: dataMap['distance'],
      customer: dataMap['trip_customer'],
      status: dataMap['trip_status']
    );
  }
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["type"] = type;
    map["origin"] = origin;
    map["destination"] = destination;
    map['dateTime'] = dateTime;
    map['harga'] = harga;
    map['oriLat'] = oriLat;
    map['oriLng'] = oriLng;
    map['desLat'] = desLat;
    map['desLng'] = desLng;

    return map;
  }
}