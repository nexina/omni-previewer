import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:omni_preview/features/common/widget/background_builder.dart';
import 'package:omni_preview/features/main/presentation/page/mainpage/mainpage_all.dart';
import 'package:omni_preview/features/main/presentation/page/mainpage/mainpage_web.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundBuilder(
      child: (kIsWeb) ? const MainpageWeb() : const MainpageAll(),
    );
  }
}
