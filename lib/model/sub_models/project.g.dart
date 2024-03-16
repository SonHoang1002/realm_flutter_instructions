// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ProjectModel extends _ProjectModel
    with RealmEntity, RealmObjectBase, RealmObject {
  ProjectModel(
    int id,
    String name, {
    Iterable<Photos> photos = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set<RealmList<Photos>>(
        this, 'photos', RealmList<Photos>(photos));
  }

  ProjectModel._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  RealmList<Photos> get photos =>
      RealmObjectBase.get<Photos>(this, 'photos') as RealmList<Photos>;
  @override
  set photos(covariant RealmList<Photos> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<ProjectModel>> get changes =>
      RealmObjectBase.getChanges<ProjectModel>(this);

  @override
  ProjectModel freeze() => RealmObjectBase.freezeObject<ProjectModel>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ProjectModel._);
    return const SchemaObject(
        ObjectType.realmObject, ProjectModel, 'ProjectModel', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('photos', RealmPropertyType.object,
          linkTarget: 'Photos', collectionType: RealmCollectionType.list),
    ]);
  }
}
