// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Photos extends $Photos with RealmEntity, RealmObjectBase, RealmObject {
  Photos(
    int id,
    String url, {
    Frame? frame,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'url', url);
    RealmObjectBase.set(this, 'frame', frame);
  }

  Photos._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get url => RealmObjectBase.get<String>(this, 'url') as String;
  @override
  set url(String value) => RealmObjectBase.set(this, 'url', value);

  @override
  Frame? get frame => RealmObjectBase.get<Frame>(this, 'frame') as Frame?;
  @override
  set frame(covariant Frame? value) =>
      RealmObjectBase.set(this, 'frame', value);

  @override
  Stream<RealmObjectChanges<Photos>> get changes =>
      RealmObjectBase.getChanges<Photos>(this);

  @override
  Photos freeze() => RealmObjectBase.freezeObject<Photos>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Photos._);
    return const SchemaObject(ObjectType.realmObject, Photos, 'Photos', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('url', RealmPropertyType.string),
      SchemaProperty('frame', RealmPropertyType.object,
          optional: true, linkTarget: 'Frame'),
    ]);
  }
}
