import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portafolio_app/ui/viewmodels/home_viewmodel.dart';
import 'package:portafolio_app/ui/widgets/project_card.dart';
import 'package:portafolio_app/ui/widgets/profile_header.dart';
import 'package:portafolio_app/ui/screens/training_screen.dart';
import 'package:portafolio_app/ui/screens/contact_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().loadProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'Keury',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
            Text(
              'My Portfolio',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: false, // Left aligned usually looks better for this style
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildProfileView(),
          _buildRepositoriesView(),
          const TrainingScreen(),
          const ContactScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Necessary when having > 3 items
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Principal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Repositorios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Training',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: 'Contact',
          ),
        ],
      ),
    );
  }

  Widget _buildProfileView() {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: const ProfileHeader(),
        ),
      ),
    );
  }

  Widget _buildRepositoriesView() {
    return Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.error != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${viewModel.error}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red[300]),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => viewModel.loadProjects(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (viewModel.projects.isEmpty) {
            return const Center(child: Text('No repositories found.'));
          }

          return RefreshIndicator(
            onRefresh: () => viewModel.loadProjects(),
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              itemCount: viewModel.projects.length,
              itemBuilder: (context, index) {
                final project = viewModel.projects[index];
                return ProjectCard(project: project);
              },
            ),
          );
        },
      );
  }
}
