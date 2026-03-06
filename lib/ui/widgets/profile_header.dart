import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      // Intenta de nuevo con el modo por defecto en caso de que externalApplication falle
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar con borde
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                padding: const EdgeInsets.all(4), // Ancho del borde
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.4 * _animation.value),
                      spreadRadius: 8 * _animation.value,
                      blurRadius: 20 * _animation.value,
                    ),
                  ],
                ),
                child: child,
              );
            },
            child: ClipOval(
              child: Image.asset(
                'assets/images/profile.jpg',
                width: 140,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    width: 140,
                    height: 140,
                    child: Icon(Icons.person, size: 80, color: Colors.grey),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Hi, I\'m Keury Deschamps',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            "I'm a passionate software developer with experience in web and app development. I specialize in technologies like React, Python, and modern web app development (like Flutter and Dart).",
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24), // Espacio antes de los iconos sociales

          // Iconos de redes sociales
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: FaIcon(FontAwesomeIcons.github, size: 30),
                onPressed: () => _launchURL('https://github.com/Keurydl'),
                tooltip: 'GitHub',
                color: Colors.white,
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.instagram, size: 30),
                onPressed: () => _launchURL('https://www.instagram.com/_keurydd_/'),
                tooltip: 'Instagram',
                color: Colors.purple, 
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.linkedin, size: 30),
                onPressed: () => _launchURL('https://www.linkedin.com/in/keury-david-deschamps-lopez-3891181b1/'),
                tooltip: 'LinkedIn',
                color: Colors.blue, 
              ),
            ],
          ),
          const SizedBox(height: 16), 
        ],
      ),
    );
  }
}