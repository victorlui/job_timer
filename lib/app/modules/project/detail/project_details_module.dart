import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_time/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:job_time/app/modules/project/detail/project_details_page.dart';
import 'package:job_time/app/view_models/project_model.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class ProjectDetailModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        BlocBind.lazySingleton(
            (i) => ProjectDetailController(projectService: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) {
          final ProjectModel projectModel = args.data;
          return ProjectDetailsPage(
            controller: Modular.get()..setProject(projectModel),
          );
        })
      ];
}
