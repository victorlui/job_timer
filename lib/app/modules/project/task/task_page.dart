import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_time/app/core/ui/button_with_loader.dart';
import 'package:job_time/app/modules/project/task/controller/task_controller.dart';
import 'package:validatorless/validatorless.dart';

class TaskPage extends StatefulWidget {
  final TaskController controller;

  const TaskPage({super.key, required this.controller});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameTask = TextEditingController();
  final _durationTask = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameTask.dispose();
    _durationTask.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskController, TaskStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        if (state == TaskStatus.success) {
          Navigator.pop(context);
        } else if (state == TaskStatus.feilure) {
          AsukaSnackbar.alert('Erro ao salvar Task').show();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Criar nova Task',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Nome da Task'),
                ),
                controller: _nameTask,
                validator: Validatorless.required('Nome Obrigatório'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Duração da Task'),
                ),
                controller: _durationTask,
                keyboardType: TextInputType.number,
                validator: Validatorless.multiple([
                  Validatorless.required('Duração obrigatório'),
                  Validatorless.number('Permitio somente números')
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 49,
                child: ButtonWithLoader<TaskController, TaskStatus>(
                  bloc: widget.controller,
                  selector: (state) => state == TaskStatus.loading,
                  label: 'Salvar',
                  onPressed: () {
                    final formValid =
                        _formKey.currentState?.validate() ?? false;

                    if (formValid) {
                      final duration = int.parse(_durationTask.text);
                      widget.controller.register(_nameTask.text, duration);
                    }
                  },
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
