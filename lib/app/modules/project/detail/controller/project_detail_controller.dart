import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_time/app/services/projects/projects_services.dart';
import 'package:job_time/app/view_models/project_model.dart';

part 'project_detail_state.dart';

class ProjectDetailController extends Cubit<ProjectDetailState> {
  final ProjectService _projectService;
  ProjectDetailController({required ProjectService projectService})
      : _projectService = projectService,
        super(const ProjectDetailState.initial());

  void setProject(ProjectModel projectModel) {
    emit(state.copyWith(
        projectModel: projectModel, status: ProjectDetailStatus.complete));
  }

  Future<void> updatePrject() async {
    final project = await _projectService.findById(state.projectModel!.id!);
    emit(state.copyWith(
        projectModel: project, status: ProjectDetailStatus.complete));
  }

  Future<void> finishProject() async {
    try {
      emit(state.copyWith(status: ProjectDetailStatus.loading));
      final projectId = state.projectModel!.id!;
      _projectService.finishProject(projectId);
      updatePrject();
    } catch (e) {
      emit(state.copyWith(status: ProjectDetailStatus.failure));
    }
  }
}
