import 'dart:developer';

import 'package:realm_test/model/sub_models/frame_model.dart';
import 'package:realm_test/model/sub_models/photo_model.dart';
import 'package:realm_test/model/sub_models/project.dart';
import 'package:realm/realm.dart';

class ProjectRealm {
  Realm? realm;

  ProjectRealm(){
    initRealm();
  }
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
  ProjectModel? addProject(ProjectModel projectModel) {
    log("delte project: $realm");

    final extieditem = getProjectById(projectModel.id);
    if (extieditem != null) {
      return null;
    }
    return realm!.write<ProjectModel>(() {
      return realm!.add<ProjectModel>(projectModel);
    });
  }

  // READ
  List<ProjectModel> getProjects() {
    final items = realm!.all<ProjectModel>();
    List<ProjectModel> results = [];
    for (var item in items) {
      results.add(item);
      print(item.id.toString());
    }
    return results;
  }

  ProjectModel? getProjectById(int id) {
    initRealm();
    return realm!.find<ProjectModel>(id);
  }

  //UPDATE
  ProjectModel updateProject(ProjectModel projectModel) {
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
    log("delte project: $realm");
    bool isHasItem = false;
    int index = -1;
    List<ProjectModel> allProject = getProjects();
    for (int i = 0; i < allProject.length; i++) {
      if (allProject[i].id == projectModel.id) {
        isHasItem = true;
        index = i;
        break;
      }
    }
    if (isHasItem&& index!=-1) {
      realm!.write(() {
        realm!.delete<ProjectModel>(allProject[index]);
      });
    }
    return projectModel;
  }
}
