import 'package:flutter/material.dart';
import '../../core/constants/app_theme.dart';
import '../../core/widgets/custom_button.dart';
import '../../routes/app_routes.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final List<Map<String, dynamic>> _users = [
    {
      'id': '1',
      'name': 'John Doe',
      'email': 'john.doe@isatu.edu.ph',
      'role': 'Student',
      'status': 'Active',
    },
    {
      'id': '2',
      'name': 'Jane Smith',
      'email': 'jane.smith@isatu.edu.ph',
      'role': 'Student',
      'status': 'Active',
    },
    {
      'id': '3',
      'name': 'Mike Johnson',
      'email': 'mike.johnson@isatu.edu.ph',
      'role': 'Student',
      'status': 'Inactive',
    },
  ];

  final Map<String, dynamic> _stats = {
    'totalVoters': 1500,
    'registeredVoters': 2000,
    'votesCast': 1200,
    'activeElections': 2,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.notifications);
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.userSettings);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(),
            const SizedBox(height: AppTheme.spacingL),
            _buildStatistics(),
            const SizedBox(height: AppTheme.spacingL),
            _buildUserManagement(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.candidateManagement);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, Admin',
              style: AppTheme.headingStyle,
            ),
            const SizedBox(height: AppTheme.spacingS),
            Text(
              'Election Management System',
              style: AppTheme.subheadingStyle,
            ),
            const SizedBox(height: AppTheme.spacingM),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Manage Elections',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.electionSchedule);
                    },
                  ),
                ),
                const SizedBox(width: AppTheme.spacingM),
                Expanded(
                  child: CustomButton(
                    text: 'View Results',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.liveResults);
                    },
                    isOutlined: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatistics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Statistics',
          style: AppTheme.subheadingStyle,
        ),
        const SizedBox(height: AppTheme.spacingM),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: AppTheme.spacingM,
          crossAxisSpacing: AppTheme.spacingM,
          children: [
            _buildStatCard(
              'Total Voters',
              _stats['totalVoters'].toString(),
              Icons.people,
              AppTheme.primaryColor,
            ),
            _buildStatCard(
              'Registered Voters',
              _stats['registeredVoters'].toString(),
              Icons.person_add,
              AppTheme.secondaryColor,
            ),
            _buildStatCard(
              'Votes Cast',
              _stats['votesCast'].toString(),
              Icons.how_to_vote,
              AppTheme.accentColor,
            ),
            _buildStatCard(
              'Active Elections',
              _stats['activeElections'].toString(),
              Icons.event,
              Colors.orange,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: AppTheme.spacingS),
            Text(
              value,
              style: AppTheme.headingStyle.copyWith(
                color: color,
              ),
            ),
            Text(
              title,
              style: AppTheme.bodyStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserManagement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'User Management',
              style: AppTheme.subheadingStyle,
            ),
            TextButton.icon(
              onPressed: () {
                // TODO: Implement user search
              },
              icon: const Icon(Icons.search),
              label: const Text('Search'),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacingM),
        Card(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _users.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final user = _users[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(user['name'][0]),
                ),
                title: Text(user['name']),
                subtitle: Text(user['email']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Chip(
                      label: Text(user['role']),
                      backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                    ),
                    const SizedBox(width: AppTheme.spacingS),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.edit),
                                title: const Text('Edit User'),
                                onTap: () {
                                  Navigator.pop(context);
                                  // TODO: Implement edit user
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.delete),
                                title: const Text('Delete User'),
                                onTap: () {
                                  Navigator.pop(context);
                                  // TODO: Implement delete user
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
} 