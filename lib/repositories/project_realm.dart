import 'package:chinhanh/model/sub_models/frame_model.dart';
import 'package:chinhanh/model/sub_models/photo_model.dart';
import 'package:chinhanh/model/sub_models/project.dart';
import 'package:realm/realm.dart';

class ProjectRealm {
  Realm? realm;

  void initRealm() {
    // init realm when realm hasn't inited
    if (realm == null) {
      var config = Configuration.local([
        ProjectModel.schema,
        Photos.schema,
        Frame.schema,
      ], schemaVersion: 2);
      realm = Realm(config);
    }
  }
  // CREATE
  ProjectModel addProject(ProjectModel projectModel) {
    initRealm();
    return realm!.write<ProjectModel>(() {
      return realm!.add<ProjectModel>(projectModel);
    });
  }
  // READ
  List<ProjectModel> getProjects() {
    initRealm();
    final items = realm!.all<ProjectModel>();
    List<ProjectModel> results = [];
    for (var item in items) {
      results.add(item);
    }
    return results;
  }

  ProjectModel getProjectById(int id) {
    initRealm();
    return realm!.find<ProjectModel>(id)!;
  }
  //UPDATE
  ProjectModel updateProject(ProjectModel projectModel) {
    initRealm();
    bool isHasItem = false;
    List<ProjectModel> allProject = getProjects();
    for (int i = 0; i < allProject.length; i++) {
      if (allProject[i].id == projectModel.id) {
        isHasItem = true;
      }
    }
    return realm!.write<ProjectModel>(() {
      return realm!.add<ProjectModel>(projectModel, update: isHasItem);
    });
  }
  // DELETE
  ProjectModel deleteProject(ProjectModel projectModel) {
    initRealm();
    bool isHasItem = false;
    List<ProjectModel> allProject = getProjects();
    for (int i = 0; i < allProject.length; i++) {
      if (allProject[i].id == projectModel.id) {
        isHasItem = true;
      }
    }
    if (isHasItem) {
      realm!.write(() {
        realm!.delete<ProjectModel>(projectModel);
      });
    }
    return projectModel;
  }
}
