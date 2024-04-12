import 'package:realm_test/model/sub_models/frame_model.dart';
import 'package:realm/realm.dart';

part 'photo_model.g.dart';
 
@RealmModel()
class $Photos {
  @PrimaryKey()
  late int id;
  late dynamic media;
  late $Frame? frame;
}
