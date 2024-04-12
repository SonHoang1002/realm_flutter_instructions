import 'package:realm_test/repositories/project_realm.dart';
import 'package:realm_test/view/screen1.dart';
import 'package:flutter/material.dart';

void main() {
  final projectRealm = ProjectRealm();
  runApp(MaterialApp(
    home: ProjectListWidget(projectRealm: projectRealm),
  ));
}
