class HisDetails {
  final String airlines, date, discount, rating;
  final int oldPrice, newPrice,tripTotal;

  HisDetails({this.airlines,this.date,this.discount,this.oldPrice,this.newPrice,this.tripTotal,this.rating});

  factory HisDetails.fromJson(Map<String, dynamic> map) {
    return HisDetails(
        airlines : map['airlines'],
        date : map['trip_date'],
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