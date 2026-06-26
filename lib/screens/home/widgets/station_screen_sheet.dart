import 'dart:async';

import 'package:daisy_chain/core/api/api_client.dart';
import 'package:daisy_chain/core/constants.dart';
import 'package:daisy_chain/models/search_models.dart';
import 'package:daisy_chain/providers/recent_searches_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class StationScreenSheet extends ConsumerStatefulWidget {
  const StationScreenSheet({super.key});

  @override
  ConsumerState<StationScreenSheet> createState() {
    return _StationScreenSheetState();
  }
}

class _StationScreenSheetState extends ConsumerState<StationScreenSheet> {
  final _titleController = TextEditingController();
  final _validInput = RegExp(r'^[a-zA-Z\s\-]+$');
  bool _isLoading = false;
  List<Station> _result = [];
  Timer? _debounce;

  void _searchStation(String query) async {
    setState(() => _isLoading = true);
    try {
      final result = await ApiClient.searchStations(query);
      if (mounted) {
        setState(() {
          _result = result;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _result = [];
          _isLoading = false;
        });
      }
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 1750), () {
      final trimmed = query.trim();

      if (trimmed.length < 2) {
        setState(() => _result = []);
        return;
      }

      if (!_validInput.hasMatch(trimmed)) {
        setState(() => _result = []);
        return;
      }

      _searchStation(trimmed);
    });
  }

  @override
  void initState() {
    super.initState();
    ref.read(recentSearchesProvider.notifier).loadRecentSearches();
  }

  @override
  Widget build(BuildContext context) {
    final recent = ref.watch(recentSearchesProvider);
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.0,20.0,20.0,keyboardSpace + 20.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              style: AppTextStyles.trainName,
              maxLines: 1,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                border: ShapedInputBorder(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                hintText: 'Search for a city/station',
                hintStyle: AppTextStyles.trainName,
              ),
            ),
            SizedBox(height: 20),
            if (recent.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: Divider(thickness: 5, indent: 24, endIndent: 10),
                  ),
                  Text('Recent Searches', style: AppTextStyles.stationInput),
                  Expanded(
                    child: Divider(thickness: 5, indent: 10, endIndent: 24),
                  ),
                ],
              ),
            ...recent.map(
              (station) => ListTile(
                onLongPress: () =>
                    ref.read(recentSearchesProvider.notifier).clearAll(),
                onTap: () => Navigator.pop(context, station),
                title: Text(station.name),
                titleTextStyle: AppTextStyles.stationName.copyWith(fontSize: 16),
                subtitle: Text('${station.code} - ${station.name}'),
                subtitleTextStyle: AppTextStyles.stationName.copyWith(fontSize: 12),
              ),
            ),
            if (_isLoading)
              _StationShimmer()
            else if (_result.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: Divider(thickness: 5, indent: 24, endIndent: 10),
                  ),
                  Text('Stations', style: AppTextStyles.stationInput),
                  Expanded(
                    child: Divider(thickness: 5, indent: 10, endIndent: 24),
                  ),
                ],
              ),
            ..._result.map(
              (station) => Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ListTile(
                  onTap: () {
                    ref.read(recentSearchesProvider.notifier).addEntry(station);
                    Navigator.pop(context, station);
                  },
                  title: Text(station.name),
                  titleTextStyle: AppTextStyles.stationName.copyWith(fontSize: 16),
                  subtitle: Text('${station.code} - ${station.name}'),
                  subtitleTextStyle: AppTextStyles.stationName.copyWith(fontSize: 12),
                  shape: RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tileColor: Colors.black12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StationShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5,
        (index) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Station name placeholder
                    Container(
                      width: 160,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Station code placeholder
                    Container(
                      width: 60,
                      height: 11,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
