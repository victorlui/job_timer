import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_time/app/core/database/database.dart';
import 'package:job_time/app/core/database/database_impl.dart';
import 'package:job_time/app/modules/home/home_module.dart';
import 'package:job_time/app/modules/project/project_module.dart';
import 'package:job_time/app/modules/splash/splash.page.dart';
import 'package:job_time/app/services/auth/auth_service_impl.dart';
import 'package:job_time/app/services/auth/auth_services.dart';
import 'package:job_time/app/services/projects/project_services_impl.dart';
import 'package:job_time/app/services/projects/projects_services.dart';
import 'package:job_time/repositories/projects/project_repository.dart';
import 'package:job_time/repositories/projects/project_repository_impl.dart';

import 'modules/login/login_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<AuthServices>((i) => AuthServicesImpl()),
        Bind.lazySingleton<Database>((i) => DatabaseImpl()),
        Bind.lazySingleton<ProjectRepository>(
            (i) => ProjectRepositoryImpl(db: i())),
        Bind.lazySingleton<ProjectService>(
          (i) => ProjectServicesImpl(projectRepository: i()),
        )
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SplashPage()),
        ModuleRoute('/login', module: LoginModule()),
        ModuleRoute('/home', module: HomeModule()),
        ModuleRoute('/project', module: ProjectModule()),
      ];
}
