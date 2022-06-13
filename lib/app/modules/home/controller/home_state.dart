part of 'home_controller.dart';

enum HomeStatus {
  initial,
  loading,
  complete,
  failure;
}

class HomeState extends Equatable {
  final List<ProjectModel> projects;
  final HomeStatus status;
  final ProjectStatus projectStatus;

  HomeState.initial()
      : this._(
            projects: [],
            projectStatus: ProjectStatus.em_andamento,
            status: HomeStatus.initial);

  const HomeState._({
    required this.projects,
    required this.status,
    required this.projectStatus,
  });

  @override
  List<Object?> get props => [projects, status, projectStatus];

  HomeState copyWith({
    List<ProjectModel>? projects,
    HomeStatus? status,
    ProjectStatus? projectStatus,
  }) {
    return HomeState._(
      projects: projects ?? this.projects,
      status: status ?? this.status,
      projectStatus: projectStatus ?? this.projectStatus,
    );
  }
}
