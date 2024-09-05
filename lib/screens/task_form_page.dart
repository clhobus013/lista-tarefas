import 'package:flutter/material.dart';

class TaskFormPage extends StatefulWidget {
  final Function saveTask;

  const TaskFormPage({super.key, required this.saveTask});

  @override
  State<TaskFormPage> createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controllerTitle.dispose();
    _controllerDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _controllerTitle,
                decoration: const InputDecoration(
                    labelText: 'Titulo',
                    border: OutlineInputBorder() //Gera a borda toda no campo.
                    ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor preencha um valor para o campo titulo.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _controllerDescription,
                decoration: const InputDecoration(
                    labelText: 'Descricao',
                    border: OutlineInputBorder() //Gera a borda toda no campo.
                    ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'É obrigatório informar a descricao.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String textoDoCampo =
                        'Salvando: ${_controllerTitle.text} ${_controllerDescription.text}';

                    var snackBar = SnackBar(
                      content: Text(textoDoCampo),
                      action: SnackBarAction(
                        label: 'Confirmar',
                        onPressed: () {
                          // print('Você clicou no Confirmar do Snack');
                        },
                      ),
                    );

                    widget.saveTask(
                        id: 5,
                        title: _controllerTitle.text,
                        description: _controllerDescription.text);

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
