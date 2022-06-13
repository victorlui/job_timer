import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_time/app/core/ui/job_timer_icons.dart';
import 'package:job_time/app/modules/home/controller/home_controller.dart';
import 'package:job_time/app/view_models/project_model.dart';

class ProjectTile extends StatelessWidget {
  final ProjectModel project;

  const ProjectTile({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Modular.to.pushNamed('/project/detail', arguments: project);
        Modular.get<HomeController>().updateList();
      },
      child: Container(
        constraints: const BoxConstraints(maxHeight: 90),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 4,
          ),
        ),
        child: Column(
          children: [
            ProjectName(project: project),
            Expanded(child: ProgressTimer(project: project)),
          ],
        ),
      ),
    );
  }
}

// widgets project name
class ProjectName extends StatelessWidget {
  final ProjectModel project;
  const ProjectName({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(project.name),
          Icon(
            JobTimerIcons.angle_double_right,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}

// barra de progresso
class ProgressTimer extends StatelessWidget {
  final ProjectModel project;
  const ProgressTimer({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final totalTasks = project.tasks.fold<int>(
        0, ((previousValue, element) => previousValue += element.duration));
    var percent = 0.0;

    if (totalTasks > 0) {
      percent = totalTasks / project.estimated;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: Colors.grey[400],
              color: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('${project.estimated}h'),
          )
        ],
      ),
    );
  }
}
