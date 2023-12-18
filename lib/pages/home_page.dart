import 'package:clientes_crud_objectbox/controllers/cliente_controller.dart';
import 'package:flutter/material.dart';
import '../entities/cliente_model.dart';
import '../repositories/cliente_repository.dart';
import 'cadastro_page.dart';
import 'edicao_page.dart';

class HomePage extends StatefulWidget {
  final String title;
  final ClienteRepository clienteRepository;

  const HomePage({
    super.key,
    required this.title,
    required this.clienteRepository,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<ClienteModel> getAll;
  late ClienteController clienteController;

  void listar() async {
    getAll = await clienteController.getClientes();
  }

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
                    onPressed: () => (
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CadastroPage(
                            title: 'Cadastro de Clientes',
                            clienteRepository: widget.clienteRepository,
                          ),
                        ),
                        (route) => false,
                      ),
                    ),
                    tooltip: 'Novo Cadastro',
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
            ValueListenableBuilder<Status>(
              valueListenable: clienteController.status,
              builder: (context, status, child) {
                if (status == Status.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (status == Status.empty) {
                  return const Text('Nenhum cliente cadastrado!');
                } else if (status == Status.success) {
                  //Carregar os dados aqui
                  return Expanded(
                    child: ListView.builder(
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
                                    onPressed: () => (
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EdicaoPage(
                                            cliente: getAll[index],
                                            title: 'Editar Cliente',
                                            clienteRepository:
                                                widget.clienteRepository,
                                          ),
                                        ),
                                      ),
                                    ),
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      clienteController
                                          .deleteCliente(getAll[index].id);
                                      listar();
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
                  );
                } else if (status == Status.error) {
                  return const Center(
                    child: Text('Erro ao carregar clientes!'),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
