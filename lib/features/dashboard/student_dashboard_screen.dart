import 'package:flutter/material.dart';
import '../../core/constants/app_theme.dart';
import '../../core/widgets/custom_button.dart';
import '../../routes/app_routes.dart';

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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Vote'),
        content: const Text('Are you sure you want to cast your vote? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey[700],
            ),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                final candidate = _candidates.firstWhere((c) => c['id'] == candidateId);
                candidate['hasVoted'] = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Vote cast successfully'),
                  backgroundColor: Color(0xFF2E7D32), // Darker green for better contrast
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1565C0), // Darker blue for better contrast
              foregroundColor: Colors.white,
              elevation: 2,
            ),
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
        title: const Text(
          'Student Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1565C0), // Darker blue for better contrast
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.notifications);
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.userSettings);
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
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
        gradient: const LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF0D47A1)], // Darker gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome, John Doe',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppTheme.spacingS),
          const Text(
            'Student Council Election 2024',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
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
        padding: const EdgeInsets.all(AppTheme.spacingM),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: Colors.white),
            const SizedBox(width: AppTheme.spacingS),
            Column(
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
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
        child: Text(
          'No candidates for this position',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
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
      elevation: 4,
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
                  radius: 32,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: NetworkImage(candidate['image']),
                ),
                const SizedBox(width: AppTheme.spacingM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        candidate['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF212121), // Dark text for contrast
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        candidate['party'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF616161), // Medium gray for secondary text
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!candidate['hasVoted'])
                  ElevatedButton(
                    onPressed: () => _handleVote(candidate['id']),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1565C0), // Darker blue
                      foregroundColor: Colors.white,
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
                      ),
                    ),
                    child: const Text(
                      'Vote',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E7D32), // Darker green
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Voted',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingM),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Votes: ${candidate['votes']}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF424242), // Darker gray for better readability
                    fontWeight: FontWeight.w600,
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
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF1565C0), // Darker blue for links
                  ),
                  icon: const Icon(Icons.person, size: 18),
                  label: const Text(
                    'View Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}