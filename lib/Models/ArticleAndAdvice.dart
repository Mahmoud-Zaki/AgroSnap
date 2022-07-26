class ArticleAndAdvice{
  String title,img,id;

  ArticleAndAdvice({required this.img,required this.title,required this.id});

  factory ArticleAndAdvice.fromJson(Map<String, dynamic> json,bool arabic) {
    return ArticleAndAdvice(
      id: json["_id"]["\$oid"],
      title: (arabic)?json["arabicTitle"]:json["englishtitle"],
      img: json["image"],
    );
  }
}