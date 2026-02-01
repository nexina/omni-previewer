import 'package:omni_previewer/core/class/working_file.dart';
import 'package:omni_previewer/features/main/presentation/bloc/recent_list_state.dart';

abstract class RecentListRepository {
  Future<List<RecentFileItem>> getRecentFilesWithMeta();
  Future<void> addRecentFile(WorkingFile workingnFile);
  Future<void> removeRecentFile(WorkingFile workingnFile);
  Future<void> clearRecentFiles();
}
