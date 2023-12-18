// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class ClienteModel {
  @Id()
  int id = 0;
  String? nome;
  int? idade;
  ClienteModel({
    this.nome,
    this.idade,
  });
}
