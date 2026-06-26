import 'dart:convert';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:daisy_chain/models/search_models.dart';

class RecentSearchesNotifier extends StateNotifier<List<Station>> {
  RecentSearchesNotifier() : super([]);

  static const _prefsKey = 'recent_searches';

  Future<void> loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw == null) {
      return;
    }

    try {
      final list = json.decode(raw) as List;
      state = list.map((e) => Station.fromJson(e as Map<String,dynamic>),).toList();
    } catch (e) {
      state = state;
    }
  }

  Future<void> addEntry(Station station) async {
    final updated = [station, ...state].take(5).toList();
    state = updated;
    await _save();
  }

  Future<void> clearAll() async {
    state = [];
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKey);
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = json.encode(state.map((e) => e.toJson(),).toList());
    await prefs.setString(_prefsKey, raw);
  }
}

final recentSearchesProvider = StateNotifierProvider<RecentSearchesNotifier,List<Station>>((ref) => RecentSearchesNotifier(),);