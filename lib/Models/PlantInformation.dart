class PlantInfo{
  String? name,img,id;

  PlantInfo({this.id,this.img,this.name});

  factory PlantInfo.fromJson(Map<String, dynamic> json) {
      return PlantInfo(
        id: json["_id"]["\$oid"],
        name: json["الاسم"]??"",
        img: json["الصورة"]??"",
      );
  }
}