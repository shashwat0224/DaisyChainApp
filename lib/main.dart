import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daisy_chain/core/router.dart';
import 'package:daisy_chain/core/constants.dart';
import 'package:daisy_chain/providers/history_provider.dart';

void main() {
  runApp(const ProviderScope(child: DaisyChainApp()));
}

class DaisyChainApp extends ConsumerStatefulWidget {
  const DaisyChainApp({super.key});

  @override
  ConsumerState<DaisyChainApp> createState() => _DaisyChainAppState();
}

class _DaisyChainAppState extends ConsumerState<DaisyChainApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(historyProvider.notifier).loadHistory();
    },);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DaisyChain',
      theme: ThemeData(
        // textTheme: GoogleFonts.bitcountGridDoubleTextTheme(),
        colorSchemeSeed: AppColors.primary,
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}

