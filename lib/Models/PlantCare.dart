class PlantCare {
  int? id;
  String? name, img, waterizationDate, waterizationTime, fertilizationDate, fertilizationTime,
      harvestDate, harvestTime, otherName, otherDate, otherTime, waterizationDate2, waterizationTime2,
      fertilizationDate2, fertilizationTime2, harvestDate2, harvestTime2, otherDate2, otherTime2,
      waterizationRepeat,waterizationRepeat2,fertilizationRepeat,fertilizationRepeat2,harvestRepeat,
      harvestRepeat2,otherRepeat,otherRepeat2;

  PlantCare({required this.name,this.img,this.fertilizationDate,this.fertilizationTime,
    this.harvestDate,this.harvestTime,this.waterizationDate,this.waterizationTime,
    this.otherDate,this.otherName,this.otherTime,this.fertilizationDate2,this.fertilizationTime2,
    this.harvestDate2,this.harvestTime2,this.waterizationDate2,this.waterizationTime2,
    this.otherDate2,this.otherTime2,this.waterizationRepeat,this.waterizationRepeat2,
    this.fertilizationRepeat,this.fertilizationRepeat2,this.harvestRepeat,this.harvestRepeat2,
    this.otherRepeat,this.otherRepeat2});

  PlantCare.map(dynamic obj){
    this.id = obj['id'];
    this.name = obj['name'];
    this.img = obj['img'];
    this.waterizationDate = obj['waterizationDate'];
    this.waterizationTime = obj['waterizationTime'];
    this.fertilizationDate = obj['fertilizationDate'];
    this.fertilizationTime = obj['fertilizationTime'];
    this.harvestDate = obj['harvestDate'];
    this.harvestTime = obj['harvestTime'];
    this.otherName = obj['otherName'];
    this.otherDate = obj['otherDate'];
    this.otherTime = obj['otherTime'];
    this.waterizationDate2 = obj['waterizationDate2'];
    this.waterizationTime2 = obj['waterizationTime2'];
    this.fertilizationDate2 = obj['fertilizationDate2'];
    this.fertilizationTime2 = obj['fertilizationTime2'];
    this.harvestDate2 = obj['harvestDate2'];
    this.harvestTime2 = obj['harvestTime2'];
    this.otherDate2 = obj['otherDate2'];
    this.otherTime2 = obj['otherTime2'];
    this.waterizationRepeat = obj['waterizationRepeat'];
    this.waterizationRepeat2 = obj['waterizationRepeat2'];
    this.fertilizationRepeat = obj['fertilizationRepeat'];
    this.fertilizationRepeat2 = obj['fertilizationRepeat2'];
    this.harvestRepeat = obj['harvestRepeat'];
    this.harvestRepeat2 = obj['harvestRepeat2'];
    this.otherRepeat = obj['otherRepeat'];
    this.otherRepeat2 = obj['otherRepeat2'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if(id!=null) {
      map['id'] = id;
    }
    map['name']=name;
    map['waterizationDate']=waterizationDate;
    map['waterizationTime']=waterizationTime;
    map['fertilizationDate']=fertilizationDate;
    map['fertilizationTime']=fertilizationTime;
    map['harvestDate']=harvestDate;
    map['harvestTime']=harvestTime;
    map['otherName']=otherName;
    map['otherDate']=otherDate;
    map['otherTime']=otherTime;
    map['waterizationDate2']=waterizationDate2;
    map['waterizationTime2']=waterizationTime2;
    map['fertilizationDate2']=fertilizationDate2;
    map['fertilizationTime2']=fertilizationTime2;
    map['harvestDate2']=harvestDate2;
    map['harvestTime2']=harvestTime2;
    map['otherDate2']=otherDate2;
    map['otherTime2']=otherTime2;
    map['waterizationRepeat']=waterizationRepeat;
    map['waterizationRepeat2']=waterizationRepeat2;
    map['fertilizationRepeat']=fertilizationRepeat;
    map['fertilizationRepeat2']=fertilizationRepeat2;
    map['harvestRepeat']=harvestRepeat;
    map['harvestRepeat2']=harvestRepeat2;
    map['otherRepeat']=otherRepeat;
    map['otherRepeat2']=otherRepeat2;
    return map;
  }

  PlantCare.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.waterizationDate = map['waterizationDate'];
    this.waterizationTime = map['waterizationTime'];
    this.fertilizationDate = map['fertilizationDate'];
    this.fertilizationTime = map['fertilizationTime'];
    this.harvestDate = map['harvestDate'];
    this.harvestTime = map['harvestTime'];
    this.otherName = map['otherName'];
    this.otherDate = map['otherDate'];
    this.otherTime = map['otherTime'];
    this.waterizationDate2 = map['waterizationDate2'];
    this.waterizationTime2 = map['waterizationTime2'];
    this.fertilizationDate2 = map['fertilizationDate2'];
    this.fertilizationTime2 = map['fertilizationTime2'];
    this.harvestDate2 = map['harvestDate2'];
    this.harvestTime2 = map['harvestTime2'];
    this.otherDate2 = map['otherDate2'];
    this.otherTime2 = map['otherTime2'];
    this.waterizationRepeat = map['waterizationRepeat'];
    this.waterizationRepeat2 = map['waterizationRepeat2'];
    this.fertilizationRepeat = map['fertilizationRepeat'];
    this.fertilizationRepeat2 = map['fertilizationRepeat2'];
    this.harvestRepeat = map['harvestRepeat'];
    this.harvestRepeat2 = map['harvestRepeat2'];
    this.otherRepeat = map['otherRepeat'];
    this.otherRepeat2 = map['otherRepeat2'];
  }
}