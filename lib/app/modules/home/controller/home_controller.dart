import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:job_time/app/entities/project_status.dart';
import 'package:job_time/app/services/projects/projects_services.dart';
import 'package:job_time/app/view_models/project_model.dart';

import 'package:bloc/bloc.dart';

part 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final ProjectService _projectService;

  HomeController({required ProjectService projectService})
      : _projectService = projectService,
        super(HomeState.initial());

  Future<void> loadProjects() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final projects = await _projectService.findByStatus(state.projectStatus);
      emit(state.copyWith(status: HomeStatus.complete, projects: projects));
    } catch (e, s) {
      log('Erro ao buscar projetos', error: e, stackTrace: s);
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> filter(ProjectStatus status) async {
    emit(state.copyWith(status: HomeStatus.loading, projects: []));
    final project = await _projectService.findByStatus(status);
    emit(state.copyWith(
      status: HomeStatus.complete,
      projects: project,
      projectStatus: status,
    ));
  }

  void updateList() => filter(state.projectStatus);
}
