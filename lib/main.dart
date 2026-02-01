import 'dart:io';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:omni_preview/core/class/working_file.dart';
import 'package:omni_preview/core/di/injection_container.dart' as di;
import 'package:omni_preview/core/router/app_router.dart';
import 'package:omni_preview/core/utililty/utility.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:receive_intent/receive_intent.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await pdfrxFlutterInitialize();
  await di.init();

  String? initialFilePath;
  final pIndex = args.indexOf('-p');
  if (pIndex != -1 && pIndex + 1 < args.length) {
    initialFilePath = args[pIndex + 1];
  }

  if (initialFilePath == null) {
    try {
      final intent = await ReceiveIntent.getInitialIntent();
      if (intent?.data != null) {
        initialFilePath = intent!.data;
      } else {
        final uri = intent?.extra?['android.intent.extra.STREAM'];
        if (uri != null) {
          initialFilePath = uri.toString();
        }
      }
    } catch (_) {}
  }

  runApp(MyApp(initialFilePath: initialFilePath));
}

class MyApp extends StatelessWidget {
  final String? initialFilePath;

  const MyApp({super.key, this.initialFilePath});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Omni preview',
      // theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return InitialPathHandler(
          initialFilePath: initialFilePath,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}

class InitialPathHandler extends StatefulWidget {
  final String? initialFilePath;
  final Widget child;

  const InitialPathHandler({
    super.key,
    this.initialFilePath,
    required this.child,
  });

  @override
  State<InitialPathHandler> createState() => _InitialPathHandlerState();
}

class _InitialPathHandlerState extends State<InitialPathHandler> {
  bool _handled = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialFilePath != null && !_handled) {
      _handled = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _resolveAndOpen());
    }
  }

  Future<void> _resolveAndOpen() async {
    String path = widget.initialFilePath!;

    if (Platform.isAndroid) {
      try {
        path = await getFilePathFromUri(path);
      } catch (_) {}
    }

    if (!mounted) return;

    final file = WorkingFile(path: path, workingPath: path);
    openScreenForFile(context, file);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
