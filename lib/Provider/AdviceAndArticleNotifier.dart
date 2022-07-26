import 'package:agrosnap/Models/ArticleAndAdvice.dart';
import 'package:agrosnap/Services/API.dart';
import 'package:flutter/foundation.dart';

class AdviceAndArticleNotifier extends ChangeNotifier {
  List<ArticleAndAdvice> articles = [];
  List<ArticleAndAdvice> advices = [];
  String content = "";

  void getAllArticles({required bool arabic}) async{
    final response = await API.getAllArticlesOrAdvice(arabic: arabic, articles: true);
    if(response != false && response != null)
      articles = response;
    notifyListeners();
  }

  void getAllAdvice({required bool arabic}) async{
    final response = await API.getAllArticlesOrAdvice(arabic: arabic, articles: false);
    if(response != false && response != null)
      advices = response;
    notifyListeners();
  }

  void emptyContent(){content="";}

  void getAdviceOrArticleContent({required bool arabic,required bool advice,required String id}) async{
    final response = await API.getArticlesOrAdviceContent(arabic: arabic, advice: advice, id: id);
    if(response!=null)
      content = response;
    notifyListeners();
  }
}