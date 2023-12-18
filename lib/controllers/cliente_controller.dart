// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:clientes_crud_objectbox/entities/cliente_model.dart';
import 'package:flutter/material.dart';
import '../repositories/cliente_repository.dart';

enum Status {
  loading,
  empty,
  success,
  error,
}

class ClienteController extends ChangeNotifier {
  final ClienteRepository _repository;
  final status = ValueNotifier<Status>(Status.success);

  ClienteController({required ClienteRepository repository})
      : _repository = repository;

  void openDB() {
    _repository.openBox();
  }

  void closeDB() {
    _repository.closeBox();
  }

  addCliente(ClienteModel cliente) {
    try {
      _repository.addCliente(cliente) as int;
      status.value = Status.success;
    } catch (e) {
      status.value = Status.error;
    }
    notifyListeners();
  }

  Future<List<ClienteModel>> getClientes() async {
    try {
      status.value = Status.loading;
      List<ClienteModel?> clientes = await _repository.getClientes();
      if (clientes.isEmpty) {
        status.value = Status.empty;
      } else {
        status.value = Status.success;
      }
      return clientes
          .where((cliente) => cliente != null)
          .cast<ClienteModel>()
          .toList();
    } catch (e) {
      status.value = Status.error;
      return []; // ou outra ação de tratamento de erro
    } finally {
      notifyListeners();
    }
  }

  getCliente(int id) {
    try {
      status.value = Status.success;
      return _repository.getCliente(id);
    } catch (e) {
      status.value = Status.error;
    }
    notifyListeners();
  }

  updateCliente(ClienteModel cliente) {
    try {
      status.value = Status.success;
      return _repository.updateCliente(cliente);
    } catch (e) {
      status.value = Status.error;
    }
    notifyListeners();
  }

  deleteCliente(int id) {
    try {
      bool result = _repository.deleteCliente(id) as bool;
      if (result) {
        status.value = Status.success;
        return result;
      }
    } catch (e) {
      status.value = Status.error;
    }
  }
}
