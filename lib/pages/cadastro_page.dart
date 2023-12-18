import 'package:flutter/material.dart';
import '../controllers/cliente_controller.dart';
import '../entities/cliente_model.dart';
import '../models/app_utils.dart';
import '../repositories/cliente_repository.dart';
import 'home_page.dart';

class CadastroPage extends StatefulWidget {
  final ClienteRepository clienteRepository;
  final String title;
  const CadastroPage(
      {super.key, required this.title, required this.clienteRepository});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  late TextEditingController controllerNome;
  late TextEditingController controllerIdade;
  late ClienteController clienteController;
  String message = '';

  @override
  void initState() {
    super.initState();
    controllerNome = TextEditingController();
    controllerIdade = TextEditingController();
    clienteController = ClienteController(repository: widget.clienteRepository);
  }

  Future<String> addCliente() async {
    final nome = controllerNome.text.trim();
    final idade = int.tryParse(controllerIdade.text.trim());
    final cliente = ClienteModel(nome: nome, idade: idade);

    try {
      await clienteController.addCliente(cliente);
      message = 'Salvo com sucesso!';
      controllerIdade.text = '';
      controllerNome.text = '';
    } catch (e) {
      message = 'Erro ao salvar $e';
    }
    return message;
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
                    onPressed: () async {
                      await addCliente();
                      // ignore: use_build_context_synchronously
                      AppUtils.mostrarSnackBar(context, message);
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
