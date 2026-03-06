class ProjectModel {
  final int id;
  final String name;
  final String description;
  final String htmlUrl;
  final String? language;

  ProjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.htmlUrl,
    this.language,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] ?? 'Sin descripción',
      htmlUrl: json['html_url'] as String,
      language: json['language'] as String?,
    );
  }
}
