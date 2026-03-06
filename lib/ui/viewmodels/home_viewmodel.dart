import 'package:flutter/material.dart';
import 'package:portafolio_app/data/models/project_model.dart';
import 'package:portafolio_app/data/repositories/project_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final ProjectRepository _repository;

  HomeViewModel(this._repository);

  List<ProjectModel> _projects = [];
  bool _isLoading = false;
  String? _error;

  List<ProjectModel> get projects => _projects;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadProjects() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _projects = await _repository.getProjects();
    } catch (e) {
      _error = 'Failed to load projects: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
