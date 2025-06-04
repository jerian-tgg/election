import 'package:flutter/material.dart';
import '../../core/constants/app_theme.dart';
import '../../core/widgets/custom_button.dart';
import '../../routes/app_routes.dart';
import '../history/voter_history_screen.dart';

class StudentDashboardScreen extends StatefulWidget {
  const StudentDashboardScreen({super.key});

  @override
  State<StudentDashboardScreen> createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _positions = [
    'President',
    'Vice President',
    'Secretary',
    'Treasurer',
    'Auditor',
  ];

  final List<Map<String, dynamic>> _candidates = [
    {
      'id': '1',
      'name': 'John Smith',
      'position': 'President',
      'party': 'Student Alliance',
      'image': 'https://via.placeholder.com/150',
      'hasVoted': false,
      'votes': 245,
    },
    {
      'id': '2',
      'name': 'Sarah Johnson',
      'position': 'President',
      'party': 'Progressive Students',
      'image': 'https://via.placeholder.com/150',
      'hasVoted': false,
      'votes': 189,
    },
    {
      'id': '3',
      'name': 'Michael Chen',
      'position': 'Vice President',
      'party': 'Student Alliance',
      'image': 'https://via.placeholder.com/150',
      'hasVoted': true,
      'votes': 156,
    },
    {
      'id': '4',
      'name': 'Emily Davis',
      'position': 'Vice President',
      'party': 'Progressive Students',
      'image': 'https://via.placeholder.com/150',
      'hasVoted': false,
      'votes': 120,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _positions.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleVote(String candidateId) {
    final candidate = _candidates.firstWhere((c) => c['id'] == candidateId);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Vote'),
        content: const Text('Are you sure you want to cast your vote? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                candidate['hasVoted'] = true;
              });

              // Show success dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Vote Successful'),
                  content: Text('You voted for ${candidate['name']} for ${candidate['position']}.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VoterHistoryScreen(),
                ),
              );
            },
            tooltip: 'Voter History',
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.notifications);
            },
            tooltip: 'Notifications',
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.userSettings);
            },
            tooltip: 'Settings',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: _positions.map((position) => Tab(text: position)).toList(),
        ),
      ),
      body: Column(
        children: [
          _buildWelcomeCard(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _positions.map((position) {
                final candidates = _candidates.where((c) => c['position'] == position).toList();
                return _buildCandidateList(candidates);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, John Doe',
            style: AppTheme.headingStyle.copyWith(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: AppTheme.spacingS),
          Text(
            'Student Council Election 2024',
            style: AppTheme.subheadingStyle.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: AppTheme.spacingM),
          Row(
            children: [
              _buildInfoChip(
                'Time Remaining',
                '2h 30m',
                Icons.timer,
                Colors.white,
              ),
              const SizedBox(width: AppTheme.spacingM),
              _buildInfoChip(
                'Positions',
                _positions.length.toString(),
                Icons.how_to_vote,
                Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingS),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: AppTheme.spacingXS),
            Column(
              children: [
                Text(
                  value,
                  style: AppTheme.bodyStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: AppTheme.captionStyle.copyWith(
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCandidateList(List<Map<String, dynamic>> candidates) {
    if (candidates.isEmpty) {
      return const Center(
        child: Text('No candidates for this position'),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      child: Column(
        children: candidates.map((candidate) => _buildCandidateCard(candidate)).toList(),
      ),
    );
  }

  Widget _buildCandidateCard(Map<String, dynamic> candidate) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(candidate['image']),
                ),
                const SizedBox(width: AppTheme.spacingM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        candidate['name'],
                        style: AppTheme.subheadingStyle,
                      ),
                      Text(
                        candidate['party'],
                        style: AppTheme.bodyStyle.copyWith(
                          color: AppTheme.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!candidate['hasVoted'])
                  ElevatedButton(
                    onPressed: () => _handleVote(candidate['id']),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
                      ),
                    ),
                    child: const Text('Vote'),
                  )
                else
                  const Chip(
                    label: Text('Voted'),
                    backgroundColor: Colors.green,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingM),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Votes: ${candidate['votes']}',
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.candidateProfile,
                      arguments: {
                        'candidateId': candidate['id'],
                        'candidateName': candidate['name'],
                        'candidateImage': candidate['image'],
                        'candidatePosition': candidate['position'],
                        'candidateDescription': candidate['party'],
                      },
                    );
                  },
                  icon: const Icon(Icons.person),
                  label: const Text('View Profile'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}