import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:omni_previewer/core/di/injection_container.dart' as di;
import 'package:omni_previewer/core/router/app_router.dart';
import 'package:omni_previewer/features/common/widget/file_launcher.dart';
import 'package:pdfrx/pdfrx.dart';

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

  runApp(MyApp(initialFilePath: initialFilePath));
}

class MyApp extends StatelessWidget {
  final String? initialFilePath;

  const MyApp({super.key, this.initialFilePath});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Omni Previewer',
      // theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        if (initialFilePath != null) {
          return InitialFileLauncher(
            filePath: initialFilePath!,
            child: child ?? const SizedBox.shrink(),
          );
        }
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
