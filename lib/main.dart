// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'repositories/cliente_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final clienteRepository = ClienteRepository();
  await clienteRepository.openBox();
  runApp(MyApp(clienteRepository: clienteRepository));
}

class MyApp extends StatelessWidget {
  final ClienteRepository clienteRepository;
  const MyApp({
    super.key,
    required this.clienteRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo CRUD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(
          title: 'Cadastro de Clientes', clienteRepository: clienteRepository),
    );
  }
}
