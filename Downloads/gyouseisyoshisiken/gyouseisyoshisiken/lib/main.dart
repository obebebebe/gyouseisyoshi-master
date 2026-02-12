import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'presentation/providers/quiz_provider.dart';
import 'presentation/providers/progress_provider.dart';
import 'presentation/providers/purchase_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => ProgressProvider()),
        ChangeNotifierProvider(create: (_) => PurchaseProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
