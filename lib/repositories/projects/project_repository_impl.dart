import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:job_time/app/core/database/database.dart';
import 'package:job_time/app/core/exeptions/failure.dart';
import 'package:job_time/app/entities/project.dart';
import 'package:job_time/app/entities/project_status.dart';
import 'package:job_time/app/entities/project_task.dart';
import 'package:job_time/repositories/projects/project_repository.dart';

class ProjectRepositoryImpl extends ProjectRepository {
  final Database _db;

  ProjectRepositoryImpl({required Database db}) : _db = db;

  @override
  Future<void> register(Project project) async {
    try {
      final connection = await _db.openConnection();
      await connection.writeTxn((isar) {
        return isar.projects.put(project);
      });
    } on IsarError catch (e, s) {
      log('Erro  ao cadastrar projeto', error: e, stackTrace: s);
      throw Failure(message: 'Erro  ao cadastrar projeto');
    }
  }

  @override
  Future<List<Project>> findByStatus(ProjectStatus status) async {
    final connection = await _db.openConnection();

    final projects =
        await connection.projects.filter().statusEqualTo(status).findAll();

    return projects;
  }

  @override
  Future<Project> addTask(int projectId, ProjectTask task) async {
    final connection = await _db.openConnection();
    final project = await findById(projectId);

    project.tasks.add(task);
    await connection.writeTxn((isar) => project.tasks.save());

    return project;
  }

  @override
  Future<Project> findById(int projectId) async {
    final connection = await _db.openConnection();
    final project = await connection.projects.get(projectId);

    if (project == null) {
      throw Failure(message: 'Projeto não encontrado');
    }

    return project;
  }

  @override
  Future<void> finishProject(int id) async {
    try {
      final connection = await _db.openConnection();
      final project = await findById(id);

      project.status = ProjectStatus.finalizado;
      await connection.writeTxn(
          (isar) => connection.projects.put(project, saveLinks: true));
    } on IsarError catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      throw Failure(message: 'Erro ao finalizar projeto');
    }
  }
}
