class HisDetails {
  final String airlines, date, discount, rating,origin,destionation;
  final int oldPrice, newPrice,tripTotal;

  HisDetails({this.airlines,this.date,this.discount,this.oldPrice,this.newPrice,this.tripTotal,this.rating,this.origin,this.destionation});

  factory HisDetails.fromJson(Map<String, dynamic> map) {
    return HisDetails(
        airlines : map['airlines'],
        date : map['trip_date'],
        origin : map['trip_address_origin'],
        destionation : map['trip_address_destination'],
        discount : map['discount'],
        oldPrice : map['oldPrice'],
        newPrice : map['newPrice'],
        tripTotal : map["trip_total"],
        rating : map['rating']
    );
  }

  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["airlines"] = airlines;
    map["date"] = date;
    map["tripTotal"] = tripTotal;

    return map;
  }
}