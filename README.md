# Flutter CRUD com Banco de Dados ObjectBox

Este projeto Flutter é um exemplo simples de um aplicativo que realiza operações CRUD (Create, Read, Update, Delete) em um cadastro de clientes. O banco de dados utilizado é o [ObjectBox](https://objectbox.io/), uma biblioteca de banco de dados rápida e eficiente para Flutter.

## Funcionalidades

- Adição de clientes ao banco de dados.
- Visualização da lista de clientes cadastrados.
- Atualização das informações dos clientes.
- Remoção de clientes do banco de dados.

## Pré-requisitos

- Certifique-se de ter o Flutter instalado. Caso contrário, siga as instruções em [flutter.dev](https://flutter.dev/docs/get-started/install).
- Este projeto utiliza o ObjectBox como banco de dados. Certifique-se de adicionar as dependências ao seu arquivo `pubspec.yaml`:

```yaml
dependencies:
  build_runner: ^2.4.7
  objectbox_generator: any
  objectbox_flutter_libs: any
  path_provider: ^2.1.1
  objectbox: ^2.4.0
```

## Execute os seguintes comando do terminal:
## Clone este repositório:
```
git clone https://github.com/seu-usuario/seu-projeto-flutter.git
cd seu-projeto-flutter
```

## Instale as dependências, adicionando o seguinte no arquivo `pubspec.yaml`:
```yaml
dependencies:
  build_runner: ^2.4.7
  objectbox_generator: any
  objectbox_flutter_libs: any
  path_provider: ^2.1.1
  objectbox: ^2.4.0
```

## Execute o aplicativo:
```
flutter run
```

## Contribuição
:blush: Contribuições são bem-vindas! Sinta-se à vontade para abrir issues e pull requests.
