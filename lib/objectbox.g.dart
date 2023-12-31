// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'entities/cliente_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 1832137435616380393),
      name: 'ClienteModel',
      lastPropertyId: const IdUid(3, 6752644625874513796),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4094348316479994214),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1707464791926323692),
            name: 'nome',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 6752644625874513796),
            name: 'idade',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Shortcut for [Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [Store.new] for an explanation of all parameters.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// Returns the ObjectBox model definition for this project for use with
/// [Store.new].
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 1832137435616380393),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    ClienteModel: EntityDefinition<ClienteModel>(
        model: _entities[0],
        toOneRelations: (ClienteModel object) => [],
        toManyRelations: (ClienteModel object) => {},
        getId: (ClienteModel object) => object.id,
        setId: (ClienteModel object, int id) {
          object.id = id;
        },
        objectToFB: (ClienteModel object, fb.Builder fbb) {
          final nomeOffset =
              object.nome == null ? null : fbb.writeString(object.nome!);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nomeOffset);
          fbb.addInt64(2, object.idade);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final nomeParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 6);
          final idadeParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 8);
          final object = ClienteModel(nome: nomeParam, idade: idadeParam)
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [ClienteModel] entity fields to define ObjectBox queries.
class ClienteModel_ {
  /// see [ClienteModel.id]
  static final id =
      QueryIntegerProperty<ClienteModel>(_entities[0].properties[0]);

  /// see [ClienteModel.nome]
  static final nome =
      QueryStringProperty<ClienteModel>(_entities[0].properties[1]);

  /// see [ClienteModel.idade]
  static final idade =
      QueryIntegerProperty<ClienteModel>(_entities[0].properties[2]);
}
