import 'package:cognitivestudio/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:cognitivestudio/firebase_options.dart';
import 'package:logger/logger.dart';
import 'package:cognitivestudio/main_view_model.dart';
import 'package:routemaster/routemaster.dart';
import 'package:firebase_core/firebase_core.dart';

class LogAll extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}

/// logger
Logger logger = Logger(
  // filter: LogAll(), // Use the default LogFilter (-> only log in debug mode)
  // filter: null,// Use the default LogFilter (-> only log in debug mode)
  printer: PrettyPrinter(
      methodCount: 3, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 20, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: true // Should each log print contain a timestamp
      ), // Use the PrettyPrinter to format and print log
  output: null, // Use the default LogOutput (-> send everything to console)
  // output:ConsoleOutput(), // Use the default LogOutput (-> send everything to console)
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );

  runApp(
    const ProviderScope(
      child: CogntiveStudio(),
    ),
  );
}

class CogntiveStudio extends HookConsumerWidget {
  const CogntiveStudio({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _viewModel = ref.watch(mainViewModelProvider);
    return MaterialApp.router(
      /// chage route for authentification guard
      routerDelegate: _viewModel.routemasterDelegate,
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
