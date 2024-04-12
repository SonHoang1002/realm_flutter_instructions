import 'package:realm_test/helpers/random_number.dart';
import 'package:realm_test/model/sub_models/frame_model.dart';
import 'package:realm_test/model/sub_models/photo_model.dart';
import 'package:realm_test/model/sub_models/project.dart';

class FlutterConvert {
  Photos convertJsonToPhotos(Map<String, dynamic> json) {
    dynamic url = json['url'];
    dynamic frame =
        json['frame'] != null ? convertJsonToFrame(json['frame']) : null;
    return Photos(randomInt(), url, frame: frame);
  }

  Frame convertJsonToFrame(Map<String, dynamic> json) {
    dynamic x = json['x'];
    dynamic y = json['y'];
    dynamic width = json['width'];
    dynamic height = json['height'];
    return Frame(randomInt(), x, y, width, height);
  }

  ProjectModel convertJsonToProjectModel(Map<String, dynamic> json) {
    dynamic name = json['name'];
    dynamic id = json['id'];
    List<Photos> photos = <Photos>[];
    if (json['photos'] != null) {
      json['photos'].forEach((v) {
        photos.add(convertJsonToPhotos(v));
      });
    }
    return ProjectModel(id, name, photos: photos);
  }
}
