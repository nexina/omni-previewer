import 'dart:io';

import 'package:omni_previewer/core/class/working_file.dart';
import 'package:omni_previewer/core/utililty/utility.dart';
import 'package:omni_previewer/features/main/data/datasource/local/recent_list_local_datasource.dart';
import 'package:omni_previewer/features/main/domain/repositories/recent_list_repository.dart';
import 'package:omni_previewer/features/main/presentation/bloc/recent_list_state.dart';

class RecentListRepositoryImpl implements RecentListRepository {
  final RecentListLocalDataSource localDataSource;

  RecentListRepositoryImpl({required this.localDataSource});

  @override
  Future<List<RecentFileItem>> getRecentFilesWithMeta() async {
    final files = await localDataSource.getFiles();

    final List<RecentFileItem> result = [];

    for (final file in files) {
      try {
        final retrievefile = File(file.workingPath);
        if (!await retrievefile.exists()) continue;

        final stat = await retrievefile.stat();

        result.add(
          RecentFileItem(
            filePath: file.path,
            fileWorkingPath: file.workingPath,
            lastOpened: stat.modified,
            fileSize: formatBytes(stat.size),
          ),
        );
      } catch (_) {
        // Ignore invalid files
      }
    }
    return result;
  }

  @override
  Future<void> addRecentFile(WorkingFile workingnFile) async {
    final paths = await localDataSource.getFiles();

    paths.remove(workingnFile);
    paths.insert(0, workingnFile);

    if (paths.length > 30) {
      paths.removeRange(30, paths.length);
    }

    await localDataSource.saveFiles(paths);
  }

  @override
  Future<void> removeRecentFile(WorkingFile workingFile) async {
    final paths = await localDataSource.getFiles();
    paths.remove(workingFile);
    await localDataSource.saveFiles(paths);
  }

  @override
  Future<void> clearRecentFiles() async {
    await localDataSource.clear();
  }
}
