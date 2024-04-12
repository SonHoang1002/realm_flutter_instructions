import 'dart:convert';

import 'package:realm_dart/src/realm_class.dart';
import 'package:realm_test/helpers/convert.dart';
import 'package:realm_test/helpers/random_number.dart';
import 'package:realm_test/model/sub_models/project.dart';
import 'package:realm_test/repositories/project_realm.dart';
import 'package:realm_test/view/screen2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProjectListWidget extends StatefulWidget {
  final ProjectRealm projectRealm;
  ProjectListWidget({Key? key, required this.projectRealm}) : super(key: key);
  @override
  _ProjectListWidgetState createState() => _ProjectListWidgetState();
}

class _ProjectListWidgetState extends State<ProjectListWidget> {
  List<ProjectModel> projects = [];

  Future<void> fetchProjects() async {
    final response =
        await http.get(Uri.parse('https://tapuniverse.com/xproject'));
    if (response.statusCode == 200) {
      List<dynamic> abc = json.decode(response.body)['projects'];
      for (int i = 0; i < abc.length; i++) {
        ProjectModel item = FlutterConvert().convertJsonToProjectModel(abc[i]);
        projects.add(item);
        widget.projectRealm.addProject(item);
      }
      setState(() {});
    } else {
      throw Exception('Failed to load projects');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProjects();
  }

  void addProject(String projectName) {
    final newProject = ProjectModel(randomInt(), projectName);
    setState(() {
      projects.add(newProject);
    });
    widget.projectRealm.addProject(newProject);
  }

  void removeProject(int index) {
    final projectModel = projects[index];
    setState(() {
      projects.removeAt(index);
    });
    widget.projectRealm.deleteProject(projectModel);
  }

  void editProject(int index, String newName) {
    setState(() {
      projects[index].name = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project List'),
        actions: [
          IconButton(
              onPressed: () {
                widget.projectRealm.getProjects();
              },
              icon: Icon(Icons.abc))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: projects.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(projects[index].id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    removeProject(index);
                  },
                  background: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    ),
                  ),
                  child: Card(
                    child: ListTile(
                      title: Text(projects[index].name),
                      subtitle: Text('ID: ${projects[index].id}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProjectDetailsScreen(
                              projectId: projects[index].id,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Add Project'),
                      content: TextField(
                        autofocus: true,
                        decoration:
                            const InputDecoration(labelText: 'Project Name'),
                        onSubmitted: (String value) {
                          addProject(value);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                );
              },
              child: const Text('Add Project'),
            ),
          ),
        ],
      ),
    );
  }
}
