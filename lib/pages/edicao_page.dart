import 'package:flutter/material.dart';
import '../controllers/cliente_controller.dart';
import '../entities/cliente_model.dart';
import '../models/app_utils.dart';
import '../repositories/cliente_repository.dart';
import 'home_page.dart';

class EdicaoPage extends StatefulWidget {
  final ClienteRepository clienteRepository;
  final ClienteModel cliente;
  final String title;
  const EdicaoPage({
    super.key,
    required this.title,
    required this.cliente,
    required this.clienteRepository,
  });

  @override
  State<EdicaoPage> createState() => _EdicaoPageState();
}

class _EdicaoPageState extends State<EdicaoPage> {
  late TextEditingController controllerNome;
  late TextEditingController controllerIdade;
  late ClienteController clienteController;
  String message = '';

  @override
  void initState() {
    super.initState();
    controllerNome = TextEditingController(text: widget.cliente.nome ?? '');
    controllerIdade =
        TextEditingController(text: widget.cliente.idade?.toString() ?? '');
    clienteController = ClienteController(repository: widget.clienteRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controllerNome,
              decoration: const InputDecoration(
                hintText: 'Nome',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controllerIdade,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Idade',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      final nome = controllerNome.text.trim();
                      final idade = int.tryParse(controllerIdade.text.trim());
                      final clienteModel = ClienteModel()
                        ..id = widget.cliente.id
                        ..nome = nome
                        ..idade = idade;
                      var result =
                          clienteController.updateCliente(clienteModel);
                      if (result.toString().isNotEmpty) {
                        AppUtils.mostrarSnackBar(context,
                            'Atualizado com sucesso!  ID: ${widget.cliente.id}');
                      } else {
                        AppUtils.mostrarSnackBar(context,
                            'Erro ao atualizar! ID: ${widget.cliente.id}');
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => (
                      //Remove as telas anteriores
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                              title: 'Cadastro de Clientes',
                              clienteRepository: widget.clienteRepository),
                        ),
                        (route) => false, //Remove as rotas anteriores
                      ),
                    ),
                    child: const Text('Fechar'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
