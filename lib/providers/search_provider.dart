import 'package:flutter_riverpod/legacy.dart';

import 'package:daisy_chain/core/api/api_client.dart';
import 'package:daisy_chain/models/search_models.dart';

sealed class SearchResultItem {
  int get sortMinutes;
}

class DirectItem extends SearchResultItem {
  final DirectResult result;

  DirectItem(this.result);

  @override
  int get sortMinutes => result.journeyMinutes;
}

class IndirectItem extends SearchResultItem {
  final IndirectResult result;

  IndirectItem(this.result);

  @override
  int get sortMinutes => result.totalMinute;
}

class SearchParams {
  final String source;
  final String destination;
  final String date;
  final String? after;

  const SearchParams({
    required this.source,
    required this.destination,
    required this.date,
    this.after,
  });
}

class SearchState {
  final bool isLoading;
  final String? error;
  final List<SearchResultItem> results;
  final int directCount;
  final int indirectCount;

  const SearchState({
    this.isLoading = false,
    this.error,
    this.results = const [],
    this.directCount = 0,
    this.indirectCount = 0,
  });

  SearchState copyWith({
    bool? isLoading,
    String? error,
    List<SearchResultItem>? results,
    int? directCount,
    int? indirectCount,
  }) => SearchState(
    isLoading: isLoading ?? this.isLoading,
    error: error,
    results: results ?? this.results,
    directCount: directCount ?? this.directCount,
    indirectCount: indirectCount ?? this.indirectCount,
  );
}

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier() : super(const SearchState());

  Future<void> search(SearchParams params) async {
    state = state.copyWith(isLoading: true, error: null, results: []);

    try {
      final response = await ApiClient.instance.get(
        '/search/',
        queryParameters: {
          'source': params.source,
          'destination': params.destination,
          'date': params.date,
          if (params.after != null) 'after': params.after,
        },
      );

      final data = response.data as Map<String, dynamic>;

      final directItem = (data['direct']['results'] as List)
          .map((j) => DirectItem(DirectResult.fromJson(j)))
          .toList();

      final indirectItem = (data['indirect']['results'] as List)
          .map((j) => IndirectItem(IndirectResult.fromJson(j)))
          .toList();

      final merged = [...directItem, ...indirectItem]
        ..sort((a, b) => a.sortMinutes.compareTo(b.sortMinutes));

      state = state.copyWith(
        isLoading: false,
        results: merged,
        directCount: directItem.length,
        indirectCount: indirectItem.length,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: true,
        error: 'Search failed. Please check your connection.',
      );
    }
  }
  void reset() => state = const SearchState();
}

final searchProvider =
StateNotifierProvider<SearchNotifier, SearchState>(
      (ref) => SearchNotifier(),
);