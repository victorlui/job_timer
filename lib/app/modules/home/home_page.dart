import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_time/app/modules/home/controller/home_controller.dart';
import 'package:job_time/app/modules/home/widgets/header_projects_menu.dart';
import 'package:job_time/app/modules/home/widgets/project_tile.dart';
import 'package:job_time/app/view_models/project_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.controller}) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeController, HomeState>(
      bloc: controller,
      listener: (context, state) {
        if (state.status == HomeStatus.failure) {
          AsukaSnackbar.alert('Erro ao buscar projetos').show();
        }
      },
      child: Scaffold(
          drawer: const Drawer(
            child: SafeArea(
                child: ListTile(
              title: Text('Sair'),
            )),
          ),
          body: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text('Projetos'),
                expandedHeight: 100,
                toolbarHeight: 100,
                centerTitle: true,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(15)),
                ),
              ),
              SliverPersistentHeader(
                delegate: HeaderProjectMenuWidget(controller: controller),
                pinned: true,
              ),
              BlocSelector<HomeController, HomeState, bool>(
                bloc: controller,
                selector: (state) => state.status == HomeStatus.loading,
                builder: (context, showLoading) {
                  return SliverVisibility(
                    visible: showLoading,
                    sliver: const SliverToBoxAdapter(
                        child: SizedBox(
                      height: 50,
                      child:
                          Center(child: CircularProgressIndicator.adaptive()),
                    )),
                  );
                },
              ),
              BlocSelector<HomeController, HomeState, List<ProjectModel>>(
                bloc: controller,
                selector: (state) => state.projects,
                builder: (context, projects) {
                  return SliverList(
                      delegate: SliverChildListDelegate(
                    projects.map((e) => ProjectTile(project: e)).toList(),
                  ));
                },
              )
            ],
          )),
    );
  }
}
