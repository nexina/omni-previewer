import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:omni_previewer/core/class/working_file.dart';
import 'package:omni_previewer/core/di/injection_container.dart';
import 'package:omni_previewer/features/main/presentation/bloc/recent_list_bloc.dart';
import 'package:omni_previewer/features/main/presentation/bloc/recent_list_event.dart';
import 'package:omni_previewer/features/main/presentation/page/mainpage.dart';
import 'package:omni_previewer/features/main/presentation/page/settings.dart';
import 'package:omni_previewer/features/viewer/presentation/page/archive.dart';
import 'package:omni_previewer/features/viewer/presentation/page/audio.dart';
import 'package:omni_previewer/features/viewer/presentation/page/document.dart';
import 'package:omni_previewer/features/viewer/presentation/page/image.dart';
import 'package:omni_previewer/features/viewer/presentation/page/text.dart';
import 'package:omni_previewer/features/viewer/presentation/page/video.dart';

class AppRouter {
  static String textViewerRoute = '/textViewer';
  static String audioViewerRoute = '/audioViewer';
  static String videoViewerRoute = '/videoViewer';
  static String imageViewerRoute = '/imageViewer';
  static String archiveViewerRoute = '/archiveViewer';
  static String documentViewerRoute = '/documentViewer';

  static String setting = '/setting';

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) =>
                getIt<RecentListBloc>()..add(LoadRecentListEvent()),
            child: child,
          );
        },
        routes: [
          GoRoute(path: '/', builder: (context, state) => const MainPage()),
          GoRoute(
            name: setting,
            path: setting,
            builder: (context, state) {
              return const SettingsView();
            },
          ),
        ],
      ),
      GoRoute(
        name: textViewerRoute,
        path: textViewerRoute,
        builder: (context, state) {
          return TextViewer(workingFile: state.extra as WorkingFile);
        },
      ),
      GoRoute(
        name: audioViewerRoute,
        path: audioViewerRoute,
        builder: (context, state) {
          return AudioViewer(workingFile: state.extra as WorkingFile);
        },
      ),
      GoRoute(
        name: videoViewerRoute,
        path: videoViewerRoute,
        builder: (context, state) {
          return VideoViewer(workingFile: state.extra as WorkingFile);
        },
      ),
      GoRoute(
        name: imageViewerRoute,
        path: imageViewerRoute,
        builder: (context, state) {
          return ImageViewer(workingFile: state.extra as WorkingFile);
        },
      ),
      GoRoute(
        name: archiveViewerRoute,
        path: archiveViewerRoute,
        builder: (context, state) {
          return ArchieveViewer(workingFile: state.extra as WorkingFile);
        },
      ),
      GoRoute(
        name: documentViewerRoute,
        path: documentViewerRoute,
        builder: (context, state) {
          return DocumentViewer(workingFile: state.extra as WorkingFile);
        },
      ),
    ],
  );
}
