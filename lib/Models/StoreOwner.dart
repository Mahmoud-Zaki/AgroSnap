class StoreOwner{
  String? name,img,faceLink,anotherLink,id,phoneNumber;
  double? lat,long;

  StoreOwner({this.id,this.img,this.name, this.faceLink,
    this.anotherLink,this.lat,this.long,this.phoneNumber});

  factory StoreOwner.fromJson(Map<String, dynamic> json,bool all) {
    if(all){
      return StoreOwner(
        id: json["_id"]["\$oid"],
        name: json["storeName"],
        phoneNumber: json["contacts"]["phone_number"]??"",
        faceLink: json["contacts"]["facebook_link"]??"",
        anotherLink: json["contacts"]["another_link"]??"",
        lat: json["lat"]??0.0,
        long: json["long"]??0.0,
        img: json["image"]??"",
      );
    } else {
      return StoreOwner(
        id: json["_id"]["\$oid"],
        name: json["storeName"],
        img: json["image"]??"",
      );
    }
  }
}