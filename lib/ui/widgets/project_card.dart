import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portafolio_app/core/constants.dart';
import 'package:portafolio_app/data/models/project_model.dart';
import 'package:portafolio_app/ui/screens/project_detail_screen.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  // Keep _launchUrl for the button
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Color _getLanguageColor(String? language) {
    switch (language?.toLowerCase()) {
      case 'dart':
        return Colors.blueAccent;
      case 'python':
        return Colors.yellowAccent;
      case 'javascript':
        return Colors.yellow;
      case 'html':
        return Colors.orange;
      case 'css':
        return Colors.blue;
      case 'java':
        return Colors.brown;
      case 'kotlin':
        return Colors.purple;
      case 'swift':
        return Colors.orangeAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppConstants.cardElevation,
      margin: const EdgeInsets.symmetric(
        vertical: AppConstants.smallPadding,
        horizontal: AppConstants.defaultPadding,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectDetailScreen(project: project),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20, // Slightly larger
                    ),
              ),
              const SizedBox(height: AppConstants.smallPadding),
              Text(
                project.description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppConstants.defaultPadding),
              Row(
                children: [
                   if (project.language != null)
                    Chip(
                      label: Text(
                        project.language!,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      backgroundColor: _getLanguageColor(project.language).withOpacity(0.3),
                      side: BorderSide.none,
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () => _launchUrl(project.htmlUrl),
                    icon: const Icon(Icons.open_in_new, size: 16),
                    label: const Text('Ver Repositorio'),
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
