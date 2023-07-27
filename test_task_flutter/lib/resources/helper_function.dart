import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  static Set<String> _seenNews = {};
  static Future<bool> saveSeen(String newsId) async {
    _seenNews.add(newsId);
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setStringList('seenNews', _seenNews.toList());
  }

  static Future<void> getSeen() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    _seenNews = sf.getStringList('seenNews')?.toSet() ?? {};
  }

  static Future<void> clearSp() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.clear();
  }

  static Set<String> getSeenNews() => _seenNews;
}
