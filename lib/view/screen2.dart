import 'dart:convert';
import 'package:realm_test/helpers/convert.dart';
import 'package:realm_test/model/sub_models/project.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProjectDetailsScreen extends StatefulWidget {
  final int projectId;
  const ProjectDetailsScreen({super.key, required this.projectId});

  @override
  // ignore: library_private_types_in_public_api
  _ProjectDetailsScreenState createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  ProjectModel? _projectDetails;
  double _scale = 1.0;
  double _previousScale = 1.0;
  double _rotation = 0.0;
  double _previousRotation = 0.0;
  int? _selectedImageIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _projectDetails = await _fetchProjectDetails(widget.projectId);
      setState(() {});
    });
  }

  Future<ProjectModel> _fetchProjectDetails(int projectId) async {
    final response = await http.post(
      Uri.parse('https://tapuniverse.com/xprojectdetail'),
      body: {'id': projectId.toString()},
    );
    if (response.statusCode == 200) {
      final photo = json.decode(response.body);
      if (photo['photos'] != null) {
        return FlutterConvert().convertJsonToProjectModel(photo);
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load project details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: const Text('Project Details'),
      // ),
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          children: [
            Container(
              height: 40,
              alignment: Alignment.centerLeft,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "back",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )),
            ),
            Expanded(
              child: (_projectDetails == null)
                  ? const Center(child: CircularProgressIndicator())
                  : GestureDetector(
                      onTapDown: _onTapDown,
                      onTapUp: _onTapUp,
                      onScaleStart: _onScaleStart,
                      onScaleUpdate: _onScaleUpdate,
                      child: Stack(
                        children: _projectDetails!.photos
                            .asMap()
                            .entries
                            .map((entry) {
                          final index = entry.key;
                          final photo = entry.value;
                          final imageUrl = photo.url;
                          final imageFrame = photo.frame!;
                          final isSelected = index == _selectedImageIndex;
                          return Positioned(
                            top: imageFrame.y.toDouble(),
                            left: imageFrame.x.toDouble(),
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () => _onImageTap(index),
                                  child: Transform.rotate(
                                    angle: _rotation,
                                    child: Transform.scale(
                                      scale: _scale,
                                      child: Image.network(
                                        imageUrl,
                                        width: imageFrame.width.toDouble(),
                                        height: imageFrame.height.toDouble(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Container(
                                    width: imageFrame.width.toDouble(),
                                    height: imageFrame.height.toDouble(),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 4.0,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _onScaleStart(ScaleStartDetails details) {
    _previousScale = _scale;
    _previousRotation = _rotation;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = _previousScale * details.scale;
      _rotation = _previousRotation + details.rotation;
    });
  }

  void _onTapDown(TapDownDetails details) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      _selectedImageIndex = _getTappedImageIndex(localOffset);
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _selectedImageIndex = null;
    });
  }

  int? _getTappedImageIndex(Offset localOffset) {
    for (int i = 0; i < _projectDetails!.photos.length; i++) {
      final imageFrame = _projectDetails!.photos[i].frame!;
      if (localOffset.dx >= imageFrame.x &&
          localOffset.dx <= imageFrame.x + imageFrame.width &&
          localOffset.dy >= imageFrame.y &&
          localOffset.dy <= imageFrame.y + imageFrame.height) {
        return i;
      }
    }
    return null;
  }

  void _onImageTap(int index) {
    setState(() {
      _selectedImageIndex = index;
    });
  }
}
