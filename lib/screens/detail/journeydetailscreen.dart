import 'package:flutter/material.dart';

class JourneyDetailScreen extends StatelessWidget {
  const JourneyDetailScreen({
    super.key,
    required this.leg1TrainNo,
    required this.leg2TrainNo,
    required this.transferStation,
  });

  final String leg1TrainNo;
  final String leg2TrainNo;
  final String transferStation;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
