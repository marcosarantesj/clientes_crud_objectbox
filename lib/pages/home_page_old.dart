import 'package:clientes_crud_objectbox/controllers/cliente_controller.dart';
import 'package:flutter/material.dart';
import '../entities/cliente_model.dart';
import '../repositories/cliente_repository.dart';
import 'cadastro_page.dart';
import 'edicao_page.dart';

class HomePageOld extends StatefulWidget {
  final String title;
  final ClienteRepository clienteRepository;

  const HomePageOld({
    super.key,
    required this.title,
    required this.clienteRepository,
  });

  @override
  State<HomePageOld> createState() => _HomePageOldState();
}

class _HomePageOldState extends State<HomePageOld> {
  late List<ClienteModel> getAll;
  late ClienteController clienteController;

  void listar() async {
    try {
      final List<ClienteModel> allClientes =
          await widget.clienteRepository.getClientes();
      // final List<ClienteModel> allClientes =
      //     await clienteController.getClientes();
      setState(() {
        getAll = allClientes;
      });
    } catch (e) {
      // AppUtils.mostrarSnackBar(context, 'Erro ao listar: $e');
    }
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // listar();
  // }

  @override
  void initState() {
    super.initState();
    clienteController = ClienteController(repository: widget.clienteRepository);
    getAll = [];
    listar();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void novoCadastro() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => CadastroPage(
          title: 'Cadastro de Clientes',
          clienteRepository: widget.clienteRepository,
        ),
      ),
      (route) => false, //Remove as rotas anteriores
    );
  }

  void editarCliente(ClienteModel cliente) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EdicaoPage(
          cliente: cliente,
          title: 'Editar Cliente',
          clienteRepository: widget.clienteRepository,
        ),
      ),
    ).then((result) {
      // Opcional: Adicione lógica para atualizar a lista após a edição
      if (result == true) {
        // listar();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                        'Clientes',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    onPressed: novoCadastro,
                    tooltip: 'Novo Cadastro',
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                // padding: const EdgeInsets.all(8),
                itemCount: getAll.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text(getAll[index].nome.toString()),
                      subtitle: Text('${getAll[index].idade}'),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                editarCliente(getAll[index]);
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                widget.clienteRepository
                                    .deleteCliente(getAll[index].id);
                                setState(() {
                                  // AppUtils.mostrarSnackBar(context, '');
                                  listar();
                                });
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
