// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frame_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Frame extends $Frame with RealmEntity, RealmObjectBase, RealmObject {
  Frame(
    int id,
    int x,
    int y,
    int width,
    int height,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'x', x);
    RealmObjectBase.set(this, 'y', y);
    RealmObjectBase.set(this, 'width', width);
    RealmObjectBase.set(this, 'height', height);
  }

  Frame._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  int get x => RealmObjectBase.get<int>(this, 'x') as int;
  @override
  set x(int value) => RealmObjectBase.set(this, 'x', value);

  @override
  int get y => RealmObjectBase.get<int>(this, 'y') as int;
  @override
  set y(int value) => RealmObjectBase.set(this, 'y', value);

  @override
  int get width => RealmObjectBase.get<int>(this, 'width') as int;
  @override
  set width(int value) => RealmObjectBase.set(this, 'width', value);

  @override
  int get height => RealmObjectBase.get<int>(this, 'height') as int;
  @override
  set height(int value) => RealmObjectBase.set(this, 'height', value);

  @override
  Stream<RealmObjectChanges<Frame>> get changes =>
      RealmObjectBase.getChanges<Frame>(this);

  @override
  Frame freeze() => RealmObjectBase.freezeObject<Frame>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Frame._);
    return const SchemaObject(ObjectType.realmObject, Frame, 'Frame', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('x', RealmPropertyType.int),
      SchemaProperty('y', RealmPropertyType.int),
      SchemaProperty('width', RealmPropertyType.int),
      SchemaProperty('height', RealmPropertyType.int),
    ]);
  }
}
