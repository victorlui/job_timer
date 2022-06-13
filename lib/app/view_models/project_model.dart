import 'package:job_time/app/entities/project.dart';
import 'package:job_time/app/entities/project_status.dart';
import 'package:job_time/app/view_models/projetc_task_model.dart';

class ProjectModel {
  final int? id;
  final String name;
  final int estimated;
  final ProjectStatus status;
  final List<ProjectTaskModel> tasks;

  ProjectModel({
    this.id,
    required this.name,
    required this.estimated,
    required this.status,
    required this.tasks,
  });

  factory ProjectModel.fromEntity(Project project) {
    project.tasks.loadSync();

    return ProjectModel(
      id: project.id,
      name: project.name,
      estimated: project.estimated,
      status: project.status,
      tasks: project.tasks.map(ProjectTaskModel.fromEntity).toList(),
    );
  }
}
