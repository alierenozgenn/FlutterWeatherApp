import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentSearchesProvider with ChangeNotifier {
  List<String> _recentSearches = [];
  static const _key = 'recent_searches';

  List<String> get recentSearches => _recentSearches;

  RecentSearchesProvider() {
    _loadRecentSearches();
  }

  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    _recentSearches = prefs.getStringList(_key) ?? [];
    notifyListeners();
  }

  Future<void> addSearch(String city) async {
    final prefs = await SharedPreferences.getInstance();

    // Remove duplicates and keep only last 5 unique searches
    if (_recentSearches.contains(city)) {
      _recentSearches.remove(city);
    }
    _recentSearches.insert(0, city);

    if (_recentSearches.length > 5) {
      _recentSearches = _recentSearches.sublist(0, 5);
    }

    await prefs.setStringList(_key, _recentSearches);
    notifyListeners();
  }
}
