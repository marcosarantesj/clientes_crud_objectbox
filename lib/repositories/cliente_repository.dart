import 'package:path_provider/path_provider.dart';
import '../entities/cliente_model.dart';
import '../objectbox.g.dart';

class ClienteRepository {
  late Store _store;
  late Box<ClienteModel> _clienteBox;

  Future<void> openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    var path = '${dir.path}/objectbox';
    _store = Store(getObjectBoxModel(), directory: path);

    _clienteBox = Box<ClienteModel>(_store);
  }

  Future<void> closeBox() async {
    _store.close();
  }

  Future addCliente(ClienteModel cliente) async {
    return _clienteBox.put(cliente);
  }

  Future<List<ClienteModel>> getClientes() async {
    return _clienteBox.getAll();
  }

  Future<ClienteModel?> getCliente(int id) async {
    return _clienteBox.get(id);
  }

  Future updateCliente(ClienteModel cliente) async {
    if (cliente.id <= 0) {
      throw Exception('ID inválido para atualização.');
    }

    var existingCliente = _clienteBox.get(cliente.id);

    if (existingCliente != null) {
      existingCliente.nome = cliente.nome;
      existingCliente.idade = cliente.idade;
      final int result = _clienteBox.put(existingCliente);
      return result;
    } else {
      throw Exception('Cliente não encontrado para atualização.');
    }
  }

  Future<void> deleteCliente(int clienteId) async {
    _clienteBox.remove(clienteId);
  }
}
