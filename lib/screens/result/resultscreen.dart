import 'package:daisy_chain/core/constants.dart';
import 'package:daisy_chain/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({
    super.key,
    required this.source,
    required this.destination,
    required this.date,
    this.after,
  });

  final String source;
  final String destination;
  final String date;
  final String? after;

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  late SearchParams _params;
  SearchState? _searchState;

  @override
  void initState() {
    super.initState();
    _params = SearchParams(source: widget.source, destination: widget.destination, date: widget.date,);
    _searchState = ref.watch(searchProvider);
    print('before - $_searchState');
    ref.read(searchProvider.notifier).search(_params);
    print('init - $_searchState');
  }

  @override
  Widget build(BuildContext context) {
    print('build - $_searchState');
    return Scaffold(
      appBar: AppBar(title: Text('Trains', style: AppTextStyles.appBarTitle)),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Divider(thickness: 5, indent: 24, endIndent: 10),
                ),
                Text('Direct Trains', style: AppTextStyles.stationInput),
                Expanded(
                  child: Divider(thickness: 5, indent: 10, endIndent: 24),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
