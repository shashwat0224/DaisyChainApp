import 'package:daisy_chain/core/constants.dart';
import 'package:daisy_chain/screens/home/widgets/station_input.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daisy Chain',style: AppTextStyles.stationInput,),
      ),
      body: StationInput(),
    );
  }
}
