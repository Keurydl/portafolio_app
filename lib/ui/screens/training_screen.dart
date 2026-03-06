import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      children: [
        const Text(
          'Training 🎓',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        _buildTrainingCard(
          context,
          title: 'Dominican University O&M',
          subtitle: 'Studying Systems and Computer Engineering',
          date: 'Current situation',
        ),
        _buildTrainingCard(
          context,
          title: 'Pontificia Universidad Católica Madre y Maestra (PUCMM)',
          subtitle: 'Studying Multiplatform Applications at the Center for Technology and Continuing Education (TEP)',
          date: '2023-2025',
          certificateUrl: 'https://drive.google.com/file/d/1yWMBb0LobGhy4V3ZTn6_nuZhRY3OXwot/view',
        ),
        _buildTrainingCard(
          context,
          title: 'Colegio Episcopal La Anunciación',
          subtitle: 'Graduated from 6th grade of Secondary School',
          date: '2011-2023',
          certificateUrl: 'https://drive.google.com/file/d/15HCgDslFFD1HrW78Jig2P6KDYdQ3KqLm/view',
        ),
        _buildTrainingCard(
          context,
          title: 'Centro Dominico Americano',
          subtitle: 'English Course',
          date: '2017-2025',
          certificateUrl: 'https://drive.google.com/file/d/15sfC2Rg0Rom6j4efTm1yhA7iBDQa1oPL/view',
        ),
      ],
    );
  }

  Widget _buildTrainingCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String date,
    String? certificateUrl,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    date,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8),
                height: 1.4,
              ),
            ),
            if (certificateUrl != null) ...[
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => _launchURL(certificateUrl),
                  icon: const Icon(Icons.workspace_premium, size: 18),
                  label: const Text('View certificate'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
