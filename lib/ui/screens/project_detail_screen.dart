import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portafolio_app/core/constants.dart';
import 'package:portafolio_app/data/models/project_model.dart';

class ProjectDetailScreen extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailScreen({super.key, required this.project});

  Future<void> _launchUrl() async {
    final Uri uri = Uri.parse(project.htmlUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch ${project.htmlUrl}');
    }
  }

  Color _getLanguageColor(String? language) {
    // duplicating logic for now, ideally move to utility or model
    switch (language?.toLowerCase()) {
      case 'dart': return Colors.blueAccent;
      case 'python': return Colors.yellowAccent;
      case 'javascript': return Colors.yellow;
      case 'html': return Colors.orange;
      case 'css': return Colors.blue;
      case 'java': return Colors.brown;
      case 'kotlin': return Colors.purple;
      case 'swift': return Colors.orangeAccent;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero animation for title if we wanted, but simple for now
            Text(
              project.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: AppConstants.smallPadding),
            if (project.language != null)
              Chip(
                label: Text(
                  project.language!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: _getLanguageColor(project.language).withOpacity(0.3),
              ),
            const SizedBox(height: AppConstants.defaultPadding),
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: AppConstants.smallPadding),
            Text(
              project.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton.icon(
                onPressed: _launchUrl,
                icon: const Icon(Icons.open_in_new),
                label: const Text('View on GitHub'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
