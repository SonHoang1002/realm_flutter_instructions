import 'package:realm_test/model/sub_models/photo_model.dart';
import 'package:realm/realm.dart';

part "project.g.dart";

@RealmModel()
class _ProjectModel {
  @PrimaryKey()
  late int id;
  late String name;
  late List<$Photos> photos;
}

 
 
