import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_time/app/core/ui/button_with_loader.dart';
import 'package:job_time/app/modules/project/register/controller/project_register_controller.dart';
import 'package:validatorless/validatorless.dart';

class ProjectRegisterPage extends StatefulWidget {
  final ProjectRegisterController controller;

  const ProjectRegisterPage({Key? key, required this.controller})
      : super(key: key);

  @override
  State<ProjectRegisterPage> createState() => _ProjectRegisterPageState();
}

class _ProjectRegisterPageState extends State<ProjectRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _estimatedEC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameEC.dispose();
    _estimatedEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectRegisterController, ProjectRegisterStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        switch (state) {
          case ProjectRegisterStatus.success:
            Navigator.pop(context);
            break;
          case ProjectRegisterStatus.failure:
            AsukaSnackbar.alert('Erro ao salvar').show();
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Criar novo projeto',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              TextFormField(
                controller: _nameEC,
                decoration: const InputDecoration(
                  label: Text('Nome do projeto'),
                ),
                validator: Validatorless.required('Nome obrigatório'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: _estimatedEC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Estimativa de horas'),
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.required('Estimativa obrigatória'),
                    Validatorless.number('Permitido somente números')
                  ])),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 49,
                child: ButtonWithLoader<ProjectRegisterController,
                    ProjectRegisterStatus>(
                  bloc: widget.controller,
                  selector: (state) => state == ProjectRegisterStatus.loading,
                  onPressed: () async {
                    final formValid =
                        _formKey.currentState?.validate() ?? false;
                    if (formValid) {
                      final name = _nameEC.text;
                      final estimate = int.parse(_estimatedEC.text);

                      await widget.controller.register(name, estimate);
                    }
                  },
                  label: 'Salvar',
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
