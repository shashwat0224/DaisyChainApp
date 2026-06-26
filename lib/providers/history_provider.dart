import 'dart:convert';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:daisy_chain/providers/search_provider.dart';

class HistoryEntry {
  final String source;
  final String destination;
  final String date;
  final DateTime timeStamp;

  HistoryEntry({
    required this.source,
    required this.destination,
    required this.date,
    required this.timeStamp,
  });

  factory HistoryEntry.fromJson(Map<String, dynamic> j) {
    return HistoryEntry(
      source: j['source'],
      destination: j['destination'],
      date: j['date'],
      timeStamp: DateTime.parse(j['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source': source,
      'destination': destination,
      'date': date,
      'timestamp': timeStamp.toIso8601String(),
    };
  }
}

class HistoryNotifier extends StateNotifier<List<HistoryEntry>> {
  static const _prefsKey = 'search_history';

  HistoryNotifier() : super([]);

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw == null) return;

    try {
      final list = json.decode(raw) as List;
      state = list
          .map((e) => HistoryEntry.fromJson(e as Map<String, dynamic>),)
          .toList();
    } catch (_) {
      state = [];
    }
  }

  Future<void> addEntry(SearchParams params) async {
    final entry = HistoryEntry(source: params.source,
        destination: params.destination,
        date: params.date,
        timeStamp: DateTime.now());

    final updated = [entry, ...state].take(10).toList();

    state = updated;
    await _save();
  }

  Future<void> removeEntry(int index) async {
    final updated = [...state]..removeAt(index);
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
    final raw = jsonEncode(state.map((e) => e.toJson(),).toList());
    await prefs.setString(_prefsKey, raw);
  }
}

final historyProvider =
StateNotifierProvider<HistoryNotifier, List<HistoryEntry>>(
      (ref) => HistoryNotifier(),
);
