import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_time/app/modules/project/detail/project_details_module.dart';
import 'package:job_time/app/modules/project/register/project_register_module.dart';
import 'package:job_time/app/modules/project/task/task_module.dart';

class ProjectModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/register', module: ProjectRegisterModule()),
        ModuleRoute('/detail', module: ProjectDetailModule()),
        ModuleRoute('/task', module: TaskModule())
      ];
}
