import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_time/app/entities/project_status.dart';
import 'package:job_time/app/modules/home/controller/home_controller.dart';

class HeaderProjectMenuWidget extends SliverPersistentHeaderDelegate {
  final HomeController controller;

  HeaderProjectMenuWidget({required this.controller});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          height: constraints.maxHeight,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            SizedBox(
              width: constraints.maxWidth * .5,
              child: DropdownButtonFormField<ProjectStatus>(
                value: ProjectStatus.em_andamento,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    isCollapsed: true),
                items: ProjectStatus.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.label),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.filter(value);
                  }
                },
              ),
            ),
            SizedBox(
                width: constraints.maxWidth * .4,
                height: 45,
                child: ElevatedButton.icon(
                    onPressed: () async {
                      await Modular.to.pushNamed('/project/register');
                      controller.loadProjects();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Novo Projeto'))),
          ]),
        );
      },
    );
  }

  @override
  double get maxExtent => 80.0;

  @override
  double get minExtent => 80.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}