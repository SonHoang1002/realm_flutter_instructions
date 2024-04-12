import 'package:realm/realm.dart';

part 'frame_model.g.dart';

@RealmModel()
class $Frame {
  @PrimaryKey()
  late int id;
  late int x;
  late int y;
  late int width;
  late int height;

}