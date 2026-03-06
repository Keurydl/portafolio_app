import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:portafolio_app/data/models/project_model.dart';

class ProjectRepository {
  static const String _baseUrl = 'https://api.github.com/users/Keurydl/repos';

  Future<List<ProjectModel>> getProjects() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ProjectModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load projects: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to GitHub: $e');
    }
  }
}
