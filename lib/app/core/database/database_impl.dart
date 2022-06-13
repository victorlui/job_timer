import 'package:isar/isar.dart';
import 'package:job_time/app/core/database/database.dart';
import 'package:job_time/app/entities/project.dart';
import 'package:job_time/app/entities/project_task.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseImpl implements Database {
  Isar? _databaseInstance;

  @override
  Future<Isar> openConnection() async {
    if (_databaseInstance == null) {
      final dir = await getApplicationSupportDirectory();
      _databaseInstance = await Isar.open(
        schemas: [ProjectTaskSchema, ProjectSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return _databaseInstance!;
  }
}
