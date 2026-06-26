import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:daisy_chain/screens/home/homescreen.dart';
import 'package:daisy_chain/screens/detail/detailscreen.dart';
import 'package:daisy_chain/screens/detail/journeydetailscreen.dart';
import 'package:daisy_chain/screens/result/resultscreen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/results',
      name: 'results',
      builder: (BuildContext context, GoRouterState state) {
        final params = state.uri.queryParameters;
        return ResultScreen(
          source: params['source'] ?? '',
          destination: params['destination'] ?? '',
          date: params['date'] ?? '',
          after: params['after'],
        );
      },
    ),
    GoRoute(
      path: '/train/:trainNo',
      name: 'train',
      builder: (BuildContext context, GoRouterState state) {
        final trainNo = state.pathParameters['trainNo'] ?? '';
        return DetailScreen(trainNo: trainNo);
      },
    ),
    GoRoute(
      path: '/journey',
      name: 'journey',
      builder: (BuildContext context, GoRouterState state) {
        final params = state.uri.queryParameters;
        return JourneyDetailScreen(
          leg1TrainNo: params['leg1'] ?? '',
          leg2TrainNo: params['leg2'] ?? '',
          transferStation: params['transfer'] ?? '',
        );
      },
    ),
  ],
);
